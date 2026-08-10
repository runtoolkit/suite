package dev.barden.guimaker.api;

import net.minecraft.item.ItemStack;
import net.minecraft.server.network.ServerPlayerEntity;

@FunctionalInterface
public interface GuiItemModifier {
    ItemStack apply(ServerPlayerEntity player, ItemStack stack);
}
