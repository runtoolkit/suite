package com.runtoolkit.rtwpanel.client;

import net.minecraft.client.Minecraft;
import net.minecraft.client.multiplayer.ClientPacketListener;

/**
 * /rtwpanel bir client-side mod komutudur (server GUI verisi gondermez).
 * Butonlar bu yardimci ile sunucuya normal chat-komutu olarak gonderilir;
 * sunucuda RTWrapper datapack'i bu komutlari isler.
 */
public final class RTWCommandSender {
    private RTWCommandSender() {}

    /** command onunde "/" OLMADAN, ornek: "function rtwrapper:api/status" */
    public static void send(String command) {
        Minecraft client = Minecraft.getInstance();
        ClientPacketListener connection = client.getConnection();
        if (connection == null) {
            RTWPanelClient.LOGGER.warn("Sunucuya bagli degilken komut gonderilmeye calisildi: {}", command);
            return;
        }
        connection.sendCommand(command);
    }
}
