package com.runtoolkit.rtwpanel.client;

import net.minecraft.client.gui.GuiGraphics;
import net.minecraft.client.gui.components.Button;
import net.minecraft.client.gui.components.EditBox;
import net.minecraft.client.gui.screens.Screen;
import net.minecraft.network.chat.Component;

public class RTWStorageFormScreen extends Screen {

    public enum Mode { GET, SET, REMOVE, MODIFY }

    private final Screen parent;
    private final Mode mode;

    private EditBox targetKindBox;
    private EditBox targetBox;
    private EditBox pathBox;
    private EditBox modifyModeBox; // yalnizca MODIFY: merge/set/append/prepend
    private EditBox valueBox;      // SET ve MODIFY icin

    public RTWStorageFormScreen(Screen parent, Mode mode) {
        super(Component.literal("Storage: " + mode.name()));
        this.parent = parent;
        this.mode = mode;
    }

    @Override
    protected void init() {
        int centerX = this.width / 2;
        int fieldWidth = 220;
        int y = this.height / 2 - 90;
        int rowHeight = 22;

        targetKindBox = new EditBox(this.font, centerX - fieldWidth / 2, y, fieldWidth, 20,
            Component.literal("Hedef turu"));
        targetKindBox.setValue("storage");
        targetKindBox.setHint(Component.literal("storage | entity | block"));
        this.addRenderableWidget(targetKindBox);
        y += rowHeight;

        targetBox = new EditBox(this.font, centerX - fieldWidth / 2, y, fieldWidth, 20,
            Component.literal("Hedef"));
        targetBox.setValue("rtwpanel:test");
        targetBox.setMaxLength(256);
        this.addRenderableWidget(targetBox);
        y += rowHeight;

        pathBox = new EditBox(this.font, centerX - fieldWidth / 2, y, fieldWidth, 20,
            Component.literal("NBT path"));
        pathBox.setMaxLength(256);
        this.addRenderableWidget(pathBox);
        y += rowHeight;

        if (mode == Mode.MODIFY) {
            modifyModeBox = new EditBox(this.font, centerX - fieldWidth / 2, y, fieldWidth, 20,
                Component.literal("Mod"));
            modifyModeBox.setValue("merge");
            modifyModeBox.setHint(Component.literal("merge | set | append | prepend"));
            this.addRenderableWidget(modifyModeBox);
            y += rowHeight;
        }

        if (mode == Mode.SET || mode == Mode.MODIFY) {
            valueBox = new EditBox(this.font, centerX - fieldWidth / 2, y, fieldWidth, 20,
                Component.literal("Deger (SNBT)"));
            valueBox.setMaxLength(512);
            this.addRenderableWidget(valueBox);
            y += rowHeight;
        }

        y += 10;
        int buttonWidth = 220;

        this.addRenderableWidget(Button.builder(
                Component.literal("Calistir"),
                btn -> runCommand()
            )
            .bounds(centerX - buttonWidth / 2, y, buttonWidth, 20)
            .build());

        this.addRenderableWidget(Button.builder(
                Component.literal("< Geri"),
                btn -> this.onClose()
            )
            .bounds(centerX - buttonWidth / 2, y + 24, buttonWidth, 20)
            .build());
    }

    private void runCommand() {
        String targetKind = targetKindBox.getValue().trim();
        String target = targetBox.getValue().trim();
        String path = pathBox.getValue().trim();

        StringBuilder cmd = new StringBuilder("function rtwrapper:api/commands/data {");
        cmd.append("target_kind:\"").append(escape(targetKind)).append("\",");
        cmd.append("target:\"").append(escape(target)).append("\",");
        cmd.append("path:\"").append(escape(path)).append("\",");
        cmd.append("op:\"").append(mode.name().toLowerCase()).append("\"");

        if (mode == Mode.MODIFY) {
            String modifyMode = modifyModeBox.getValue().trim();
            cmd.append(",mode:\"").append(escape(modifyMode)).append("\"");
        }
        if (mode == Mode.SET || mode == Mode.MODIFY) {
            String value = valueBox.getValue().trim();
            // value ham SNBT olarak gonderilir, tirnaklanmaz
            cmd.append(",value:").append(value.isEmpty() ? "{}" : value);
        }
        cmd.append("}");

        RTWCommandSender.send(cmd.toString());
    }

    private static String escape(String s) {
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }

    @Override
    public void render(GuiGraphics graphics, int mouseX, int mouseY, float partialTick) {
        this.renderBackground(graphics, mouseX, mouseY, partialTick);
        super.render(graphics, mouseX, mouseY, partialTick);
        graphics.drawCenteredString(
            this.font, "Storage: " + mode.name(), this.width / 2, this.height / 2 - 108, 0xFFFFFF
        );
    }

    @Override
    public void onClose() {
        this.minecraft.setScreen(this.parent);
    }

    @Override
    public boolean isPauseScreen() {
        return false;
    }
}
