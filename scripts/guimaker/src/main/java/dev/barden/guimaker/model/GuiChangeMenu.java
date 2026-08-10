package dev.barden.guimaker.model;

import net.minecraft.nbt.NbtCompound;

public record GuiChangeMenu(int guiId, int page) {
    public NbtCompound toNbt() {
        NbtCompound nbt = new NbtCompound();
        nbt.putInt("GUI_ID", this.guiId);
        nbt.putInt("PAGE", this.page);
        return nbt;
    }

    public static GuiChangeMenu fromNbt(NbtCompound nbt) {
        return new GuiChangeMenu(nbt.getInt("GUI_ID"), nbt.getInt("PAGE"));
    }
}
