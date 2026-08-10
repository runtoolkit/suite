package com.example.customcmd;

import com.example.customcmd.component.ModComponents;
import com.example.customcmd.item.ModItems;
import net.fabricmc.api.ModInitializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CustomCmdMod implements ModInitializer {

    public static final String MOD_ID = "customcmd";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitialize() {
        ModComponents.initialize(); // önce component
        ModItems.initialize();      // sonra item
        CustomCommand.register();   // komut
        LOGGER.info("CustomCmd modu yüklendi.");
    }
}
