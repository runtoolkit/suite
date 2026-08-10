package dev.barden.guimaker.model;

import dev.barden.guimaker.util.GuiItemUtil;
import java.util.Collection;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.Map;
import net.minecraft.inventory.Inventory;
import net.minecraft.item.ItemStack;
import net.minecraft.nbt.NbtCompound;
import net.minecraft.nbt.NbtElement;
import net.minecraft.nbt.NbtList;
import net.minecraft.registry.RegistryWrapper;

public final class GuiPage {
    private final int page;
    private String name;
    private int size;
    private final Map<Integer, GuiSlotDefinition> slots = new LinkedHashMap<>();

    public GuiPage(int page, String name, int size) {
        this.page = page;
        this.name = name;
        this.size = size;
    }

    public int page() {
        return this.page;
    }

    public String name() {
        return this.name;
    }

    public int size() {
        return this.size;
    }

    public void rename(String name) {
        this.name = name;
    }

    public Collection<GuiSlotDefinition> slots() {
        return this.slots.values();
    }

    public GuiSlotDefinition getSlot(int slot) {
        return this.slots.get(slot);
    }

    public GuiSlotDefinition getOrCreateSlot(int slot) {
        return this.slots.computeIfAbsent(slot, key -> new GuiSlotDefinition(key, GuiSlotType.SIMPLE_BUTTON, ItemStack.EMPTY));
    }

    public void putSlot(GuiSlotDefinition definition) {
        this.slots.put(definition.slot(), definition);
    }

    public void removeSlot(int slot) {
        this.slots.remove(slot);
    }

    public NbtCompound toNbt(RegistryWrapper.WrapperLookup registries) {
        NbtCompound nbt = new NbtCompound();
        nbt.putInt("page", this.page);
        nbt.putString("name", this.name);
        nbt.putInt("size", this.size);

        NbtList slotList = new NbtList();
        this.slots.values().stream().sorted(Comparator.comparingInt(GuiSlotDefinition::slot)).forEach(slot -> slotList.add(slot.toNbt(registries)));
        nbt.put("slots", slotList);
        return nbt;
    }

    public NbtCompound toDatapackPageNbt(RegistryWrapper.WrapperLookup registries) {
        NbtCompound nbt = new NbtCompound();
        nbt.putInt("PAGE", this.page);
        nbt.putString("NAME", this.name);
        NbtList contents = new NbtList();
        this.slots.values().stream().sorted(Comparator.comparingInt(GuiSlotDefinition::slot)).forEach(slot -> {
            ItemStack stack = slot.exportBaseItem(registries);
            if (!stack.isEmpty()) {
                NbtCompound itemNbt = GuiItemUtil.writeItemStack(stack, registries);
                itemNbt.putByte("Slot", (byte) slot.slot());
                contents.add(itemNbt);
            }
        });
        nbt.put("PAGE_CONTENTS", contents);
        return nbt;
    }

    public static GuiPage fromNbt(NbtCompound nbt, RegistryWrapper.WrapperLookup registries) {
        GuiPage page = new GuiPage(nbt.getInt("page"), nbt.getString("name"), nbt.getInt("size"));
        if (nbt.contains("slots", NbtElement.LIST_TYPE)) {
            NbtList slots = nbt.getList("slots", NbtElement.COMPOUND_TYPE);
            for (NbtElement element : slots) {
                page.putSlot(GuiSlotDefinition.fromNbt((NbtCompound) element, registries));
            }
        }
        return page;
    }

    public static GuiPage captureFromInventory(int pageNumber, String name, Inventory inventory, RegistryWrapper.WrapperLookup registries) {
        int size = normalizeSize(inventory.size());
        GuiPage page = new GuiPage(pageNumber, name, size);
        for (int slot = 0; slot < Math.min(size, inventory.size()); slot++) {
            ItemStack stack = inventory.getStack(slot);
            if (!stack.isEmpty()) {
                page.putSlot(GuiSlotDefinition.capture(slot, stack.copy(), registries));
            }
        }
        return page;
    }

    public static GuiPage fromDatapackPageNbt(NbtCompound nbt, RegistryWrapper.WrapperLookup registries) {
        int pageNumber = nbt.getInt("PAGE");
        String name = nbt.contains("NAME") ? nbt.getString("NAME") : "GUI Page " + pageNumber;
        int size = 27;
        if (nbt.contains("PAGE_CONTENTS", NbtElement.LIST_TYPE)) {
            NbtList contents = nbt.getList("PAGE_CONTENTS", NbtElement.COMPOUND_TYPE);
            for (NbtElement element : contents) {
                if (element instanceof NbtCompound item) {
                    int slot = item.contains("Slot") ? item.getByte("Slot") : 0;
                    size = Math.max(size, normalizeSize(slot + 1));
                }
            }
        }

        GuiPage page = new GuiPage(pageNumber, name, size);
        if (nbt.contains("PAGE_CONTENTS", NbtElement.LIST_TYPE)) {
            NbtList contents = nbt.getList("PAGE_CONTENTS", NbtElement.COMPOUND_TYPE);
            for (NbtElement element : contents) {
                if (element instanceof NbtCompound itemNbt) {
                    int slot = itemNbt.contains("Slot") ? itemNbt.getByte("Slot") : 0;
                    ItemStack stack = ItemStack.fromNbtOrEmpty(registries, itemNbt);
                    if (!stack.isEmpty()) {
                        page.putSlot(GuiSlotDefinition.capture(slot, stack, registries));
                    }
                }
            }
        }
        return page;
    }

    private static int normalizeSize(int rawSize) {
        int clamped = Math.max(9, Math.min(54, rawSize));
        int rows = (int) Math.ceil(clamped / 9.0D);
        return Math.min(54, Math.max(9, rows * 9));
    }
}
