package com.runtoolkit.datapackblocker;

import com.runtoolkit.datapackblocker.command.BlockerCommand;
import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.command.v2.CommandRegistrationCallback;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerLifecycleEvents;
import net.minecraft.util.WorldSavePath;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Datapack Blocker - Fabric mod for Minecraft 1.21.1.
 *
 * On {@code SERVER_STARTING} (before the world finishes loading), the
 * current world's {@code datapacks/} folder is locked down by
 * {@link AllowlistManager}: whatever is present the first time this mod
 * runs on a given world becomes the allowlist and gets its write
 * permission stripped; anything that shows up later and isn't on that
 * allowlist gets moved into quarantine instead of being left for the
 * server to load.
 *
 * See {@link AllowlistManager}'s class doc for exactly what this does and
 * does not protect against - in short, it's a tamper deterrent and an
 * "unexpected new pack" tripwire for a normal server-restart workflow, not
 * a hard security boundary against someone with direct filesystem access.
 */
public class DatapackBlockerMod implements ModInitializer {

    public static final String MOD_ID = "datapack-blocker";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitialize() {
        LOGGER.info("Loading Datapack Blocker (Fabric 1.21.1)...");

        ServerLifecycleEvents.SERVER_STARTING.register(server -> {
            try {
                AllowlistManager manager = new AllowlistManager(
                        server.getSavePath(WorldSavePath.DATAPACKS),
                        server.getSavePath(WorldSavePath.ROOT),
                        LOGGER);
                manager.enforce();
            } catch (Exception exception) {
                // Never take the server down over this - log loudly and let it boot.
                LOGGER.error("Datapack Blocker: enforcement pass failed, datapacks folder was left as-is.", exception);
            }
        });

        CommandRegistrationCallback.EVENT.register((dispatcher, registryAccess, environment) ->
                BlockerCommand.register(dispatcher, registryAccess));

        LOGGER.info("Datapack Blocker loaded.");
    }
}
