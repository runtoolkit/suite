package dev.barden.guimaker.screen;

import dev.barden.guimaker.api.GuiMakerApi;
import dev.barden.guimaker.model.GuiButtonAction;
import dev.barden.guimaker.model.GuiChangeMenu;
import dev.barden.guimaker.model.GuiPage;
import dev.barden.guimaker.model.GuiProfile;
import dev.barden.guimaker.model.GuiSlotDefinition;
import dev.barden.guimaker.model.PlayerGuiCache;
import dev.barden.guimaker.state.GuiMakerState;
import net.minecraft.entity.player.PlayerEntity;
import net.minecraft.entity.player.PlayerInventory;
import net.minecraft.inventory.SimpleInventory;
import net.minecraft.item.ItemStack;
import net.minecraft.screen.GenericContainerScreenHandler;
import net.minecraft.screen.NamedScreenHandlerFactory;
import net.minecraft.screen.ScreenHandlerType;
import net.minecraft.screen.SimpleNamedScreenHandlerFactory;
import net.minecraft.screen.slot.SlotActionType;
import net.minecraft.server.command.ServerCommandSource;
import net.minecraft.server.network.ServerPlayerEntity;
import net.minecraft.sound.SoundCategory;
import net.minecraft.sound.SoundEvent;
import net.minecraft.text.Text;
import net.minecraft.util.Identifier;

public final class GuiMakerScreenHandler extends GenericContainerScreenHandler {
    private final GuiMakerState state;
    private final ServerPlayerEntity player;
    private final int guiId;
    private final int pageId;
    private final GuiPage page;
    private final PlayerGuiCache cache;
    private final SimpleInventory viewInventory;

    public GuiMakerScreenHandler(int syncId, PlayerInventory playerInventory, GuiMakerState state, ServerPlayerEntity player, int guiId, int pageId, GuiPage page) {
        this(syncId, playerInventory, state, player, guiId, pageId, page, new SimpleInventory(page.size()));
    }

    private GuiMakerScreenHandler(int syncId, PlayerInventory playerInventory, GuiMakerState state, ServerPlayerEntity player, int guiId, int pageId, GuiPage page, SimpleInventory viewInventory) {
        super(screenTypeForRows(page.size() / 9), syncId, playerInventory, viewInventory, page.size() / 9);
        this.state = state;
        this.player = player;
        this.guiId = guiId;
        this.pageId = pageId;
        this.page = page;
        this.cache = state.cacheFor(player.getUuid());
        this.viewInventory = viewInventory;
        this.refresh();
    }

    public static void open(ServerPlayerEntity player, GuiMakerState state, int guiId, int pageId) {
        GuiProfile profile = state.getProfile(guiId);
        if (profile == null) {
            player.sendMessage(Text.literal("[GuiMaker] GUI profile not found: " + guiId), false);
            return;
        }

        GuiPage page = profile.getPage(pageId);
        if (page == null) {
            player.sendMessage(Text.literal("[GuiMaker] GUI page not found: " + guiId + "/" + pageId), false);
            return;
        }

        NamedScreenHandlerFactory factory = new SimpleNamedScreenHandlerFactory(
            (syncId, inventory, user) -> new GuiMakerScreenHandler(syncId, inventory, state, player, guiId, pageId, page),
            Text.literal(page.name())
        );
        player.openHandledScreen(factory);
    }

    public void refresh() {
        for (int slot = 0; slot < this.page.size(); slot++) {
            GuiSlotDefinition definition = this.page.getSlot(slot);
            ItemStack display = definition == null ? ItemStack.EMPTY : definition.buildDisplayStack(this.player, this.cache, this.guiId, this.pageId);
            this.viewInventory.setStack(slot, display);
        }
        this.sendContentUpdates();
    }

