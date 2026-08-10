package runtoolkit.datalib.core.command;

import com.mojang.brigadier.Command;
import com.mojang.brigadier.context.CommandContext;
import net.fabricmc.fabric.api.command.v2.CommandRegistrationCallback;
import net.minecraft.server.command.ServerCommandSource;
import net.minecraft.server.dedicated.DedicatedServer;
import net.minecraft.text.Text;
import net.minecraft.util.Formatting;
import runtoolkit.datalib.core.DataLibCore;
import runtoolkit.datalib.core.reload.CommandAliasLoader;

import java.util.concurrent.CompletableFuture;

import static net.minecraft.server.command.CommandManager.literal;

public final class DataLibCommand {

    public static void register() {
        CommandRegistrationCallback.EVENT.register((dispatcher, registryAccess, environment) ->
            dispatcher.register(
                literal("datalib")
                    .requires(src -> src.hasPermissionLevel(2))

                    // /datalib reload
                    .then(literal("reload")
                        .executes(DataLibCommand::executeReload))

                    // /datalib info
                    .then(literal("info")
                        .executes(DataLibCommand::executeInfo))

                    // /datalib commands list
                    .then(literal("commands")
                        .then(literal("list")
                            .executes(DataLibCommand::executeCommandsList)))
            )
        );
    }

    // -------------------------------------------------------------------------
    // /datalib reload
    // -------------------------------------------------------------------------

    private static int executeReload(CommandContext<ServerCommandSource> ctx) {
        ServerCommandSource source = ctx.getSource();

        source.sendFeedback(() ->
            Text.literal("[DataLib] Reloading datapacks...").formatted(Formatting.YELLOW), false);

        CompletableFuture<Void> future = source.getServer()
            .reloadResources(source.getServer().getDataPackManager().getEnabledProfiles()
                .stream().map(p -> p.getInfo().id()).toList());

        future.whenComplete((result, error) -> {
            if (error != null) {
                DataLibCore.LOGGER.error("[DataLib] Reload failed: {}", error.getMessage());
                source.sendError(Text.literal("[DataLib] Reload failed: " + error.getMessage()));
            } else {
                // Re-scan command aliases after datapack reload
                CommandAliasLoader.load(source.getServer());

                source.sendFeedback(() ->
                    Text.literal("[DataLib] Reload complete.").formatted(Formatting.GREEN), true);
            }
        });

        return Command.SINGLE_SUCCESS;
    }

    // -------------------------------------------------------------------------
    // /datalib info
    // -------------------------------------------------------------------------

    private static int executeInfo(CommandContext<ServerCommandSource> ctx) {
        ServerCommandSource source = ctx.getSource();
        var server = source.getServer();

        // DataLib version
        source.sendFeedback(() ->
            Text.literal("--- DataLib Core ---").formatted(Formatting.GOLD), false);

        source.sendFeedback(() ->
            Text.literal("Version: ").formatted(Formatting.GRAY)
                .append(Text.literal(DataLibCore.VERSION).formatted(Formatting.WHITE)), false);

        // Minecraft + server brand
        source.sendFeedback(() ->
            Text.literal("Minecraft: ").formatted(Formatting.GRAY)
                .append(Text.literal(server.getVersion()).formatted(Formatting.WHITE)), false);

        boolean isDedicated = server instanceof DedicatedServer;
        source.sendFeedback(() ->
            Text.literal("Mode: ").formatted(Formatting.GRAY)
                .append(Text.literal(isDedicated ? "Dedicated" : "Integrated").formatted(Formatting.WHITE)), false);

        // Enabled datapacks
        var enabled = server.getDataPackManager().getEnabledProfiles()
            .stream().map(p -> p.getInfo().id()).toList();
        source.sendFeedback(() ->
            Text.literal("Datapacks (" + enabled.size() + "):").formatted(Formatting.GOLD), false);

        for (String pack : enabled) {
            source.sendFeedback(() ->
                Text.literal("  • " + pack).formatted(Formatting.GRAY), false);
        }

        // Registered command aliases
        int aliasCount = CommandAliasLoader.getAliasCount();
        source.sendFeedback(() ->
            Text.literal("Command aliases: ").formatted(Formatting.GRAY)
                .append(Text.literal(String.valueOf(aliasCount)).formatted(Formatting.WHITE)), false);

        return Command.SINGLE_SUCCESS;
    }

    // -------------------------------------------------------------------------
    // /datalib commands list
    // -------------------------------------------------------------------------

    private static int executeCommandsList(CommandContext<ServerCommandSource> ctx) {
        ServerCommandSource source = ctx.getSource();
        var aliases = CommandAliasLoader.getAliases();

        if (aliases.isEmpty()) {
            source.sendFeedback(() ->
                Text.literal("[DataLib] No command aliases loaded.").formatted(Formatting.YELLOW), false);
            return 0;
        }

        source.sendFeedback(() ->
            Text.literal("--- DataLib Command Aliases ---").formatted(Formatting.GOLD), false);

        for (var entry : aliases.entrySet()) {
            String alias = entry.getKey();
            String target = entry.getValue();
            source.sendFeedback(() ->
                Text.literal("  /" + alias + " ").formatted(Formatting.AQUA)
                    .append(Text.literal("→ ").formatted(Formatting.GRAY))
                    .append(Text.literal(target).formatted(Formatting.WHITE)), false);
        }

        return aliases.size();
    }
}
