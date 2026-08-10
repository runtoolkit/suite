package runtoolkit.datalib.core;

import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerLifecycleEvents;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import runtoolkit.datalib.core.command.DataLibCommand;
import runtoolkit.datalib.core.pack.PackMetaValidator;
import runtoolkit.datalib.core.reload.CommandAliasLoader;

public class DataLibCore implements ModInitializer {

    public static final String MOD_ID  = "datalib-core";
    public static final String VERSION = "5.1.2";
    public static final Logger LOGGER  = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitialize() {
        LOGGER.info("[DataLib] Core initialised.");

        DataLibCommand.register();

        ServerLifecycleEvents.SERVER_STARTED.register(server -> {
            LOGGER.info("[DataLib] Server started.");
            // 1. Validate all pack.mcmeta files first
            PackMetaValidator.validate(server);
            // 2. Load aliases only from packs that passed validation
            CommandAliasLoader.load(server);
        });

        // Vanilla /reload or /datalib reload both fire this event
        ServerLifecycleEvents.END_DATA_PACK_RELOAD.register((server, resourceManager, success) -> {
            if (success) {
                LOGGER.info("[DataLib] Datapack reload detected — re-validating and refreshing...");
                PackMetaValidator.validate(server);
                CommandAliasLoader.load(server);
            } else {
                LOGGER.warn("[DataLib] Datapack reload failed — DataLib state unchanged.");
            }
        });

        ServerLifecycleEvents.SERVER_STOPPING.register(server ->
            LOGGER.info("[DataLib] Server stopping."));
    }
}
