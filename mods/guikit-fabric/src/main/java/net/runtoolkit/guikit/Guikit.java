package net.runtoolkit.guikit;

import net.fabricmc.api.ModInitializer;
import net.runtoolkit.guikit.menu.GuikitMenus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Guikit implements ModInitializer {
    public static final String MOD_ID = "guikit";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitialize() {
        GuikitMenus.register();
        LOGGER.info("guikit loaded (Fabric port, server-authoritative menus)");
    }
}
