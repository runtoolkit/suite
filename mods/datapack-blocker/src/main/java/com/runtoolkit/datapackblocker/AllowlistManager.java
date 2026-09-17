package com.runtoolkit.datapackblocker;

import org.slf4j.Logger;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;

/**
 * Enforces a simple "lock the datapacks folder" policy for a single world:
 *
 * <ol>
 *   <li>On the first run for a world, every top-level entry currently in the
 *       {@code datapacks/} folder (a directory or a {@code .zip}) is recorded
 *       as the allowlist and treated as "existing, trusted content".</li>
 *   <li>On every run after that, the {@code datapacks/} folder is compared
 *       against the allowlist. Anything not on the allowlist is moved out
 *       into a quarantine folder under the world save root instead of being
 *       left in place for the server to load.</li>
 *   <li>Everything that remains (the allowlisted packs) has its write
 *       permission stripped recursively, so the files can't be edited or
 *       deleted in place without an operator explicitly unlocking them
 *       first.</li>
 * </ol>
 *
 * <p><b>Scope/limitations (read before relying on this for anything but a
 * single-operator server):</b>
 * <ul>
 *   <li>Enforcement runs at server start. A pack dropped into the folder
 *       while the server is already running and picked up by a mid-session
 *       {@code /reload} is <em>not</em> caught until the next restart.</li>
 *   <li>"Read-only" is best-effort via {@link java.io.File#setWritable}.
 *       On POSIX filesystems this also strips the directory's write bit,
 *       which blocks adding/removing files inside it. On Windows this
 *       maps to the read-only file attribute, which does not by itself
 *       block writes into an existing directory the same way - treat this
 *       as a tamper deterrent and an audit trail, not a hard security
 *       boundary. It also does nothing against anyone with filesystem
 *       access to the host outside the game (e.g. shell/FTP access).</li>
 *   <li>This only ever compares directory entries by name; it does not
 *       hash contents, so an allowlisted pack that was edited before this
 *       mod's first run on that world will be locked as-is.</li>
 * </ul>
 */
public final class AllowlistManager {

    private static final String STATE_DIR_NAME = "datapack_blocker";
    private static final String ALLOWLIST_FILE_NAME = "allowlist.txt";
    private static final String QUARANTINE_DIR_NAME = "quarantine";

    private final Path datapacksDir;
    private final Path stateDir;
    private final Path allowlistFile;
    private final Logger logger;

    public AllowlistManager(Path datapacksDir, Path worldSaveRoot, Logger logger) {
        this.datapacksDir = datapacksDir;
        this.stateDir = worldSaveRoot.resolve(STATE_DIR_NAME);
        this.allowlistFile = stateDir.resolve(ALLOWLIST_FILE_NAME);
        this.logger = logger;
    }

    /** Result of one enforcement pass, for logging/commands. */
    public record Result(boolean firstRun, List<String> protectedPacks, List<String> quarantinedPacks) {}

    /**
     * Runs one full enforcement pass: establishes or loads the allowlist,
     * quarantines anything new, and locks everything that's left.
     */
    public Result enforce() throws IOException {
        Files.createDirectories(stateDir);

        boolean firstRun = !Files.exists(allowlistFile);
        List<String> currentEntries = listTopLevelEntries(datapacksDir);

        Set<String> allowlist;
        if (firstRun) {
            allowlist = new TreeSet<>(currentEntries);
            writeAllowlist(allowlist);
            logger.info("Datapack Blocker: first run for this world - capturing {} existing datapack(s) as the baseline allowlist.",
                    allowlist.size());
        } else {
            allowlist = readAllowlist();
        }

        List<String> quarantined = new ArrayList<>();
        for (String entry : currentEntries) {
            if (!allowlist.contains(entry)) {
                quarantineEntry(entry);
                quarantined.add(entry);
            }
        }

        List<String> stillPresent = listTopLevelEntries(datapacksDir);
        List<String> protectedPacks = new ArrayList<>();
        for (String entry : stillPresent) {
            if (allowlist.contains(entry)) {
                lockEntry(entry);
                protectedPacks.add(entry);
            }
        }

        if (!quarantined.isEmpty()) {
            logger.warn("Datapack Blocker: quarantined {} datapack(s) not on the allowlist: {}. " +
                            "They were not loaded. Use /datapackblocker approve <name> to allow and load one after review.",
                    quarantined.size(), quarantined);
        }
        logger.info("Datapack Blocker: {} allowlisted datapack(s) locked read-only.", protectedPacks.size());

        return new Result(firstRun, protectedPacks, quarantined);
    }

