package com.runtoolkit.rtwrapper.api;

import com.runtoolkit.rtwrapper.RTWrapper;

import java.time.Instant;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

/**
 * Records every dispatch attempt: who, when, what command, and the
 * outcome. The datapack had no equivalent — the only trace of a wrapper
 * call was whatever scoreboard counters load.mcfunction set up
 * (#rtw.processed / #rtw.errors, mirrored here by RTWrapperConfig), which
 * tell you *how many* things ran, never *what* or *by whom*. That made
 * the datapack's permission gap (see RTCommand's Javadoc) unauditable
 * even after the fact — an op-level command dispatched by an unintended
 * caller left no record beyond the raw increment.
 *
 * Kept as a bounded in-memory ring buffer plus a logger line per entry.
 * Not a database or file-backed store on purpose: RTWrapper has no
 * persistence layer elsewhere (RTWrapperConfig's counters are also
 * in-memory only, reset on restart), so this matches the mod's existing
 * durability guarantees rather than introducing a new one. Server owners
 * who need a durable trail already get one for free via the logger line,
 * which lands wherever the server's own log configuration sends it.
 */
public final class AuditLog {

    private AuditLog() {}

    public record Entry(
            Instant timestamp,
            String sourceName,
            int sourcePermissionLevel,
            String commandLiteral,
            List<String> args,
            RTDispatchResult.Status status,
            String detail
    ) {}

    private static final int MAX_ENTRIES = 500;
    private static final Deque<Entry> ENTRIES = new ArrayDeque<>();

    public static synchronized void record(String sourceName, int sourcePermissionLevel,
                                            String commandLiteral, List<String> args,
                                            RTDispatchResult result) {
        Entry entry = new Entry(
                Instant.now(),
                sourceName,
                sourcePermissionLevel,
                commandLiteral,
                List.copyOf(args),
                result.status(),
                result.message()
        );
        ENTRIES.addLast(entry);
        if (ENTRIES.size() > MAX_ENTRIES) {
            ENTRIES.removeFirst();
        }

        // Admin-tier commands (see RTCommand) are logged at a higher
        // visibility than routine ones, since these are exactly the calls
        // the datapack's missing allowlist/permission check used to let
        // through unaudited.
        boolean isSensitive = sourcePermissionLevel >= 4 || result.status() != RTDispatchResult.Status.SUCCESS;
        String line = String.format("[audit] %s (perm %d) -> %s %s => %s%s",
                sourceName, sourcePermissionLevel, commandLiteral, args,
                result.status(), result.message() != null ? " (" + result.message() + ")" : "");
        if (isSensitive) {
            RTWrapper.LOGGER.warn(line);
        } else {
            RTWrapper.LOGGER.info(line);
        }
    }

    public static synchronized List<Entry> recent(int count) {
        List<Entry> all = new ArrayList<>(ENTRIES);
        int from = Math.max(0, all.size() - count);
        return List.copyOf(all.subList(from, all.size()));
    }

    public static synchronized List<Entry> all() {
        return List.copyOf(ENTRIES);
    }

    public static synchronized void clear() {
        ENTRIES.clear();
    }
}
