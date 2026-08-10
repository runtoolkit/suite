package dev.barden.guimaker.model;

import dev.barden.guimaker.util.GuiItemUtil;
import java.util.HashMap;
import java.util.Map;
import net.minecraft.item.ItemStack;
import net.minecraft.nbt.NbtCompound;
import net.minecraft.registry.RegistryWrapper;

public final class PlayerGuiCache {
    private final Map<String, ItemStack> holderStacks = new HashMap<>();
    private final Map<String, Integer> toggleIndices = new HashMap<>();

    public ItemStack getHolder(String key) {
        return this.holderStacks.getOrDefault(key, ItemStack.EMPTY).copy();
    }

    public void setHolder(String key, ItemStack stack) {
        if (stack == null || stack.isEmpty()) {
            this.holderStacks.remove(key);
        } else {
            this.holderStacks.put(key, stack.copy());
        }
    }

    public int getToggleIndex(String key) {
        return this.toggleIndices.getOrDefault(key, 0);
    }

    public void setToggleIndex(String key, int index) {
        this.toggleIndices.put(key, index);
    }

    public NbtCompound toNbt(RegistryWrapper.WrapperLookup registries) {
        NbtCompound nbt = new NbtCompound();
        NbtCompound holders = new NbtCompound();
        for (Map.Entry<String, ItemStack> entry : this.holderStacks.entrySet()) {
            holders.put(entry.getKey(), GuiItemUtil.writeItemStack(entry.getValue(), registries));
        }
        nbt.put("holders", holders);

        NbtCompound toggles = new NbtCompound();
        for (Map.Entry<String, Integer> entry : this.toggleIndices.entrySet()) {
            toggles.putInt(entry.getKey(), entry.getValue());
        }
        nbt.put("toggles", toggles);
        return nbt;
    }

    public static PlayerGuiCache fromNbt(NbtCompound nbt, RegistryWrapper.WrapperLookup registries) {
        PlayerGuiCache cache = new PlayerGuiCache();
        if (nbt.contains("holders")) {
            NbtCompound holders = nbt.getCompound("holders");
            for (String key : holders.getKeys()) {
                cache.holderStacks.put(key, ItemStack.fromNbtOrEmpty(registries, holders.getCompound(key)));
            }
        }
        if (nbt.contains("toggles")) {
            NbtCompound toggles = nbt.getCompound("toggles");
            for (String key : toggles.getKeys()) {
                cache.toggleIndices.put(key, toggles.getInt(key));
            }
        }
        return cache;
    }
}
