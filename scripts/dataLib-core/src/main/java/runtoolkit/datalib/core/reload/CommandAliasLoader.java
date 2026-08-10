package runtoolkit.datalib.core.reload;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.mojang.brigadier.CommandDispatcher;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.command.ServerCommandSource;
import net.minecraft.text.Text;
import net.minecraft.util.Formatting;
import net.minecraft.util.Identifier;
import runtoolkit.datalib.core.DataLibCore;
import runtoolkit.datalib.core.pack.PackMetaValidator;

import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;

import static net.minecraft.server.command.CommandManager.literal;

/**
 * Loads command alias definitions from datapack JSON files.
 *
 * JSON location: data/<namespace>/datalib/commands/<name>.json
 *
 * Format:
 * {
 *   "alias": "mycommand",
 *   "target": "say Hello from alias",
 *   "description": "Optional description",
 *   "permission_level": 0
 * }
 *
 * Packs excluded by PackMetaValidator (wrong pack_format or environment)
 * are silently skipped — their aliases are never registered.
 *
 * Exception: the mod's own namespace (datalib-core) is always allowed,
 * since its pack.mcmeta cannot be read by the validator (it's a mod resource).
 */
public final class CommandAliasLoader {

    private static final Gson GSON = new Gson();
    private static final String DATAPACK_PATH = "datalib/commands";

    // alias → target command string
    private static final Map<String, String> LOADED_ALIASES = new LinkedHashMap<>();

    private CommandAliasLoader() {}

    public static void load(MinecraftServer server) {
        LOADED_ALIASES.clear();

        var resourceManager = server.getResourceManager();
        var resources = resourceManager.findResources(
            DATAPACK_PATH,
            id -> id.getPath().endsWith(".json")
        );

        if (resources.isEmpty()) {
            DataLibCore.LOGGER.info("[DataLib] No command alias files found in datapacks.");
            return;
        }

        int loaded = 0;
        int skipped = 0;
        int failed = 0;

        for (var entry : resources.entrySet()) {
            Identifier id = entry.getKey();
            String namespace = id.getNamespace();

            // The mod's own namespace is always trusted — its pack.mcmeta is
            // unreadable by PackMetaValidator (mod resource, not a file/zip pack).
            // Every other namespace must have passed validation.
            boolean isMod = namespace.equals(DataLibCore.MOD_ID);
            if (!isMod && !PackMetaValidator.isValid(namespace)) {
                DataLibCore.LOGGER.debug(
                    "[DataLib] Skipping alias {} — pack '{}' did not pass validation.",
                    id, namespace);
                skipped++;
                continue;
            }

            try (var stream = entry.getValue().getInputStream();
                 var reader = new InputStreamReader(stream, StandardCharsets.UTF_8)) {

                JsonObject json = GSON.fromJson(reader, JsonObject.class);

                if (!json.has("alias") || !json.has("target")) {
                    DataLibCore.LOGGER.warn("[DataLib] Skipping {} — missing 'alias' or 'target' field.", id);
                    failed++;
                    continue;
                }

                String alias = json.get("alias").getAsString().trim();
                String target = json.get("target").getAsString().trim();
                int permLevel = json.has("permission_level")
                    ? json.get("permission_level").getAsInt()
                    : 0;

                if (alias.isBlank() || target.isBlank()) {
                    DataLibCore.LOGGER.warn("[DataLib] Skipping {} — blank alias or target.", id);
                    failed++;
                    continue;
                }

                int clampedPerm = Math.max(0, Math.min(4, permLevel));

                LOADED_ALIASES.put(alias, target);
                registerAlias(server.getCommandManager().getDispatcher(), alias, target, clampedPerm);
                loaded++;

                DataLibCore.LOGGER.info("[DataLib] Alias registered: /{} → {}", alias, target);

            } catch (Exception e) {
                DataLibCore.LOGGER.error("[DataLib] Failed to load alias from {}: {}", id, e.getMessage());
                failed++;
            }
        }

        DataLibCore.LOGGER.info("[DataLib] Command aliases: {} loaded, {} skipped (excluded packs), {} failed.",
            loaded, skipped, failed);
    }

    private static void registerAlias(
        CommandDispatcher<ServerCommandSource> dispatcher,
        String alias,
        String target,
        int permLevel
    ) {
        try {
            var root = dispatcher.getRoot();
            if (root.getChild(alias) != null) {
                DataLibCore.LOGGER.debug("[DataLib] Alias /{} already registered, skipping.", alias);
                return;
            }

            dispatcher.register(
                literal(alias)
                    .requires(src -> src.hasPermissionLevel(permLevel))
                    .executes(ctx -> {
                        String cmd = target.replace("@s", ctx.getSource().getName());
                        final String finalCmd = cmd;

                        ctx.getSource().sendFeedback(() ->
                            Text.literal("[DataLib] → " + finalCmd).formatted(Formatting.DARK_GRAY), false);

                        ctx.getSource().getServer()
                            .getCommandManager()
                            .getDispatcher()
                            .execute(finalCmd, ctx.getSource());

                        return 1;
                    })
            );
        } catch (Exception e) {
            DataLibCore.LOGGER.error("[DataLib] Could not register alias /{}: {}", alias, e.getMessage());
        }
    }

    public static Map<String, String> getAliases() {
        return Collections.unmodifiableMap(LOADED_ALIASES);
    }

    public static int getAliasCount() {
        return LOADED_ALIASES.size();
    }
}
