package io.runtoolkit.macroengine.client;

import net.fabricmc.api.ClientModInitializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Client-side entry point.
 *
 * CORRECTION: PayloadTypeRegistry.serverboundPlay().register(...) is done ONCE
 * in the common initializer (MacroEngineMod#onInitialize), which runs on both
 * client and server. Registering again here throws
 * IllegalArgumentException: "already registered" on client launch, since
 * onInitialize() always runs before onInitializeClient().
 */
public class MacroEngineModClient implements ClientModInitializer {
    private static final Logger LOGGER = LoggerFactory.getLogger("macroengine-client");

    @Override
    public void onInitializeClient() {
        MacroEngineClientCommands.register();
        LOGGER.info("MacroEngine client bridge initialized.");
    }
}