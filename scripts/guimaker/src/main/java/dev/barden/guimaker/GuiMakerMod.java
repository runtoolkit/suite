package dev.barden.guimaker;

import dev.barden.guimaker.api.GuiMakerApi;
import dev.barden.guimaker.command.GuiMakerCommands;
import net.fabricmc.api.ModInitializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public final class GuiMakerMod implements ModInitializer {
    public static final String MOD_ID = "guimaker";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitialize() {
        GuiMakerApi.registerBuiltins();
        GuiMakerCommands.register();
        LOGGER.info("GUI Maker Fabric initialized.");
    }
}
