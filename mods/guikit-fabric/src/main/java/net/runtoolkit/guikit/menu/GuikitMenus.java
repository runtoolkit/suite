package net.runtoolkit.guikit.menu;

import net.minecraft.core.Registry;
import net.minecraft.core.registries.BuiltInRegistries;
import net.minecraft.resources.ResourceLocation;
import net.minecraft.world.inventory.MenuType;
import net.fabricmc.fabric.api.screenhandler.v1.ExtendedScreenHandlerType;
import net.runtoolkit.guikit.Guikit;

/**
 * Replaces the datapack's storage-based registry (guikit:reg menus."ns:id" = {...}).
 * In the datapack a menu was a data entry read at fill/probe time; here it is a real
 * MenuType, opened with player.openMenu(...) -- no chest_minecart entity involved.
 *
 * UNVERIFIED: ExtendedScreenHandlerType's exact constructor signature (factory +
 * StreamCodec vs. factory + PacketCodec) has moved between Fabric API releases.
 * Check net.fabricmc.fabric.api.screenhandler.v1.ExtendedScreenHandlerType for the
 * 0.136.x/26.x signature before this compiles -- this file is unbuilt/untested.
 */
public final class GuikitMenus {
    private GuikitMenus() {}

    public static final ResourceLocation MENU_ID =
            ResourceLocation.fromNamespaceAndPath(Guikit.MOD_ID, "menu");

    // ExtendedScreenHandlerType lets the server pass an opening payload (which menu
    // definition, which page) the way the datapack passed storage guikit:in {menu:"ns:id"}.
    public static MenuType<GuikitMenu> GUIKIT_MENU;

    public static void register() {
        GUIKIT_MENU = new ExtendedScreenHandlerType<>(
                (syncId, inventory, opening) -> new GuikitMenu(syncId, inventory, opening),
                GuikitMenuOpening.STREAM_CODEC
        );
        Registry.register(BuiltInRegistries.MENU, MENU_ID, GUIKIT_MENU);
    }
}
