package net.runtoolkit.guikit.menu;

import net.minecraft.network.chat.Component;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.Container;

/**
 * One "menu" as the datapack defined it: a #guikit:register entry (title/size) plus the
 * #guikit:fill listener (draw) plus the #guikit:probe listener (click dispatch). All three
 * live together here instead of three separate data-driven tag callbacks.
 */
public interface GuikitMenuDefinition {
    Component title();

    /** Container size, e.g. 27 for a chest-sized menu (was the "container" registry's `slots`). */
    int slots();

    /** Fill the container for the given page. Was #guikit:fill + widget/pad + widget/draw. */
    void draw(ServerPlayer player, Container container, int page);

    /**
     * A container slot was left-clicked. Was #guikit:probe: one {id, fn} line per clickable
     * widget, matched against the slot the click came from. The click never moves or removes
     * the item -- see GuikitMenu#clicked -- so there is no re-draw-after-every-click step
     * unless this handler itself calls container.setChanges() / requests one.
     */
    void onClick(ServerPlayer player, GuikitMenu menu, int slotIndex, int page);
}
