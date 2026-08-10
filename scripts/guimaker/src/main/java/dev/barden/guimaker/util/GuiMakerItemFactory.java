package dev.barden.guimaker.util;

import net.minecraft.item.ItemStack;
import net.minecraft.item.Items;
import net.minecraft.nbt.NbtCompound;

public final class GuiMakerItemFactory {
    private GuiMakerItemFactory() {
    }

    public static ItemStack itemHolder(boolean cached) {
        ItemStack stack = new ItemStack(Items.LIME_STAINED_GLASS_PANE);
        NbtCompound root = new NbtCompound();
        NbtCompound gui = new NbtCompound();
        gui.putString("item", "holder");
        gui.putBoolean("cached", cached);
        gui.put("execute", new NbtCompound());
        root.put("gui", gui);
        GuiItemUtil.setCustomData(stack, root);
        GuiItemUtil.setName(stack, cached ? "Item Holder [CACHED]" : "Item Holder [UNCACHED]");
        return stack;
    }

    public static ItemStack toggleButton(boolean cached) {
        ItemStack stack = new ItemStack(Items.BROWN_STAINED_GLASS_PANE);
        NbtCompound root = new NbtCompound();
        NbtCompound gui = new NbtCompound();
        gui.putString("item", "toggle_button");
        gui.putBoolean("cached", cached);
        gui.put("execute", new NbtCompound());
        root.put("gui", gui);
        GuiItemUtil.setCustomData(stack, root);
        GuiItemUtil.setName(stack, cached ? "Toggle Button [CACHED]" : "Toggle Button [UNCACHED]");
        return stack;
    }

    public static ItemStack dataDrivenButton() {
        ItemStack stack = new ItemStack(Items.PINK_STAINED_GLASS_PANE);
        NbtCompound root = new NbtCompound();
        NbtCompound gui = new NbtCompound();
        gui.putString("item", "data_driven_button");
        gui.put("execute", new NbtCompound());
        root.put("gui", gui);
        GuiItemUtil.setCustomData(stack, root);
        GuiItemUtil.setName(stack, "Data Driven Item Button");
        return stack;
    }

    public static ItemStack dataDrivenPageCreator() {
        ItemStack stack = new ItemStack(Items.PINK_STAINED_GLASS_PANE);
        NbtCompound root = new NbtCompound();
        NbtCompound gui = new NbtCompound();
        gui.putString("item", "data_driven_page_creator");
        gui.put("execute", new NbtCompound());
        root.put("gui", gui);
        GuiItemUtil.setCustomData(stack, root);
        GuiItemUtil.setName(stack, "Data Driven Page Creator");
        return stack;
    }
}