    @Override
    public void onSlotClick(int slotIndex, int button, SlotActionType actionType, PlayerEntity playerEntity) {
        if (!(playerEntity instanceof ServerPlayerEntity serverPlayer)) {
            super.onSlotClick(slotIndex, button, actionType, playerEntity);
            return;
        }

        if (slotIndex >= 0 && slotIndex < this.page.size()) {
            GuiSlotDefinition definition = this.page.getSlot(slotIndex);
            if (definition == null) {
                return;
            }

            if (actionType == SlotActionType.QUICK_MOVE || actionType == SlotActionType.SWAP || actionType == SlotActionType.THROW || actionType == SlotActionType.CLONE) {
                return;
            }

            switch (definition.type()) {
                case ITEM_HOLDER -> this.handleHolderClick(serverPlayer, definition, slotIndex, actionType);
                case TOGGLE_BUTTON -> this.handleToggleClick(serverPlayer, definition);
                case SIMPLE_BUTTON, DATA_DRIVEN_BUTTON, DATA_DRIVEN_PAGE_CREATOR -> this.executeAction(serverPlayer, definition.action(), slotIndex);
            }

            this.state.markDirty();
            this.refresh();
            return;
        }

        if (actionType == SlotActionType.QUICK_MOVE) {
            return;
        }

        super.onSlotClick(slotIndex, button, actionType, playerEntity);
    }

    @Override
    public ItemStack quickMove(PlayerEntity player, int slot) {
        return ItemStack.EMPTY;
    }

    private void handleToggleClick(ServerPlayerEntity player, GuiSlotDefinition definition) {
        definition.cycleToggle(this.cache, this.guiId, this.pageId);
        GuiButtonAction action = definition.effectiveAction(this.cache, this.guiId, this.pageId);
        this.executeAction(player, action, definition.slot());
    }

    private void handleHolderClick(ServerPlayerEntity player, GuiSlotDefinition definition, int slot, SlotActionType actionType) {
        if (actionType != SlotActionType.PICKUP) {
            return;
        }

        ItemStack cursor = this.getCursorStack();
        ItemStack holder = definition.getHolderStack(this.cache, this.guiId, this.pageId);
        ItemStack template = definition.defaultTemplateItem();
        if (!holder.isEmpty() && !template.isEmpty() && ItemStack.areItemsAndComponentsEqual(holder, template)) {
            holder = ItemStack.EMPTY;
        }

        if (cursor.isEmpty() && holder.isEmpty()) {
            return;
        }

        if (cursor.isEmpty()) {
            this.setCursorStack(holder.copy());
            definition.setHolderStack(this.cache, ItemStack.EMPTY, this.guiId, this.pageId);
        } else {
            ItemStack newHolder = cursor.copy();
            this.setCursorStack(holder.copy());
            definition.setHolderStack(this.cache, newHolder, this.guiId, this.pageId);
        }

        this.executeAction(player, definition.action(), slot);
    }

    private void executeAction(ServerPlayerEntity player, GuiButtonAction action, int slot) {
        if (!action.command().isBlank()) {
            String command = action.command().startsWith("/") ? action.command().substring(1) : action.command();
            ServerCommandSource source = player.getCommandSource();
            player.getServer().getCommandManager().executeWithPrefix(source, command);
        }

        if (!action.functionId().isBlank()) {
            GuiMakerApi.getButtonCallback(action.functionId()).ifPresent(callback -> callback.run(player, this.state, this, this.guiId, this.pageId, slot));
        }

        if (!action.soundId().isBlank()) {
            Identifier id = Identifier.tryParse(action.soundId());
            if (id != null) {
                player.getWorld().playSound(null, player.getBlockPos(), SoundEvent.of(id), SoundCategory.PLAYERS, 1.0F, 1.0F);
            }
        }

        GuiChangeMenu changeMenu = action.changeMenu();
        if (changeMenu != null) {
            open(player, this.state, changeMenu.guiId(), changeMenu.page());
        }
    }

    private static ScreenHandlerType<?> screenTypeForRows(int rows) {
        return switch (rows) {
            case 1 -> ScreenHandlerType.GENERIC_9X1;
            case 2 -> ScreenHandlerType.GENERIC_9X2;
            case 3 -> ScreenHandlerType.GENERIC_9X3;
            case 4 -> ScreenHandlerType.GENERIC_9X4;
            case 5 -> ScreenHandlerType.GENERIC_9X5;
            default -> ScreenHandlerType.GENERIC_9X6;
        };
    }
}
