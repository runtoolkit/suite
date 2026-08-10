package io.runtoolkit.datapackfixer;

import static org.junit.jupiter.api.Assertions.*;
import java.nio.file.Files;
import java.nio.file.Path;
import org.junit.jupiter.api.Test;

class DatapackSyntaxScannerTest {
    @Test void reportsInvalidJsonWithoutWritingFiles() throws Exception {
        Path root = Files.createTempDirectory("dfx");
        Path file = root.resolve("sample/data/example/recipe/broken.json");
        Files.createDirectories(file.getParent());
        Files.writeString(file, "{ \"type\": ");
        var diagnostics = new DatapackSyntaxScanner().scan(root);
        assertTrue(diagnostics.stream().anyMatch(d -> d.code().equals("JSON_INVALID")));
        assertEquals("{ \"type\": ", Files.readString(file));
    }
    @Test void reports26_2MigrationAndLegacyDirectory() throws Exception {
        Path root = Files.createTempDirectory("dfx");
        Path file = root.resolve("sample/data/example/predicates/slime.json");
        Files.createDirectories(file.getParent());
        Files.writeString(file, "{\"type\":\"minecraft:type_specific/slime\"}");
        var diagnostics = new DatapackSyntaxScanner().scan(root);
        assertTrue(diagnostics.stream().anyMatch(d -> d.code().equals("LEGACY_DIRECTORY")));
        assertTrue(diagnostics.stream().anyMatch(d -> d.code().equals("TYPE_SPECIFIC_SLIME")));
    }
    @Test void ignoresBinaryFilesAndReportsMissingPackFormat() throws Exception {
        Path root = Files.createTempDirectory("dfx");
        Path pack = root.resolve("sample");
        Files.createDirectories(pack);
        Files.write(pack.resolve("pack.png"), new byte[] {(byte) 0x89, 0x50, 0x4e, 0x47});
        Files.writeString(pack.resolve("pack.mcmeta"), "{\"pack\": {\"description\": \"Missing format\"}}");
        var diagnostics = new DatapackSyntaxScanner().scan(root);
        assertTrue(diagnostics.stream().anyMatch(d -> d.code().equals("PACK_FORMAT_MISSING")));
        assertFalse(diagnostics.stream().anyMatch(d -> d.code().equals("READ_IO")));
    }

    @Test void skipsZipDatapacksWithoutTreatingThemAsUtf8Text() throws Exception {
        Path root = Files.createTempDirectory("dfx");
        Path archive = root.resolve("packed-datapack.zip");
        Files.write(archive, new byte[] {0x50, 0x4b, 0x03, 0x04, (byte) 0xff});
        assertTrue(new DatapackSyntaxScanner().scan(root).isEmpty());
    }

    @Test void detectsMalformedFunctionDelimiters() throws Exception {
        Path root = Files.createTempDirectory("dfx");
        Path file = root.resolve("sample/data/example/function/load.mcfunction");
        Files.createDirectories(file.getParent());
        Files.writeString(file, "give @s minecraft:stone[custom_name='broken'");
        assertTrue(new DatapackSyntaxScanner().scan(root).stream().anyMatch(d -> d.code().equals("FUNCTION_DELIMITER")));
    }
}

class DatapackFixerEngineTest {
    @Test void createsBackupAndAppliesOnlyAllowlistedRepairs() throws Exception {
        Path root = Files.createTempDirectory("dfx");
        Path pack = root.resolve("legacy-pack");
        Path legacyFunction = pack.resolve("data/example/functions/load.mcfunction");
        Files.createDirectories(legacyFunction.getParent());
        Files.writeString(legacyFunction, "execute if predicate minecraft:type_specific/slime run say ready");
        Files.writeString(pack.resolve("pack.mcmeta"), "{\"pack\":{\"description\":\"test\"}}");
        Path backups = Files.createTempDirectory("dfx-backups");

        var result = new DatapackFixerEngine().fix(root, backups);

        assertEquals(1, result.packsBackedUp());
        assertTrue(result.changes() >= 3);
        Path fixed = pack.resolve("data/example/function/load.mcfunction");
        assertTrue(Files.exists(fixed));
        assertTrue(Files.readString(fixed).contains("minecraft:type_specific/cube_mob"));
        assertTrue(Files.readString(pack.resolve("pack.mcmeta")).contains("\"pack_format\": 61"));
        try (var backupDirectories = Files.list(backups)) {
            Path backup = backupDirectories.findFirst().orElseThrow();
            assertTrue(Files.exists(backup.resolve("legacy-pack/data/example/functions/load.mcfunction")));
        }
    }
}
