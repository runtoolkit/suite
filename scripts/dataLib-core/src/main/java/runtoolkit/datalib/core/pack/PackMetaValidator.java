package runtoolkit.datalib.core.pack;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import net.minecraft.resource.ResourcePackProfile;
import net.minecraft.server.MinecraftServer;
import runtoolkit.datalib.core.DataLibCore;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;

public final class PackMetaValidator {

    private static final Gson GSON = new Gson();
    private static final int EXPECTED_PACK_FORMAT = 48;

    private static final Map<String, PackMeta> VALID_PACKS    = new LinkedHashMap<>();
    private static final Map<String, PackMeta> EXCLUDED_PACKS = new LinkedHashMap<>();

    private PackMetaValidator() {}

    public static void validate(MinecraftServer server) {
        VALID_PACKS.clear();
        EXCLUDED_PACKS.clear();

        PackMeta.Environment currentEnv = PackMeta.Environment.detect(server);
        var profiles = server.getDataPackManager().getEnabledProfiles();

        if (profiles.isEmpty()) {
            DataLibCore.LOGGER.info("[DataLib] No datapacks enabled — nothing to validate.");
            return;
        }

        DataLibCore.LOGGER.info("[DataLib] Validating {} datapack(s) (expected pack_format={})...",
            profiles.size(), EXPECTED_PACK_FORMAT);

        int valid = 0, excluded = 0;

        for (ResourcePackProfile profile : profiles) {
            String packName = profile.getInfo().id();

            // Mod resource packs (vanilla, fabric, datalib-core, etc.) don't have a
            // file-system pack.mcmeta readable by this validator — skip them silently.
            // They are never subject to format/environment validation.
            PackMeta meta = readPackMeta(profile, packName);
            if (meta == null) {
                DataLibCore.LOGGER.warn("[DataLib] [{}] Could not read pack.mcmeta — skipping.", packName);
                continue;
            }

            if (meta.packFormat() != EXPECTED_PACK_FORMAT) {
                DataLibCore.LOGGER.error(
                    "[DataLib] [{}] EXCLUDED — pack_format mismatch: expected {}, got {}.",
                    meta.effectiveId(), EXPECTED_PACK_FORMAT, meta.packFormat());
                EXCLUDED_PACKS.put(meta.effectiveId(), meta);
                excluded++;
                continue;
            }

            if (!meta.isActiveIn(currentEnv)) {
                DataLibCore.LOGGER.warn(
                    "[DataLib] [{}] EXCLUDED — environment '{}' does not match runtime ({}).",
                    meta.effectiveId(), meta.environment(), currentEnv.name().toLowerCase());
                EXCLUDED_PACKS.put(meta.effectiveId(), meta);
                excluded++;
                continue;
            }

            DataLibCore.LOGGER.info("[DataLib] [{}] OK{}",
                packName,
                meta.id() != null && !meta.id().isBlank()
                    ? " (id='" + meta.effectiveId() + "', env='" + (meta.environment() != null ? meta.environment() : "all") + "')"
                    : "");

            VALID_PACKS.put(meta.effectiveId(), meta);
            // Also index by packName so namespace-based lookups in CommandAliasLoader work
            // when effectiveId differs from packName (e.g. pack has explicit "id" field).
            if (!meta.effectiveId().equals(packName)) {
                VALID_PACKS.put(packName, meta);
            }
            valid++;
        }

        DataLibCore.LOGGER.info("[DataLib] Pack validation: {} valid, {} excluded.", valid, excluded);
    }

    private static PackMeta readPackMeta(ResourcePackProfile profile, String packName) {
        try (var pack = profile.createResourcePack()) {
            var supplier = pack.openRoot("pack.mcmeta");
            if (supplier == null) return null;

            try (InputStream is = supplier.get();
                 var reader = new InputStreamReader(is, StandardCharsets.UTF_8)) {

                JsonObject root = GSON.fromJson(reader, JsonObject.class);
                if (root == null || !root.has("pack")) return null;

                JsonObject obj = root.getAsJsonObject("pack");

                int    format      = obj.has("pack_format") ? obj.get("pack_format").getAsInt()    : -1;
                String description = obj.has("description") ? obj.get("description").getAsString() : "";
                String id          = obj.has("id")          ? obj.get("id").getAsString()          : null;
                String environment = obj.has("environment") ? obj.get("environment").getAsString() : null;

                return new PackMeta(packName, format, description, id, environment);
            }
        } catch (Exception e) {
            DataLibCore.LOGGER.debug("[DataLib] Could not read pack.mcmeta for '{}': {}", packName, e.getMessage());
            return null;
        }
    }

    public static boolean isValid(String effectiveId) {
        return VALID_PACKS.containsKey(effectiveId);
    }

    public static Map<String, PackMeta> getValidPacks() {
        return Collections.unmodifiableMap(VALID_PACKS);
    }

    public static Map<String, PackMeta> getExcludedPacks() {
        return Collections.unmodifiableMap(EXCLUDED_PACKS);
    }

    public static int getExpectedPackFormat() {
        return EXPECTED_PACK_FORMAT;
    }
}
