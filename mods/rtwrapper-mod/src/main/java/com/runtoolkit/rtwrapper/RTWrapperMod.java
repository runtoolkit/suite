package com.runtoolkit.rtwrapper;

import com.runtoolkit.rtwrapper.command.RTWrapperCommand;
import com.runtoolkit.rtwrapper.command.RTWrapperCommands;
import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.command.v2.CommandRegistrationCallback;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerLifecycleEvents;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * RTWrapper - Fabric mod for Minecraft 1.21.1.
 *
 * Inspired by the conceptual idea behind the original RTWrapper datapack
 * (a macro-command wrapper/queue API), rewritten from scratch in Java with
 * the additional features requested by the user:
 *   - OP-level gate (configurable per command, 0-4)
 *   - Audit log to both the console and config/rtwrapper/audit.log
 *   - Chest GUI (/rtwrapper menu) - lists registered commands and runs them on click
 *   - /rtwrapper subcommand tree (register/unregister/list/info/run/menu/history/reload)
 *     instead of /trigger
 *   - Per-command cooldowns and an optional "confirm" step before running
 *     sensitive registered commands
 *   - In-memory run history (/rtwrapper history) on top of the persistent audit log
 *
 * The 400+ mcfunction variants in the datapack
 * (data/rtwrapper/function/core/wrappers/internal/variants/) were not ported
 * one-to-one; the functionality they covered (running parameterized vanilla
 * commands) is handled by a single general mechanism instead: every line in
 * RegisteredCommand.actions is run directly via
 * server.getCommandManager().executeWithPrefix(...) (see queue.CommandExecutor).
 * This replaces RTWrapper's "generate a separate macro variant per command"
 * approach with a simpler design that lets Brigadier handle its own argument
 * parsing.
 */
public class RTWrapperMod implements ModInitializer {

    public static final String MOD_ID = "rtwrapper";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitialize() {
        LOGGER.info("Loading RTWrapper (Fabric 1.21.1)...");

        // Build per-server state (registry/executor/audit log) once the server has started.
        ServerLifecycleEvents.SERVER_STARTED.register(server -> {
            RTWrapperCommands.attach(server);
            int count = RTWrapperCommands.getRegistry(server.getCommandSource()).all().size();
            LOGGER.info("RTWrapper started: {} registered command(s) loaded.", count);
        });

        ServerLifecycleEvents.SERVER_STOPPING.register(RTWrapperCommands::detach);

        // The command tree is independent of any particular server instance and
        // is registered once; each body resolves its state at execution time via
        // source.getServer().
        CommandRegistrationCallback.EVENT.register((dispatcher, registryAccess, environment) ->
                RTWrapperCommand.register(dispatcher, registryAccess));

        LOGGER.info("RTWrapper loaded.");
    }
}
