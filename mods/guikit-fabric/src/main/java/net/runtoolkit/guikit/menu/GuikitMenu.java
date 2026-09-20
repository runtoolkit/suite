package net.runtoolkit.guikit.menu;

import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.SimpleContainer;
import net.minecraft.world.entity.player.Inventory;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.inventory.AbstractContainerMenu;
import net.minecraft.world.inventory.ClickType;
import net.minecraft.world.inventory.Slot;
import net.minecraft.world.item.ItemStack;

/**
 * Fabric port of the whole chest_minecart mechanic.
 *
 * datapack: widget items are stamped onto a chest_minecart. Left-click moves the item OUT
 * of the cart into the player's inventory; #guikit:fill re-runs to refill the empty slot;
 * clear detects the item that left, the handler runs, item removed, redraw if dirty.
 * A second function (internal/follow) keeps the cart teleporting onto the owning player
 * every tick so it can't be walked away from or opened by someone else.
 *
 * Fabric: none of that exists. AbstractContainerMenu#clicked is the actual click trigger.
 * We intercept it for the container's own slots (0..slots()-1), run the definition's
 * onClick directly, and never call the vanilla pickup/move logic -- the item never leaves
 * the slot, so there is nothing to "clear" or refill, and nothing to keep server-side state
 * in sync with (no follow-teleport, no redraw-every-tick). Player-inventory slots (the
 * bottom 36) keep normal vanilla behaviour so players can still manage their own items
 * while a menu is open, matching what the datapack did by never touching the player's real
 * inventory in the first place.
 */
public class GuikitMenu extends AbstractContainerMenu {
    private static final int PLAYER_INV_SIZE = 36;

    private final SimpleContainer container;
    private final GuikitMenuDefinition definition;
    private final ServerPlayer serverPlayer; // null on the client
    private int page = 0;

    public GuikitMenu(int syncId, Inventory playerInventory, GuikitMenuOpening opening) {
        super(GuikitMenus.GUIKIT_MENU, syncId);
        this.definition = GuikitMenuDefinitions.get(opening.menuId());
        if (this.definition == null) {
            throw new IllegalStateException("guikit: no menu registered for " + opening.menuId()
                    + " (was #guikit:register equivalent -- call GuikitMenuDefinitions.register first)");
        }
        this.page = opening.page();
        this.container = new SimpleContainer(definition.slots());
        this.serverPlayer = playerInventory.player instanceof ServerPlayer sp ? sp : null;

        int rows = definition.slots() / 9;
        for (int row = 0; row < rows; row++) {
            for (int col = 0; col < 9; col++) {
                int index = row * 9 + col;
                addSlot(new Slot(container, index, 8 + col * 18, 18 + row * 18));
            }
        }
        int invY = 18 + rows * 18 + 14;
        for (int row = 0; row < 3; row++) {
            for (int col = 0; col < 9; col++) {
                addSlot(new Slot(playerInventory, col + row * 9 + 9, 8 + col * 18, invY + row * 18));
            }
        }
        for (int col = 0; col < 9; col++) {
            addSlot(new Slot(playerInventory, col, 8 + col * 18, invY + 58));
        }

        if (serverPlayer != null) {
            redraw();
        }
    }

    /** Was #guikit:fill: re-run the definition's draw for the current page. */
    public void redraw() {
        if (serverPlayer == null) return;
        definition.draw(serverPlayer, container, page);
        broadcastChanges();
    }

    /** Was function guikit:widget/goto_page: set the page and redraw, nothing else touches state. */
    public void gotoPage(int newPage) {
        this.page = newPage;
        redraw();
    }

    @Override
    public void clicked(int slotId, int button, ClickType clickType, Player player) {
        boolean isContainerSlot = slotId >= 0 && slotId < definition.slots();
        if (isContainerSlot && serverPlayer != null) {
            definition.onClick(serverPlayer, this, slotId, page);
            return; // never call super -- the widget item never moves or leaves the slot
        }
        super.clicked(slotId, button, clickType, player);
    }

    @Override
    public ItemStack quickMoveStack(Player player, int index) {
        // Shift-click on a widget slot must not extract it either.
        return ItemStack.EMPTY;
    }

    @Override
    public boolean stillValid(Player player) {
        return true; // no chest_minecart to lose line-of-sight to; menu stays open until closed
    }

    public GuikitMenuDefinition definition() {
        return definition;
    }
}
