package dev.barden.guimaker.util;

import java.util.ArrayList;
import java.util.List;

import net.minecraft.component.DataComponentTypes;
import net.minecraft.component.type.NbtComponent;
import net.minecraft.item.ItemStack;
import net.minecraft.nbt.NbtCompound;
import net.minecraft.nbt.NbtElement;
import net.minecraft.nbt.NbtList;
import net.minecraft.registry.RegistryWrapper;
import net.minecraft.text.Text;

public final class GuiItemUtil {
    private GuiItemUtil() {
    }

    public static NbtCompound getCustomData(ItemStack stack) {
        NbtComponent component = stack.get(DataComponentTypes.CUSTOM_DATA);
        return component == null ? new NbtCompound() : component.copyNbt();
    }

    public static void setCustomData(ItemStack stack, NbtCompound customData) {
        stack.set(DataComponentTypes.CUSTOM_DATA, NbtComponent.of(customData));
    }

    public static NbtCompound getGuiData(ItemStack stack) {
        NbtCompound customData = getCustomData(stack);
        return customData.contains("gui", NbtElement.COMPOUND_TYPE) ? customData.getCompound("gui") : new NbtCompound();
    }

    public static void setName(ItemStack stack, String name) {
        stack.set(DataComponentTypes.CUSTOM_NAME, Text.literal(name));
    }

    public static NbtCompound writeItemStack(ItemStack stack, RegistryWrapper.WrapperLookup registries) {
        if (stack == null || stack.isEmpty()) {
            return new NbtCompound();
        }

        NbtElement encoded = stack.encodeAllowEmpty(registries);
        return encoded instanceof NbtCompound compound ? compound : new NbtCompound();
    }

    public static List<ItemStack> readItemStackList(NbtCompound parent, String key, RegistryWrapper.WrapperLookup registries) {
        List<ItemStack> result = new ArrayList<>();
        if (!parent.contains(key, NbtElement.LIST_TYPE)) {
            return result;
        }
        NbtList list = parent.getList(key, NbtElement.COMPOUND_TYPE);
        for (NbtElement element : list) {
            if (element instanceof NbtCompound compound) {
                result.add(ItemStack.fromNbtOrEmpty(registries, compound));
            }
        }
        return result;
    }

    public static NbtList writeItemStackList(List<ItemStack> stacks, RegistryWrapper.WrapperLookup registries) {
        NbtList list = new NbtList();
        for (ItemStack stack : stacks) {
            if (!stack.isEmpty()) {
                list.add(writeItemStack(stack, registries));
            }
        }
        return list;
    }

    public static String slotKey(int guiId, int page, int slot) {
        return guiId + ":" + page + ":" + slot;
    }
}
