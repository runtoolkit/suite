package dev.barden.guimaker.model;

import dev.barden.guimaker.api.GuiMakerApi;
import dev.barden.guimaker.util.GuiItemUtil;
import dev.barden.guimaker.util.GuiMakerItemFactory;
import java.util.ArrayList;
import java.util.List;
import net.minecraft.item.ItemStack;
import net.minecraft.nbt.NbtCompound;
import net.minecraft.nbt.NbtElement;
import net.minecraft.registry.RegistryWrapper;
import net.minecraft.server.network.ServerPlayerEntity;

public final class GuiSlotDefinition {
    private final int slot;
    private GuiSlotType type;
    private boolean cached;
    private ItemStack iconStack;
    private final List<ItemStack> toggleStacks = new ArrayList<>();
    private int uncachedToggleIndex;
    private ItemStack uncachedHolderStack = ItemStack.EMPTY;
    private GuiButtonAction action = new GuiButtonAction();

    public GuiSlotDefinition(int slot, GuiSlotType type, ItemStack iconStack) {
        this.slot = slot;
        this.type = type;
        this.iconStack = iconStack.copy();
    }

    public int slot() {
        return this.slot;
    }

    public GuiSlotType type() {
        return this.type;
    }

    public boolean cached() {
        return this.cached;
    }

    public ItemStack iconStack() {
        return this.iconStack.copy();
    }

    public GuiButtonAction action() {
        return this.action;
    }

    public List<ItemStack> toggleStacks() {
        return this.toggleStacks.stream().map(ItemStack::copy).toList();
    }

    public GuiSlotDefinition setType(GuiSlotType type) {
        this.type = type;
        return this;
    }

    public GuiSlotDefinition setCached(boolean cached) {
        this.cached = cached;
        return this;
    }

    public GuiSlotDefinition setIconStack(ItemStack iconStack) {
        this.iconStack = iconStack.copy();
        return this;
    }

    public GuiSlotDefinition setAction(GuiButtonAction action) {
        this.action = action == null ? new GuiButtonAction() : action;
        return this;
    }

    public GuiSlotDefinition setToggleStacks(List<ItemStack> toggleStacks) {
        this.toggleStacks.clear();
        toggleStacks.stream().filter(stack -> !stack.isEmpty()).map(ItemStack::copy).forEach(this.toggleStacks::add);
        if (this.toggleStacks.isEmpty() && !this.iconStack.isEmpty()) {
            this.toggleStacks.add(this.iconStack.copy());
        }
        this.uncachedToggleIndex = 0;
        return this;
    }

    public ItemStack buildDisplayStack(ServerPlayerEntity player, PlayerGuiCache cache, int guiId, int pageId) {
        ItemStack base = switch (this.type) {
            case ITEM_HOLDER -> this.getHolderStack(cache, guiId, pageId);
            case TOGGLE_BUTTON -> this.getCurrentToggleStack(cache, guiId, pageId);
            default -> this.iconStack.copy();
        };

        if (base.isEmpty()) {
            base = this.defaultTemplateItem();
        }

        GuiButtonAction effectiveAction = this.effectiveAction(cache, guiId, pageId);
        return GuiMakerApi.applyModifier(effectiveAction.itemModifierId(), player, base);
    }

    public GuiButtonAction effectiveAction(PlayerGuiCache cache, int guiId, int pageId) {
        if (this.type == GuiSlotType.TOGGLE_BUTTON) {
            ItemStack current = this.getCurrentToggleStack(cache, guiId, pageId);
            GuiButtonAction embedded = readEmbeddedAction(current);
            if (embedded.hasAnyAction()) {
                return embedded;
            }
        }
        return this.action.copy();
    }

    public void cycleToggle(PlayerGuiCache cache, int guiId, int pageId) {
        if (this.toggleStacks.isEmpty()) {
            this.toggleStacks.add(this.iconStack.copy());
        }
        int next = (this.getToggleIndex(cache, guiId, pageId) + 1) % Math.max(this.toggleStacks.size(), 1);
        if (this.cached) {
            cache.setToggleIndex(this.cacheKey(guiId, pageId), next);
        } else {
            this.uncachedToggleIndex = next;
        }
    }

    public ItemStack getHolderStack(PlayerGuiCache cache, int guiId, int pageId) {
        if (this.cached) {
            ItemStack cachedStack = cache.getHolder(this.cacheKey(guiId, pageId));
            return cachedStack.isEmpty() ? this.defaultTemplateItem() : cachedStack;
        }
        return this.uncachedHolderStack.isEmpty() ? this.defaultTemplateItem() : this.uncachedHolderStack.copy();
    }

    public void setHolderStack(PlayerGuiCache cache, ItemStack stack, int guiId, int pageId) {
        if (this.cached) {
            cache.setHolder(this.cacheKey(guiId, pageId), stack);
        } else {
            this.uncachedHolderStack = stack == null ? ItemStack.EMPTY : stack.copy();
        }
    }

    public ItemStack getCurrentToggleStack(PlayerGuiCache cache, int guiId, int pageId) {
        if (this.toggleStacks.isEmpty()) {
            return this.iconStack.copy();
        }
        int index = Math.floorMod(this.getToggleIndex(cache, guiId, pageId), this.toggleStacks.size());
        return this.toggleStacks.get(index).copy();
    }

    private int getToggleIndex(PlayerGuiCache cache, int guiId, int pageId) {
        return this.cached ? cache.getToggleIndex(this.cacheKey(guiId, pageId)) : this.uncachedToggleIndex;
    }

