package io.runtoolkit.datapackfixer;

import com.mojang.brigadier.Command;
import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.command.v2.CommandRegistrationCallback;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerLifecycleEvents;
import net.minecraft.server.command.CommandManager;
import net.minecraft.text.Text;
import net.minecraft.util.WorldSavePath;

public final class DatapackFixerMod implements ModInitializer {
    @Override
    public void onInitialize() {
        ServerLifecycleEvents.SERVER_STARTED.register(server -> logDiagnostics(server.getSavePath(WorldSavePath.DATAPACKS)));
        CommandRegistrationCallback.EVENT.register((dispatcher, registryAccess, environment) -> dispatcher.register(
                CommandManager.literal("datapackfixer").requires(source -> source.hasPermissionLevel(4))
                        .then(CommandManager.literal("scan").executes(context -> {
                            logDiagnostics(context.getSource().getServer().getSavePath(WorldSavePath.DATAPACKS));
                            context.getSource().sendFeedback(() -> Text.literal("Datapack Fixer scan completed."), false);
                            return Command.SINGLE_SUCCESS;
                        }))
                        .then(CommandManager.literal("fix").executes(context -> {
                            var server = context.getSource().getServer();
                            try {
                                var result = new DatapackFixerEngine().fix(server.getSavePath(WorldSavePath.DATAPACKS),
                                        server.getSavePath(WorldSavePath.ROOT).resolve("datapack_fixer_backups"));
                                context.getSource().sendFeedback(() -> Text.literal("Datapack Fixer created backups for "
                                        + result.packsBackedUp() + " pack(s) and applied " + result.changes() + " change(s). Run /reload to load the repaired packs."), true);
                                return Command.SINGLE_SUCCESS;
                            } catch (Exception exception) {
                                context.getSource().sendError(Text.literal("Datapack Fixer could not complete repair: " + exception.getMessage()));
                                return 0;
                            }
                        }))));
    }

    private static void logDiagnostics(java.nio.file.Path datapacks) {
        var diagnostics = new DatapackSyntaxScanner().scan(datapacks);
        if (diagnostics.isEmpty()) {
            System.getLogger("Datapack Fixer").log(System.Logger.Level.INFO, "Datapack Fixer 1.2.0 found no supported syntax issues.");
            return;
        }
        System.getLogger("Datapack Fixer").log(System.Logger.Level.WARNING, "Datapack Fixer found " + diagnostics.size() + " issue(s). Use /datapackfixer fix to create backups and apply allowlisted repairs.");
        diagnostics.forEach(diagnostic -> System.getLogger("Datapack Fixer").log(System.Logger.Level.WARNING,
                "[" + diagnostic.code() + "] " + diagnostic.file() + ":" + diagnostic.line() + " " + diagnostic.message()));
    }
}