    /** Restores write permission on every allowlisted pack, for maintenance. */
    public List<String> unlock() throws IOException {
        Set<String> allowlist = readAllowlist();
        List<String> unlocked = new ArrayList<>();
        for (String entry : listTopLevelEntries(datapacksDir)) {
            if (allowlist.contains(entry)) {
                setWritableRecursive(datapacksDir.resolve(entry), true);
                unlocked.add(entry);
            }
        }
        logger.info("Datapack Blocker: unlocked {} datapack(s) for editing. Run /datapackblocker lock when done.", unlocked.size());
        return unlocked;
    }

    /** Re-locks every allowlisted pack after a maintenance window. */
    public List<String> lock() throws IOException {
        Set<String> allowlist = readAllowlist();
        List<String> locked = new ArrayList<>();
        for (String entry : listTopLevelEntries(datapacksDir)) {
            if (allowlist.contains(entry)) {
                lockEntry(entry);
                locked.add(entry);
            }
        }
        return locked;
    }

    /**
     * Approves a quarantined pack by name: moves it back into the datapacks
     * folder, adds it to the allowlist, and locks it. Returns false if no
     * quarantined entry with that name was found.
     */
    public boolean approve(String name) throws IOException {
        Path quarantineRoot = stateDir.resolve(QUARANTINE_DIR_NAME);
        if (!Files.isDirectory(quarantineRoot)) {
            return false;
        }
        try (DirectoryStream<Path> batches = Files.newDirectoryStream(quarantineRoot)) {
            for (Path batch : batches) {
                Path candidate = batch.resolve(name);
                if (Files.exists(candidate)) {
                    Path destination = datapacksDir.resolve(name);
                    Files.move(candidate, destination, StandardCopyOption.REPLACE_EXISTING);
                    Set<String> allowlist = readAllowlist();
                    allowlist.add(name);
                    writeAllowlist(allowlist);
                    lockEntry(name);
                    logger.info("Datapack Blocker: '{}' approved, restored, and locked. Run /reload to load it.", name);
                    return true;
                }
            }
        }
        return false;
    }

    /** Lists names currently sitting in quarantine, across all batches. */
    public List<String> listQuarantined() throws IOException {
        Path quarantineRoot = stateDir.resolve(QUARANTINE_DIR_NAME);
        if (!Files.isDirectory(quarantineRoot)) {
            return List.of();
        }
        List<String> names = new ArrayList<>();
        try (DirectoryStream<Path> batches = Files.newDirectoryStream(quarantineRoot)) {
            for (Path batch : batches) {
                names.addAll(listTopLevelEntries(batch));
            }
        }
        return names;
    }

    // -- internals --------------------------------------------------------

    private void quarantineEntry(String name) throws IOException {
        Path batchDir = stateDir.resolve(QUARANTINE_DIR_NAME).resolve(String.valueOf(Instant.now().toEpochMilli()));
        Files.createDirectories(batchDir);
        Path source = datapacksDir.resolve(name);
        Path destination = batchDir.resolve(name);
        Files.move(source, destination, StandardCopyOption.REPLACE_EXISTING);
    }

    private void lockEntry(String name) throws IOException {
        setWritableRecursive(datapacksDir.resolve(name), false);
    }

    private void setWritableRecursive(Path root, boolean writable) throws IOException {
        if (!Files.exists(root)) {
            return;
        }
        if (Files.isDirectory(root)) {
            try (var stream = Files.walk(root)) {
                for (Path path : (Iterable<Path>) stream::iterator) {
                    // Always leave the entry itself readable; only toggle write access.
                    path.toFile().setWritable(writable, false);
                }
            }
        } else {
            root.toFile().setWritable(writable, false);
        }
    }

    private List<String> listTopLevelEntries(Path dir) throws IOException {
        if (!Files.isDirectory(dir)) {
            return List.of();
        }
        try (DirectoryStream<Path> stream = Files.newDirectoryStream(dir)) {
            List<String> names = new ArrayList<>();
            for (Path path : stream) {
                String name = path.getFileName().toString();
                if (name.startsWith(".")) {
                    continue; // ignore OS/editor artifacts (.DS_Store etc.)
                }
                names.add(name);
            }
            return names;
        }
    }

    private Set<String> readAllowlist() throws IOException {
        if (!Files.exists(allowlistFile)) {
            return new LinkedHashSet<>();
        }
        return Files.readAllLines(allowlistFile, StandardCharsets.UTF_8).stream()
                .map(String::strip)
                .filter(line -> !line.isEmpty())
                .collect(Collectors.toCollection(LinkedHashSet::new));
    }

    private void writeAllowlist(Set<String> allowlist) throws IOException {
        Files.write(allowlistFile, allowlist, StandardCharsets.UTF_8);
    }
}
