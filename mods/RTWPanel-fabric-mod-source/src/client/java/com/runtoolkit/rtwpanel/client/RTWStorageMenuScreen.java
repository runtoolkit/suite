package com.runtoolkit.rtwpanel.client;

import net.minecraft.client.gui.GuiGraphics;
import net.minecraft.client.gui.components.Button;
import net.minecraft.client.gui.screens.Screen;
import net.minecraft.network.chat.Component;

public class RTWStorageMenuScreen extends Screen {
    private final Screen parent;

    public RTWStorageMenuScreen(Screen parent) {
        super(Component.literal("Storage Islemleri"));
        this.parent = parent;
    }

    @Override
    protected void init() {
        int centerX = this.width / 2;
        int startY = this.height / 2 - 60;
        int buttonWidth = 200;
        int buttonHeight = 20;
        int spacing = 24;

        this.addRenderableWidget(Button.builder(
                Component.literal("GET"),
                btn -> this.minecraft.setScreen(new RTWStorageFormScreen(this, RTWStorageFormScreen.Mode.GET))
            )
            .bounds(centerX - buttonWidth / 2, startY, buttonWidth, buttonHeight)
            .build());

        this.addRenderableWidget(Button.builder(
                Component.literal("SET"),
                btn -> this.minecraft.setScreen(new RTWStorageFormScreen(this, RTWStorageFormScreen.Mode.SET))
            )
            .bounds(centerX - buttonWidth / 2, startY + spacing, buttonWidth, buttonHeight)
            .build());

        this.addRenderableWidget(Button.builder(
                Component.literal("REMOVE"),
                btn -> this.minecraft.setScreen(new RTWStorageFormScreen(this, RTWStorageFormScreen.Mode.REMOVE))
            )
            .bounds(centerX - buttonWidth / 2, startY + spacing * 2, buttonWidth, buttonHeight)
            .build());

        this.addRenderableWidget(Button.builder(
                Component.literal("MODIFY"),
                btn -> this.minecraft.setScreen(new RTWStorageFormScreen(this, RTWStorageFormScreen.Mode.MODIFY))
            )
            .bounds(centerX - buttonWidth / 2, startY + spacing * 3, buttonWidth, buttonHeight)
            .build());

        this.addRenderableWidget(Button.builder(
                Component.literal("< Geri"),
                btn -> this.onClose()
            )
            .bounds(centerX - buttonWidth / 2, startY + spacing * 4 + 10, buttonWidth, buttonHeight)
            .build());
    }

    @Override
    public void render(GuiGraphics graphics, int mouseX, int mouseY, float partialTick) {
        this.renderBackground(graphics, mouseX, mouseY, partialTick);
        super.render(graphics, mouseX, mouseY, partialTick);
        graphics.drawCenteredString(
            this.font, "Storage Islemleri", this.width / 2, this.height / 2 - 80, 0xFFFFFF
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
