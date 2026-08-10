package dev.barden.guimaker.model;

import net.minecraft.nbt.NbtCompound;

public final class GuiButtonAction {
    private String command = "";
    private String functionId = "";
    private String itemModifierId = "";
    private String soundId = "";
    private GuiChangeMenu changeMenu;

    public String command() {
        return this.command;
    }

    public String functionId() {
        return this.functionId;
    }

    public String itemModifierId() {
        return this.itemModifierId;
    }

    public String soundId() {
        return this.soundId;
    }

    public GuiChangeMenu changeMenu() {
        return this.changeMenu;
    }

    public GuiButtonAction withCommand(String command) {
        this.command = command == null ? "" : command;
        return this;
    }

    public GuiButtonAction withFunctionId(String functionId) {
        this.functionId = functionId == null ? "" : functionId;
        return this;
    }

    public GuiButtonAction withItemModifierId(String itemModifierId) {
        this.itemModifierId = itemModifierId == null ? "" : itemModifierId;
        return this;
    }

    public GuiButtonAction withSoundId(String soundId) {
        this.soundId = soundId == null ? "" : soundId;
        return this;
    }

    public GuiButtonAction withChangeMenu(GuiChangeMenu changeMenu) {
        this.changeMenu = changeMenu;
        return this;
    }

    public boolean hasAnyAction() {
        return !this.command.isBlank() || !this.functionId.isBlank() || !this.itemModifierId.isBlank() || !this.soundId.isBlank() || this.changeMenu != null;
    }

    public GuiButtonAction copy() {
        return new GuiButtonAction()
            .withCommand(this.command)
            .withFunctionId(this.functionId)
            .withItemModifierId(this.itemModifierId)
            .withSoundId(this.soundId)
            .withChangeMenu(this.changeMenu == null ? null : new GuiChangeMenu(this.changeMenu.guiId(), this.changeMenu.page()));
    }

    public NbtCompound toNbt() {
        NbtCompound nbt = new NbtCompound();
        if (!this.command.isBlank()) {
            nbt.putString("command", this.command);
        }
        if (!this.functionId.isBlank()) {
            nbt.putString("function", this.functionId);
        }
        if (!this.itemModifierId.isBlank()) {
            nbt.putString("item_modifier", this.itemModifierId);
        }
        if (!this.soundId.isBlank()) {
            nbt.putString("sound", this.soundId);
        }
        if (this.changeMenu != null) {
            nbt.put("change_menu", this.changeMenu.toNbt());
        }
        return nbt;
    }

    public static GuiButtonAction fromNbt(NbtCompound nbt) {
        GuiButtonAction action = new GuiButtonAction();
        if (nbt.contains("command")) {
            action.withCommand(nbt.getString("command"));
        }
        if (nbt.contains("function")) {
            action.withFunctionId(nbt.getString("function"));
        }
        if (nbt.contains("item_modifier")) {
            action.withItemModifierId(nbt.getString("item_modifier"));
        }
        if (nbt.contains("sound")) {
            action.withSoundId(nbt.getString("sound"));
        }
        if (nbt.contains("change_menu")) {
            action.withChangeMenu(GuiChangeMenu.fromNbt(nbt.getCompound("change_menu")));
        }
        return action;
    }
}
