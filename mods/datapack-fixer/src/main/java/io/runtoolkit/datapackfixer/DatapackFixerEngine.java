package io.runtoolkit.datapackfixer;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

public final class DatapackFixerEngine {
    private static final Gson JSON = new GsonBuilder().setPrettyPrinting().create();
    private static final Map<String, String> DIRECTORY_RENAMES = Map.ofEntries(
            Map.entry("advancements", "advancement"), Map.entry("functions", "function"),
            Map.entry("item_modifiers", "item_modifier"), Map.entry("loot_tables", "loot_table"),
            Map.entry("predicates", "predicate"), Map.entry("recipes", "recipe"),
            Map.entry("structures", "structure"), Map.entry("tags/blocks", "tags/block"),
            Map.entry("tags/entity_types", "tags/entity_type"), Map.entry("tags/fluids", "tags/fluid"),
            Map.entry("tags/functions", "tags/function"), Map.entry("tags/game_events", "tags/game_event"),
            Map.entry("tags/items", "tags/item")
    );
    private static final Map<String, String> EXACT_REPLACEMENTS = Map.of(
            "minecraft:type_specific/slime", "minecraft:type_specific/cube_mob",
            "\"condition\": \"minecraft:alternative\"", "\"condition\": \"minecraft:any_of\""
    );

    public FixResult fix(Path datapacksDirectory, Path backupRoot) throws IOException {
        if (!Files.isDirectory(datapacksDirectory)) return new FixResult(0, 0, List.of("Datapacks directory does not exist."));
        List<Path> packs;
        try (Stream<Path> stream = Files.list(datapacksDirectory)) {
            packs = stream.filter(Files::isDirectory).toList();
        }
        Path backup = backupRoot.resolve(Instant.now().toString().replace(':', '-'));
        Files.createDirectories(backup);
        int changed = 0;
        List<String> audit = new ArrayList<>();
        for (Path pack : packs) {
            copyTree(pack, backup.resolve(pack.getFileName()));
            changed += renameLegacyDirectories(pack, audit);
            changed += transformFiles(pack, audit);
        }
        Files.writeString(backup.resolve("audit.txt"), String.join(System.lineSeparator(), audit), StandardCharsets.UTF_8);
        return new FixResult(packs.size(), changed, List.copyOf(audit));
    }

    private static int renameLegacyDirectories(Path pack, List<String> audit) throws IOException {
        Path data = pack.resolve("data");
        if (!Files.isDirectory(data)) return 0;
        int changes = 0;
        try (Stream<Path> namespaces = Files.list(data)) {
            for (Path namespace : namespaces.filter(Files::isDirectory).toList()) {
                for (Map.Entry<String, String> entry : DIRECTORY_RENAMES.entrySet()) {
                    Path legacy = namespace.resolve(entry.getKey());
                    Path replacement = namespace.resolve(entry.getValue());
                    if (Files.isDirectory(legacy) && !Files.exists(replacement)) {
                        Files.createDirectories(replacement.getParent());
                        Files.move(legacy, replacement);
                        audit.add("RENAMED_DIRECTORY " + pack.relativize(legacy) + " -> " + pack.relativize(replacement));
                        changes++;
                    }
                }
            }
        }
        return changes;
    }

    private static int transformFiles(Path pack, List<String> audit) throws IOException {
        int changes = 0;
        try (Stream<Path> files = Files.walk(pack)) {
            for (Path file : files.filter(Files::isRegularFile).toList()) {
                String name = file.getFileName().toString();
                if (!(name.endsWith(".json") || name.endsWith(".mcfunction") || name.equals("pack.mcmeta"))) continue;
                String original = Files.readString(file, StandardCharsets.UTF_8);
                String fixed = original;
                for (Map.Entry<String, String> entry : EXACT_REPLACEMENTS.entrySet()) fixed = fixed.replace(entry.getKey(), entry.getValue());
                if (name.equals("pack.mcmeta")) fixed = addMissingPackFormat(fixed);
                if (!fixed.equals(original)) {
                    Files.writeString(file, fixed, StandardCharsets.UTF_8);
                    audit.add("UPDATED_FILE " + pack.relativize(file));
                    changes++;
                }
            }
        }
        return changes;
    }

    private static String addMissingPackFormat(String source) {
        try {
            JsonElement root = JsonParser.parseString(source);
            if (!root.isJsonObject()) return source;
            JsonObject top = root.getAsJsonObject();
            if (!top.has("pack") || !top.get("pack").isJsonObject()) return source;
            JsonObject pack = top.getAsJsonObject("pack");
            if (pack.has("pack_format")) return source;
            pack.addProperty("pack_format", 61);
            return JSON.toJson(top) + System.lineSeparator();
        } catch (RuntimeException ignored) {
            return source;
        }
    }

    private static void copyTree(Path source, Path destination) throws IOException {
        try (Stream<Path> paths = Files.walk(source)) {
            for (Path path : paths.toList()) {
                Path target = destination.resolve(source.relativize(path));
                if (Files.isDirectory(path)) Files.createDirectories(target);
                else Files.copy(path, target, StandardCopyOption.COPY_ATTRIBUTES);
            }
        }
    }

    public record FixResult(int packsBackedUp, int changes, List<String> audit) { }
}
