package io.runtoolkit.datapackfixer;

import com.google.gson.JsonParseException;
import com.google.gson.JsonParser;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.stream.Stream;

public final class DatapackSyntaxScanner {
    private static final long MAX_FILE_SIZE = 2_000_000L;
    private static final int MAX_FILES = 10_000;
    private static final Set<String> PLURAL_DIRECTORIES = Set.of(
            "advancements", "functions", "item_modifiers", "loot_tables", "predicates", "recipes", "structures",
            "tags/blocks", "tags/entity_types", "tags/fluids", "tags/functions", "tags/game_events", "tags/items"
    );

    public List<Diagnostic> scan(Path datapacksDirectory) {
        if (!Files.isDirectory(datapacksDirectory)) return List.of();
        List<Diagnostic> results = new ArrayList<>();
        try (Stream<Path> paths = Files.walk(datapacksDirectory)) {
            Iterator<Path> iterator = paths.filter(Files::isRegularFile).iterator();
            int scannedFiles = 0;
            while (iterator.hasNext() && scannedFiles < MAX_FILES) {
                scanFile(datapacksDirectory, iterator.next(), results);
                scannedFiles++;
            }
            if (iterator.hasNext()) {
                results.add(new Diagnostic(datapacksDirectory, 1, Diagnostic.Severity.WARNING, "SCAN_LIMIT",
                        "Stopped after " + MAX_FILES + " files to protect server startup time.",
                        "Split unusually large datapack directories or remove unrelated files."));
            }
        } catch (IOException exception) {
            results.add(new Diagnostic(datapacksDirectory, 1, Diagnostic.Severity.ERROR, "SCAN_IO",
                    "Could not enumerate datapacks: " + exception.getMessage(), "Check filesystem permissions."));
        }
        return List.copyOf(results);
    }

    private void scanFile(Path root, Path file, List<Diagnostic> results) {
        String normalized = root.relativize(file).toString().replace('\\', '/').toLowerCase(Locale.ROOT);
        boolean isJson = normalized.endsWith(".json") || normalized.endsWith("pack.mcmeta");
        boolean isFunction = normalized.endsWith(".mcfunction");
        if (!isJson && !isFunction) return;
        try {
            if (Files.size(file) > MAX_FILE_SIZE) return;
            String content = Files.readString(file, StandardCharsets.UTF_8);
            checkPluralDirectories(file, normalized, results);
            if (isJson) checkJson(file, content, results);
            if (normalized.endsWith("pack.mcmeta")) checkPackMetadata(file, content, results);
            if (isFunction) checkFunctionDelimiters(file, content, results);
            checkKnownMigrations(file, normalized, content, results);
        } catch (IOException exception) {
            results.add(new Diagnostic(file, 1, Diagnostic.Severity.ERROR, "READ_IO",
                    "Could not read file: " + exception.getMessage(), "Check file encoding and permissions."));
        }
    }

    private static void checkJson(Path file, String content, List<Diagnostic> results) {
        try {
            JsonParser.parseString(content);
        } catch (JsonParseException exception) {
            results.add(new Diagnostic(file, lineOf(exception.getMessage()), Diagnostic.Severity.ERROR, "JSON_INVALID",
                    "Invalid JSON: " + compact(exception.getMessage()), "Repair JSON punctuation, quoting, or delimiters."));
        }
    }

    private static void checkPackMetadata(Path file, String content, List<Diagnostic> results) {
        try {
            var root = JsonParser.parseString(content);
            if (!root.isJsonObject() || !root.getAsJsonObject().has("pack")) {
                results.add(new Diagnostic(file, 1, Diagnostic.Severity.ERROR, "PACK_METADATA_MISSING",
                        "pack.mcmeta must contain a top-level 'pack' object.",
                        "Add a valid pack object with pack_format and description."));
                return;
            }
            var pack = root.getAsJsonObject().getAsJsonObject("pack");
            if (!pack.has("pack_format")) {
                results.add(new Diagnostic(file, 1, Diagnostic.Severity.ERROR, "PACK_FORMAT_MISSING",
                        "This 1.21.4-targeted pack is missing pack_format.",
                        "Set pack_format to 61 for Minecraft 1.21.4."));
            }
        } catch (JsonParseException ignored) {
            // The JSON parser diagnostic is already reported by checkJson.
        }
    }

