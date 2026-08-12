package com.runtoolkit.rtwpanel.client;

import net.minecraft.client.gui.GuiGraphics;
import net.minecraft.client.gui.components.Button;
import net.minecraft.client.gui.screens.Screen;
import net.minecraft.network.chat.Component;

public class RTWMainMenuScreen extends Screen {
    private final Screen parent;

    public RTWMainMenuScreen(Screen parent) {
        super(Component.literal("RTWrapper Panel"));
        this.parent = parent;
    }

    @Override
    protected void init() {
        int centerX = this.width / 2;
        int startY = this.height / 2 - 40;
        int buttonWidth = 200;
        int buttonHeight = 20;
        int spacing = 24;

        this.addRenderableWidget(Button.builder(
                Component.literal("Storage"),
                btn -> this.minecraft.setScreen(new RTWStorageMenuScreen(this))
            )
            .bounds(centerX - buttonWidth / 2, startY, buttonWidth, buttonHeight)
            .build());

        this.addRenderableWidget(Button.builder(
                Component.literal("Function"),
                btn -> this.minecraft.setScreen(new RTWFunctionCallScreen(this))
            )
            .bounds(centerX - buttonWidth / 2, startY + spacing, buttonWidth, buttonHeight)
            .build());

        this.addRenderableWidget(Button.builder(
                Component.literal("Kapat"),
                btn -> this.onClose()
            )
            .bounds(centerX - buttonWidth / 2, startY + spacing * 2 + 10, buttonWidth, buttonHeight)
            .build());
    }

    @Override
    public void render(GuiGraphics graphics, int mouseX, int mouseY, float partialTick) {
        this.renderBackground(graphics, mouseX, mouseY, partialTick);
        super.render(graphics, mouseX, mouseY, partialTick);
        graphics.drawCenteredString(
            this.font,
            "RTWrapper Panel",
            this.width / 2,
            this.height / 2 - 65,
            0xFFFFFF
        );
        graphics.drawCenteredString(
            this.font,
            "Storage operations and rtwrapper: function call.",
            this.width / 2,
            this.height / 2 - 52,
            0xAAAAAA
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
