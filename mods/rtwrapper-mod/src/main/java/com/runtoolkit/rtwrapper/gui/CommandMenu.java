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

import java.util.ArrayList;
import java.util.List;

/**
 * Server-side Chest GUI: a 3x9 (27-slot) chest menu that lists the registered
 * custom commands the viewing player is allowed to run, and runs a command
 * when its icon is clicked.
 *
 * The original RTWrapper datapack had no GUI component at all - this is an
 * entirely new feature, opened with /rtwrapper menu as requested.
 *
 * NEW FEATURE: pagination. The chest only has 27 slots; if more visible,
 * accessible commands exist than fit (26 command slots + 1 reserved for the
 * "next page" button), a "next page" item is placed in the last slot. Since
 * a ScreenHandler can't be re-populated for the same open screen, "next
 * page" is implemented by closing the current menu and re-opening a new
 * CommandMenu at the next page offset.
 */
public class CommandMenu extends GenericContainerScreenHandler {

    public static final int ROWS = 3;
    public static final int SIZE = ROWS * 9;
    /** Last slot is reserved for the "next page" control when needed. */
    private static final int NEXT_PAGE_SLOT = SIZE - 1;
    /** Max commands actually listed per page (SIZE minus the reserved nav slot). */
    private static final int PAGE_CAPACITY = SIZE - 1;

    private final CommandRegistry registry;
    private final CommandExecutor executor;
    private final AuditLog auditLog;
    private final ServerPlayerEntity viewer;
    private final int page;
    /** Slot index -> the command name displayed in that slot. */
    private final String[] slotCommands = new String[SIZE];
    /** Whether there are more eligible commands beyond this page. */
    private boolean hasNextPage = false;

    public CommandMenu(int syncId, PlayerInventory playerInventory, ServerPlayerEntity viewer,
                        CommandRegistry registry, CommandExecutor executor, AuditLog auditLog) {
        this(syncId, playerInventory, viewer, registry, executor, auditLog, 0);
    }

    public CommandMenu(int syncId, PlayerInventory playerInventory, ServerPlayerEntity viewer,
                        CommandRegistry registry, CommandExecutor executor, AuditLog auditLog, int page) {
        super(ScreenHandlerType.GENERIC_9X3, syncId, playerInventory,
                new SimpleInventory(SIZE), ROWS);
        this.viewer = viewer;
        this.registry = registry;
        this.executor = executor;
        this.auditLog = auditLog;
        this.page = Math.max(page, 0);
        populate();
    }

    private void populate() {
        SimpleInventory inv = (SimpleInventory) this.getInventory();
        ServerCommandSource source = viewer.getCommandSource();

        // Build the full eligible list first so we know whether a next page exists.
        List<RegisteredCommand> eligible = new ArrayList<>();
        for (RegisteredCommand cmd : registry.all().values()) {
            if (!cmd.visibleInGui) continue;
            if (!PermissionGate.canExecute(source, cmd.permissionLevel)) continue;
            eligible.add(cmd);
        }

        int startIndex = page * PAGE_CAPACITY;
        int endIndex = Math.min(startIndex + PAGE_CAPACITY, eligible.size());
        hasNextPage = endIndex < eligible.size();

        int slot = 0;
        for (int i = startIndex; i < endIndex; i++) {
            RegisteredCommand cmd = eligible.get(i);

            ItemStack icon = new ItemStack(Items.PAPER);
            icon.set(DataComponentTypes.CUSTOM_NAME, Text.literal("/rtwrapper run " + cmd.name));
            List<Text> lore = new ArrayList<>(List.of(
                    Text.literal(cmd.description.isEmpty() ? "(no description)" : cmd.description),
                    Text.literal("Required permission level: " + cmd.permissionLevel)
            ));
            if (cmd.cooldownSeconds > 0) {
                lore.add(Text.literal("Cooldown: " + cmd.cooldownSeconds + "s"));
            }
            if (cmd.requireConfirm) {
                lore.add(Text.literal("Requires confirmation - use /rtwrapper run " + cmd.name + " confirm"));
            } else {
                lore.add(Text.literal("Click to run"));
            }
            icon.set(DataComponentTypes.LORE, new LoreComponent(lore));

            inv.setStack(slot, icon);
            slotCommands[slot] = cmd.name;
            slot++;
        }

        if (hasNextPage) {
            ItemStack nextPageIcon = new ItemStack(Items.ARROW);
            nextPageIcon.set(DataComponentTypes.CUSTOM_NAME, Text.literal("Next page ->"));
            nextPageIcon.set(DataComponentTypes.LORE, new LoreComponent(
                    List.of(Text.literal("Page " + (page + 1) + " -> " + (page + 2)))));
            inv.setStack(NEXT_PAGE_SLOT, nextPageIcon);
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
            if (hasNextPage && slotIndex == NEXT_PAGE_SLOT && player instanceof ServerPlayerEntity sp) {
                open(sp, registry, executor, auditLog, page + 1);
                return;
            }
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
        String executorName = player.getGameProfile().getName();

        if (!PermissionGate.canExecute(source, cmd.permissionLevel)) {
            auditLog.logExecution(executorName, cmd.name, false, "unauthorized attempt via GUI");
            player.sendMessage(Text.literal("You don't have permission to run this command."), false);
            return;
        }

        // NEW FEATURE (shared with /rtwrapper run): commands flagged
        // requireConfirm can't be one-click-run from the GUI - clicking the
        // icon only tells the player the exact chat command to type instead.
        if (cmd.requireConfirm) {
            auditLog.logExecution(executorName, cmd.name, false, "blocked via GUI - confirmation required");
            player.sendMessage(Text.literal("'" + cmd.name +
                    "' requires confirmation. Run: /rtwrapper run " + cmd.name + " confirm"), false);
            return;
        }

        // NEW FEATURE (shared with /rtwrapper run): per-player cooldown gate.
        int remaining = executor.remainingCooldownSeconds(executorName, cmd);
        if (remaining > 0) {
            auditLog.logExecution(executorName, cmd.name, false,
                    "blocked via GUI - cooldown (" + remaining + "s remaining)");
            player.sendMessage(Text.literal("'" + cmd.name + "' is on cooldown for you: " +
                    remaining + "s remaining."), false);
            return;
        }

        executor.runQueue(source, executorName, cmd);
        player.sendMessage(Text.literal("Ran: /rtwrapper run " + cmd.name), false);
    }

    public static void open(ServerPlayerEntity player, CommandRegistry registry,
                             CommandExecutor executor, AuditLog auditLog) {
        open(player, registry, executor, auditLog, 0);
    }

    public static void open(ServerPlayerEntity player, CommandRegistry registry,
                             CommandExecutor executor, AuditLog auditLog, int page) {
        player.openHandledScreen(new NamedScreenHandlerFactory() {
            @Override
            public Text getDisplayName() {
                return Text.literal("RTWrapper - Custom Commands" + (page > 0 ? " (page " + (page + 1) + ")" : ""));
            }

            @Override
            public ScreenHandler createMenu(int syncId, PlayerInventory inv, PlayerEntity p) {
                return new CommandMenu(syncId, inv, player, registry, executor, auditLog, page);
            }
        });
    }
}