    private String cacheKey(int guiId, int pageId) {
        return GuiItemUtil.slotKey(guiId, pageId, this.slot);
    }

    public ItemStack exportBaseItem(RegistryWrapper.WrapperLookup registries) {
        ItemStack stack = switch (this.type) {
            case ITEM_HOLDER -> this.defaultTemplateItem();
            case TOGGLE_BUTTON -> this.toggleStacks.isEmpty() ? this.defaultTemplateItem() : this.toggleStacks.get(0).copy();
            default -> this.iconStack.copy();
        };

        NbtCompound root = GuiItemUtil.getCustomData(stack);
        NbtCompound gui = root.contains("gui", NbtElement.COMPOUND_TYPE) ? root.getCompound("gui") : new NbtCompound();
        gui.putString("item", this.type.serializedName());
        if (this.cached) {
            gui.putBoolean("cached", true);
        }
        gui.put("execute", this.action.toNbt());

        if (this.type == GuiSlotType.TOGGLE_BUTTON && !this.toggleStacks.isEmpty()) {
            NbtCompound extras = gui.contains("extras", NbtElement.COMPOUND_TYPE) ? gui.getCompound("extras") : new NbtCompound();
            extras.put("togglebutton_list", GuiItemUtil.writeItemStackList(this.toggleStacks, registries));
            gui.put("extras", extras);
        }

        root.put("gui", gui);
        GuiItemUtil.setCustomData(stack, root);
        return stack;
    }

    public ItemStack defaultTemplateItem() {
        return switch (this.type) {
            case ITEM_HOLDER -> GuiMakerItemFactory.itemHolder(this.cached);
            case TOGGLE_BUTTON -> GuiMakerItemFactory.toggleButton(this.cached);
            case DATA_DRIVEN_BUTTON -> GuiMakerItemFactory.dataDrivenButton();
            case DATA_DRIVEN_PAGE_CREATOR -> GuiMakerItemFactory.dataDrivenPageCreator();
            default -> this.iconStack.isEmpty() ? ItemStack.EMPTY : this.iconStack.copy();
        };
    }

    public NbtCompound toNbt(RegistryWrapper.WrapperLookup registries) {
        NbtCompound nbt = new NbtCompound();
        nbt.putInt("slot", this.slot);
        nbt.putString("type", this.type.name());
        nbt.putBoolean("cached", this.cached);
        nbt.put("icon", GuiItemUtil.writeItemStack(this.iconStack, registries));
        nbt.put("action", this.action.toNbt());
        if (!this.uncachedHolderStack.isEmpty()) {
            nbt.put("holder", GuiItemUtil.writeItemStack(this.uncachedHolderStack, registries));
        }
        if (!this.toggleStacks.isEmpty()) {
            nbt.put("toggle_stacks", GuiItemUtil.writeItemStackList(this.toggleStacks, registries));
            nbt.putInt("toggle_index", this.uncachedToggleIndex);
        }
        return nbt;
    }

    public static GuiSlotDefinition fromNbt(NbtCompound nbt, RegistryWrapper.WrapperLookup registries) {
        GuiSlotDefinition definition = new GuiSlotDefinition(
            nbt.getInt("slot"),
            GuiSlotType.valueOf(nbt.getString("type")),
            ItemStack.fromNbtOrEmpty(registries, nbt.getCompound("icon"))
        );
        definition.cached = nbt.getBoolean("cached");
        if (nbt.contains("action", NbtElement.COMPOUND_TYPE)) {
            definition.action = GuiButtonAction.fromNbt(nbt.getCompound("action"));
        }
        if (nbt.contains("holder", NbtElement.COMPOUND_TYPE)) {
            definition.uncachedHolderStack = ItemStack.fromNbtOrEmpty(registries, nbt.getCompound("holder"));
        }
        if (nbt.contains("toggle_stacks", NbtElement.LIST_TYPE)) {
            definition.toggleStacks.addAll(GuiItemUtil.readItemStackList(nbt, "toggle_stacks", registries));
            definition.uncachedToggleIndex = nbt.getInt("toggle_index");
        }
        return definition;
    }

    public static GuiSlotDefinition capture(int slot, ItemStack source, RegistryWrapper.WrapperLookup registries) {
        ItemStack icon = source.copy();
        NbtCompound gui = GuiItemUtil.getGuiData(source);
        String typeName = gui.contains("item") ? gui.getString("item") : "simple_button";
        GuiSlotDefinition definition = new GuiSlotDefinition(slot, GuiSlotType.fromString(typeName), icon);
        definition.cached = gui.contains("cached") && gui.getBoolean("cached");

        if (gui.contains("execute", NbtElement.COMPOUND_TYPE)) {
            definition.action = GuiButtonAction.fromNbt(gui.getCompound("execute"));
        }

        if (definition.type == GuiSlotType.TOGGLE_BUTTON) {
            if (gui.contains("extras", NbtElement.COMPOUND_TYPE)) {
                NbtCompound extras = gui.getCompound("extras");
                definition.toggleStacks.addAll(GuiItemUtil.readItemStackList(extras, "togglebutton_list", registries));
            }
            if (definition.toggleStacks.isEmpty()) {
                definition.toggleStacks.add(icon.copy());
            }
        }

        return definition;
    }

    private static GuiButtonAction readEmbeddedAction(ItemStack stack) {
        NbtCompound gui = GuiItemUtil.getGuiData(stack);
        if (gui.contains("execute", NbtElement.COMPOUND_TYPE)) {
            return GuiButtonAction.fromNbt(gui.getCompound("execute"));
        }
        return new GuiButtonAction();
    }
}
