package dev.barden.guimaker.api;

import dev.barden.guimaker.screen.GuiMakerScreenHandler;
import dev.barden.guimaker.state.GuiMakerState;
import net.minecraft.server.network.ServerPlayerEntity;

@FunctionalInterface
public interface GuiButtonCallback {
    void run(ServerPlayerEntity player, GuiMakerState state, GuiMakerScreenHandler screenHandler, int guiId, int page, int slot);
}
