package com.runtoolkit.rtwpanel.client;

import net.minecraft.client.gui.GuiGraphics;
import net.minecraft.client.gui.components.Button;
import net.minecraft.client.gui.components.EditBox;
import net.minecraft.client.gui.screens.Screen;
import net.minecraft.network.chat.Component;

public class RTWFunctionCallScreen extends Screen {
    private final Screen parent;
    private EditBox funcBox;

    public RTWFunctionCallScreen(Screen parent) {
        super(Component.literal("rtwrapper: Fonksiyon Cagir"));
        this.parent = parent;
    }

    @Override
    protected void init() {
        int centerX = this.width / 2;
        int fieldWidth = 250;
        int y = this.height / 2 - 30;

        funcBox = new EditBox(this.font, centerX - fieldWidth / 2, y, fieldWidth, 20,
            Component.literal("Fonksiyon ID"));
        funcBox.setValue("rtwrapper:");
        funcBox.setMaxLength(256);
        this.addRenderableWidget(funcBox);

        this.addRenderableWidget(Button.builder(
                Component.literal("Calistir"),
                btn -> {
                    String func = funcBox.getValue().trim();
                    if (!func.isEmpty()) {
                        RTWCommandSender.send("function " + func);
                    }
                }
            )
            .bounds(centerX - fieldWidth / 2, y + 26, fieldWidth, 20)
            .build());

        this.addRenderableWidget(Button.builder(
                Component.literal("< Geri"),
                btn -> this.onClose()
            )
            .bounds(centerX - fieldWidth / 2, y + 50, fieldWidth, 20)
            .build());
    }

    @Override
    public void render(GuiGraphics graphics, int mouseX, int mouseY, float partialTick) {
        this.renderBackground(graphics, mouseX, mouseY, partialTick);
        super.render(graphics, mouseX, mouseY, partialTick);
        graphics.drawCenteredString(
            this.font, "rtwrapper: Fonksiyon Cagir", this.width / 2, this.height / 2 - 48, 0xFFFFFF
        );
        graphics.drawCenteredString(
            this.font, "Ornek: rtwrapper:api/commands/data", this.width / 2, this.height / 2 - 36, 0xAAAAAA
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
