package com.runtoolkit.rtwpanel.client;

import com.mojang.brigadier.Command;
import net.fabricmc.api.ClientModInitializer;
import net.fabricmc.fabric.api.client.command.v2.ClientCommandManager;
import net.fabricmc.fabric.api.client.command.v2.ClientCommandRegistrationCallback;
import net.minecraft.client.Minecraft;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RTWPanelClient implements ClientModInitializer {
    public static final String MOD_ID = "rtwpanel";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitializeClient() {
        ClientCommandRegistrationCallback.EVENT.register((dispatcher, registryAccess) -> {
            dispatcher.register(
                ClientCommandManager.literal("rtwpanel")
                    .executes(ctx -> {
                        Minecraft.getInstance().execute(() ->
                            Minecraft.getInstance().setScreen(new RTWMainMenuScreen(null))
                        );
                        return Command.SINGLE_SUCCESS;
                    })
            );
        });

        LOGGER.info("RTWPanel yuklendi. Acmak icin: /rtwpanel");
    }
}
