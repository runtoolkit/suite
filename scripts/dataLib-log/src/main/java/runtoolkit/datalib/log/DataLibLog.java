package runtoolkit.datalib.log;

import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerTickEvents;
import net.minecraft.nbt.NbtCompound;
import net.minecraft.nbt.NbtElement;
import net.minecraft.nbt.NbtList;
import net.minecraft.server.MinecraftServer;
import net.minecraft.util.Identifier;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DataLibLog implements ModInitializer {

    public static final String MOD_ID = "datalib-log";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    private static final int POLL_INTERVAL_TICKS = 20;
    private int tickCounter = 0;

    private static final Identifier ENGINE_ID = Identifier.of("datalib", "engine");

    @Override
    public void onInitialize() {
        LOGGER.info("[DataLib] Log bridge initialised.");
        ServerTickEvents.END_SERVER_TICK.register(this::onTick);
    }

    private void onTick(MinecraftServer server) {
        if (++tickCounter < POLL_INTERVAL_TICKS) return;
        tickCounter = 0;

        try {
            var storage = server.getDataCommandStorage();
            NbtCompound engineStorage = storage.get(ENGINE_ID);
            if (engineStorage == null || !engineStorage.contains("log_display", NbtElement.LIST_TYPE)) return;

            NbtList logDisplay = engineStorage.getList("log_display", NbtElement.COMPOUND_TYPE);
            if (logDisplay.isEmpty()) return;

            for (NbtElement entry : logDisplay) {
                if (!(entry instanceof NbtCompound compound)) continue;
                emitToServerLog(compound.getString("text"));
            }

            engineStorage.remove("log_display");
            storage.set(ENGINE_ID, engineStorage);
        } catch (Exception e) {
            LOGGER.warn("[DataLib] Log poll failed: {}", e.getMessage());
        }
    }

    private void emitToServerLog(String text) {
        if (text.startsWith("[ERROR]")) LOGGER.error("[DataLib] {}", text);
        else if (text.startsWith("[WARN]")) LOGGER.warn("[DataLib] {}", text);
        else if (text.startsWith("[DEBUG]")) LOGGER.debug("[DataLib] {}", text);
        else LOGGER.info("[DataLib] {}", text);
    }
}
