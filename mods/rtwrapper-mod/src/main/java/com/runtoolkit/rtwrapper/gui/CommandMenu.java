package com.runtoolkit.rtwrapper.gui;

import com.runtoolkit.rtwrapper.audit.AuditLog;
import com.runtoolkit.rtwrapper.permission.PermissionGate;
import com.runtoolkit.rtwrapper.queue.CommandExecutor;
import com.runtoolkit.rtwrapper.storage.CommandRegistry;
import com.runtoolkit.rtwrapper.storage.RegisteredCommand;
import net.minecraft.component.DataComponentTypes;
import net.minecraft.component.type.LoreComponent;
import net.minecraft.entity.player.PlayerEntity;
import net.minecraft.entity.player.PlayerInventory;
import net.minecraft.inventory.SimpleInventory;
import net.minecraft.item.ItemStack;
import net.minecraft.item.Items;
import net.minecraft.screen.GenericContainerScreenHandler;
import net.minecraft.screen.NamedScreenHandlerFactory;
import net.minecraft.screen.ScreenHandler;
import net.minecraft.screen.ScreenHandlerType;
import net.minecraft.screen.slot.SlotActionType;
import net.minecraft.server.command.ServerCommandSource;
import net.minecraft.server.network.ServerPlayerEntity;
import net.minecraft.text.Text;

import java.util.List;
import java.util.Map;

/**
 * Server-side Chest GUI: a 3x9 (27-slot) chest menu that lists the registered
 * custom commands the viewing player is allowed to run, and runs a command
 * when its icon is clicked.
 *
 * The original RTWrapper datapack had no GUI component at all - this is an
 * entirely new feature, opened with /cmdname menu as requested.
 */
public class CommandMenu extends GenericContainerScreenHandler {

    public static final int ROWS = 3;
    public static final int SIZE = ROWS * 9;

    private final CommandRegistry registry;
    private final CommandExecutor executor;
    private final AuditLog auditLog;
    private final ServerPlayerEntity viewer;
    /** Slot index -> the command name displayed in that slot. */
    private final String[] slotCommands = new String[SIZE];

    public CommandMenu(int syncId, PlayerInventory playerInventory, ServerPlayerEntity viewer,
                        CommandRegistry registry, CommandExecutor executor, AuditLog auditLog) {
        super(ScreenHandlerType.GENERIC_9X3, syncId, playerInventory,
                new SimpleInventory(SIZE), ROWS);
        this.viewer = viewer;
        this.registry = registry;
        this.executor = executor;
        this.auditLog = auditLog;
        populate();
    }

    private void populate() {
        SimpleInventory inv = (SimpleInventory) this.getInventory();
        ServerCommandSource source = viewer.getCommandSource();

        Map<String, RegisteredCommand> all = registry.all();
        int slot = 0;
        for (RegisteredCommand cmd : all.values()) {
            if (slot >= SIZE) break;
            if (!cmd.visibleInGui) continue;

            boolean hasAccess = PermissionGate.canExecute(source, cmd.permissionLevel);
            if (!hasAccess) continue;

            ItemStack icon = new ItemStack(Items.PAPER);
            icon.set(DataComponentTypes.CUSTOM_NAME, Text.literal("/cmdname " + cmd.name));
            List<Text> lore = List.of(
                    Text.literal(cmd.description.isEmpty() ? "(no description)" : cmd.description),
                    Text.literal("Required permission level: " + cmd.permissionLevel),
                    Text.literal("Click to run")
            );
            icon.set(DataComponentTypes.LORE, new LoreComponent(lore));

            inv.setStack(slot, icon);
            slotCommands[slot] = cmd.name;
            slot++;
        }
    }

    /**
     * This menu is not tied to a world block, so it can always be used as
     * long as the viewing player is still valid (still online, matches the
     * player this menu was opened for).
     */
    @Override
    public boolean canUse(PlayerEntity player) {
        return player == viewer && player.isAlive();
    }

    /**
     * Shift-click ("quick move") transfer between inventories. This menu is a
     * read-only button panel, not a real container, so quick-moving items out
     * of the player's own inventory into it (or vice versa) is disabled.
     */
    @Override
    public ItemStack quickMove(PlayerEntity player, int slotIndex) {
        return ItemStack.EMPTY;
    }

    @Override
    public void onSlotClick(int slotIndex, int button, SlotActionType actionType, PlayerEntity player) {
        // Only intercept clicks in the upper inventory (the chest); clicks in
        // the player's own inventory keep normal vanilla behavior.
        if (slotIndex >= 0 && slotIndex < SIZE) {
            String cmdName = slotCommands[slotIndex];
            if (cmdName != null && player instanceof ServerPlayerEntity sp) {
                runFromGui(sp, cmdName);
            }
            return; // block item pickup/placement - this is a button menu, not storage
        }
        super.onSlotClick(slotIndex, button, actionType, player);
    }

    private void runFromGui(ServerPlayerEntity player, String cmdName) {
        var opt = registry.get(cmdName);
        if (opt.isEmpty()) {
            player.sendMessage(Text.literal("That command no longer exists."), false);
            return;
        }
        RegisteredCommand cmd = opt.get();
        ServerCommandSource source = player.getCommandSource();

        if (!PermissionGate.canExecute(source, cmd.permissionLevel)) {
            auditLog.logExecution(player.getGameProfile().getName(), cmd.name, false,
                    "unauthorized attempt via GUI");
            player.sendMessage(Text.literal("You don't have permission to run this command."), false);
            return;
        }

        executor.runQueue(source, player.getGameProfile().getName(), cmd);
        player.sendMessage(Text.literal("Ran: /cmdname " + cmd.name), false);
    }

    public static void open(ServerPlayerEntity player, CommandRegistry registry,
                             CommandExecutor executor, AuditLog auditLog) {
        player.openHandledScreen(new NamedScreenHandlerFactory() {
            @Override
            public Text getDisplayName() {
                return Text.literal("RTWrapper - Custom Commands");
            }

            @Override
            public ScreenHandler createMenu(int syncId, PlayerInventory inv, PlayerEntity p) {
                return new CommandMenu(syncId, inv, player, registry, executor, auditLog);
            }
        });
    }
}
