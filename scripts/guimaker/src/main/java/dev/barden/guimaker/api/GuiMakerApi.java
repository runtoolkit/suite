package dev.barden.guimaker.api;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import net.minecraft.item.ItemStack;
import net.minecraft.server.network.ServerPlayerEntity;
import net.minecraft.text.Text;
import net.minecraft.util.Identifier;

public final class GuiMakerApi {
    private static final Map<Identifier, GuiButtonCallback> BUTTON_CALLBACKS = new HashMap<>();
    private static final Map<Identifier, GuiItemModifier> ITEM_MODIFIERS = new HashMap<>();

    private GuiMakerApi() {
    }

    public static void registerButtonCallback(Identifier id, GuiButtonCallback callback) {
        BUTTON_CALLBACKS.put(id, callback);
    }

    public static void registerItemModifier(Identifier id, GuiItemModifier modifier) {
        ITEM_MODIFIERS.put(id, modifier);
    }

    public static Optional<GuiButtonCallback> getButtonCallback(String id) {
        if (id == null || id.isBlank()) {
            return Optional.empty();
        }

        return Identifier.tryParse(id) == null ? Optional.empty() : Optional.ofNullable(BUTTON_CALLBACKS.get(Identifier.tryParse(id)));
    }

    public static ItemStack applyModifier(String id, ServerPlayerEntity player, ItemStack stack) {
        if (id == null || id.isBlank()) {
            return stack;
        }

        Identifier identifier = Identifier.tryParse(id);
        if (identifier == null) {
            return stack;
        }

        GuiItemModifier modifier = ITEM_MODIFIERS.get(identifier);
        if (modifier == null) {
            return stack;
        }

        return modifier.apply(player, stack.copy());
    }

    public static void registerBuiltins() {
        registerButtonCallback(Identifier.of("guimaker", "close"), (player, state, screen, guiId, page, slot) -> player.closeHandledScreen());
        registerButtonCallback(Identifier.of("guimaker", "refresh"), (player, state, screen, guiId, page, slot) -> screen.refresh());
        registerButtonCallback(Identifier.of("guimaker", "message"), (player, state, screen, guiId, page, slot) -> player.sendMessage(Text.literal("GUI Maker callback invoked."), false));
        registerItemModifier(Identifier.of("guimaker", "noop"), (player, stack) -> stack.copy());
    }
}