    private static void checkPluralDirectories(Path file, String normalized, List<Diagnostic> results) {
        int data = normalized.indexOf("/data/");
        if (data < 0) return;
        String afterData = normalized.substring(data + 6);
        int slash = afterData.indexOf('/');
        if (slash < 0) return;
        String resourcePath = afterData.substring(slash + 1);
        for (String legacy : PLURAL_DIRECTORIES) {
            if (resourcePath.startsWith(legacy + "/")) {
                results.add(new Diagnostic(file, 1, Diagnostic.Severity.ERROR, "LEGACY_DIRECTORY",
                        "Legacy datapack directory '" + legacy + "' is not loaded by modern versions.",
                        "Move it to '" + singular(legacy) + "'."));
                return;
            }
        }
    }

    private static void checkKnownMigrations(Path file, String normalized, String content, List<Diagnostic> results) {
        if (content.contains("minecraft:type_specific/slime")) {
            results.add(new Diagnostic(file, findLine(content, "minecraft:type_specific/slime"), Diagnostic.Severity.ERROR,
                    "TYPE_SPECIFIC_SLIME", "26.2 renamed the slime entity sub-predicate.",
                    "Replace minecraft:type_specific/slime with minecraft:type_specific/cube_mob."));
        }
        if (normalized.contains("/recipe/") && content.matches("(?s).*\"(?:item|tag)\"\\s*:\\s*\"[^\"]+\".*")) {
            results.add(new Diagnostic(file, 1, Diagnostic.Severity.WARNING, "RECIPE_INGREDIENT_LEGACY",
                    "Recipe ingredients may use the pre-1.21.2 object form.",
                    "Use an item id string or a #tag string where the recipe schema accepts an ingredient."));
        }
        if (content.contains("\"condition\": \"minecraft:alternative\"")) {
            results.add(new Diagnostic(file, findLine(content, "minecraft:alternative"), Diagnostic.Severity.ERROR,
                    "ALTERNATIVE_RENAMED", "The alternative loot condition was renamed.",
                    "Replace minecraft:alternative with minecraft:any_of."));
        }
    }

    private static void checkFunctionDelimiters(Path file, String content, List<Diagnostic> results) {
        int square = 0, curly = 0;
        boolean quote = false, escape = false;
        int line = 1;
        for (char character : content.toCharArray()) {
            if (character == '\n') line++;
            if (quote && character == '\\' && !escape) { escape = true; continue; }
            if (character == '"' && !escape) quote = !quote;
            if (!quote) {
                if (character == '[') square++;
                if (character == ']') square--;
                if (character == '{') curly++;
                if (character == '}') curly--;
                if (square < 0 || curly < 0) break;
            }
            escape = false;
        }
        if (quote || square != 0 || curly != 0) results.add(new Diagnostic(file, line, Diagnostic.Severity.ERROR,
                "FUNCTION_DELIMITER", "Unbalanced quote or SNBT/item-component delimiter in function.",
                "Balance quotes, brackets, and braces on the affected command."));
    }

    private static String singular(String value) {
        return value.replace("entity_types", "entity_type").replace("game_events", "game_event")
                .replace("advancements", "advancement").replace("functions", "function")
                .replace("item_modifiers", "item_modifier").replace("loot_tables", "loot_table")
                .replace("predicates", "predicate").replace("recipes", "recipe").replace("structures", "structure")
                .replace("blocks", "block").replace("fluids", "fluid").replace("items", "item");
    }
    private static int findLine(String content, String needle) { return 1 + (int) content.substring(0, content.indexOf(needle)).chars().filter(c -> c == '\n').count(); }
    private static int lineOf(String message) { var matcher = java.util.regex.Pattern.compile("line (\\d+)").matcher(message); return matcher.find() ? Integer.parseInt(matcher.group(1)) : 1; }
    private static String compact(String message) { return message == null ? "unknown parser error" : message.replaceAll("\\s+", " "); }
}
