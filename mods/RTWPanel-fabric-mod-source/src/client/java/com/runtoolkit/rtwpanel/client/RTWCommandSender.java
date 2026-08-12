package com.runtoolkit.rtwpanel.client;

import net.minecraft.client.Minecraft;
import net.minecraft.client.multiplayer.ClientPacketListener;

public final class RTWCommandSender {
    private RTWCommandSender() {}

    public static void send(String command) {
        Minecraft client = Minecraft.getInstance();
        ClientPacketListener connection = client.getConnection();
        if (connection == null) {
            RTWPanelClient.LOGGER.warn("Attempted to send command while not connected to server: {}", command);
            return;
        }
        connection.sendCommand(command);
    }
}
