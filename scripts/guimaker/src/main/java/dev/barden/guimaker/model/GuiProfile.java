package dev.barden.guimaker.model;

import java.util.Collection;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.Map;
import net.minecraft.inventory.Inventory;
import net.minecraft.nbt.NbtCompound;
import net.minecraft.nbt.NbtElement;
import net.minecraft.nbt.NbtList;
import net.minecraft.registry.RegistryWrapper;

public final class GuiProfile {
    private final int guiId;
    private final Map<Integer, GuiPage> pages = new LinkedHashMap<>();

    public GuiProfile(int guiId) {
        this.guiId = guiId;
    }

    public int guiId() {
        return this.guiId;
    }

    public Collection<GuiPage> pages() {
        return this.pages.values();
    }

    public GuiPage getPage(int page) {
        return this.pages.get(page);
    }

    public GuiPage addCapturedPage(String name, Inventory inventory, RegistryWrapper.WrapperLookup registries) {
        int pageNumber = this.pages.isEmpty() ? 1 : this.pages.keySet().stream().max(Integer::compareTo).orElse(0) + 1;
        GuiPage page = GuiPage.captureFromInventory(pageNumber, name == null || name.isBlank() ? defaultName(pageNumber) : name, inventory, registries);
        this.pages.put(pageNumber, page);
        return page;
    }

    public void putPage(GuiPage page) {
        this.pages.put(page.page(), page);
    }

    public void removePage(int page) {
        this.pages.remove(page);
    }

    public NbtCompound toNbt(RegistryWrapper.WrapperLookup registries) {
        NbtCompound nbt = new NbtCompound();
        nbt.putInt("gui_id", this.guiId);
        NbtList pages = new NbtList();
        this.pages.values().stream().sorted(Comparator.comparingInt(GuiPage::page)).forEach(page -> pages.add(page.toNbt(registries)));
        nbt.put("pages", pages);
        return nbt;
    }

    public NbtCompound toDatapackProfileNbt(RegistryWrapper.WrapperLookup registries) {
        NbtCompound nbt = new NbtCompound();
        nbt.putInt("GUI_ID", this.guiId);
        NbtList pages = new NbtList();
        this.pages.values().stream().sorted(Comparator.comparingInt(GuiPage::page)).forEach(page -> pages.add(page.toDatapackPageNbt(registries)));
        nbt.put("PAGES", pages);
        return nbt;
    }

    public static GuiProfile fromNbt(NbtCompound nbt, RegistryWrapper.WrapperLookup registries) {
        GuiProfile profile = new GuiProfile(nbt.getInt("gui_id"));
        if (nbt.contains("pages", NbtElement.LIST_TYPE)) {
            NbtList pages = nbt.getList("pages", NbtElement.COMPOUND_TYPE);
            for (NbtElement element : pages) {
                profile.putPage(GuiPage.fromNbt((NbtCompound) element, registries));
            }
        }
        return profile;
    }

    public static GuiProfile fromDatapackProfileNbt(NbtCompound nbt, RegistryWrapper.WrapperLookup registries) {
        GuiProfile profile = new GuiProfile(nbt.getInt("GUI_ID"));
        if (nbt.contains("PAGES", NbtElement.LIST_TYPE)) {
            NbtList pages = nbt.getList("PAGES", NbtElement.COMPOUND_TYPE);
            for (NbtElement element : pages) {
                profile.putPage(GuiPage.fromDatapackPageNbt((NbtCompound) element, registries));
            }
        }
        return profile;
    }

    private static String defaultName(int pageNumber) {
        return "GUI PAGE #" + pageNumber;
    }
}
