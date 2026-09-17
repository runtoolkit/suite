package com.runtoolkit.datapackblocker.command;

import com.mojang.brigadier.CommandDispatcher;
import com.mojang.brigadier.arguments.StringArgumentType;
import com.runtoolkit.datapackblocker.AllowlistManager;
import com.runtoolkit.datapackblocker.DatapackBlockerMod;
import net.minecraft.command.CommandRegistryAccess;
import net.minecraft.server.command.CommandManager;
import net.minecraft.server.command.ServerCommandSource;
import net.minecraft.text.Text;
import net.minecraft.util.WorldSavePath;

import java.io.IOException;
import java.util.List;

/**
 * {@code /datapackblocker} - op-only (permission level 4) admin surface for
 * {@link AllowlistManager}. All subcommands re-derive the manager from the
 * live server each time rather than caching it, so this works the same
 * across a server restart without extra bookkeeping.
 */
public final class BlockerCommand {

    private BlockerCommand() {
    }

    public static void register(CommandDispatcher<ServerCommandSource> dispatcher, CommandRegistryAccess registryAccess) {
        dispatcher.register(CommandManager.literal("datapackblocker")
                .requires(source -> source.hasPermissionLevel(4))
                .then(CommandManager.literal("status").executes(BlockerCommand::status))
                .then(CommandManager.literal("unlock").executes(BlockerCommand::unlock))
                .then(CommandManager.literal("lock").executes(BlockerCommand::lock))
                .then(CommandManager.literal("approve")
                        .then(CommandManager.argument("name", StringArgumentType.greedyString())
                                .executes(BlockerCommand::approve))));
    }

    private static AllowlistManager manager(ServerCommandSource source) {
        var server = source.getServer();
        return new AllowlistManager(
                server.getSavePath(WorldSavePath.DATAPACKS),
                server.getSavePath(WorldSavePath.ROOT),
                DatapackBlockerMod.LOGGER);
    }

    private static int status(com.mojang.brigadier.context.CommandContext<ServerCommandSource> context) {
        try {
            AllowlistManager manager = manager(context.getSource());
            List<String> quarantined = manager.listQuarantined();
            context.getSource().sendFeedback(() -> Text.literal(
                    quarantined.isEmpty()
                            ? "Datapack Blocker: no packs currently in quarantine."
                            : "Datapack Blocker: " + quarantined.size() + " pack(s) in quarantine: " + quarantined
                                    + ". Use /datapackblocker approve <name> to review and allow one."),
                    false);
            return 1;
        } catch (IOException exception) {
            context.getSource().sendError(Text.literal("Datapack Blocker status check failed: " + exception.getMessage()));
            return 0;
        }
    }

    private static int unlock(com.mojang.brigadier.context.CommandContext<ServerCommandSource> context) {
        try {
            List<String> unlocked = manager(context.getSource()).unlock();
            context.getSource().sendFeedback(() -> Text.literal(
                    "Unlocked " + unlocked.size() + " pack(s) for editing: " + unlocked
                            + ". Remember to run /datapackblocker lock when you're done."), true);
            return 1;
        } catch (IOException exception) {
            context.getSource().sendError(Text.literal("Datapack Blocker unlock failed: " + exception.getMessage()));
            return 0;
        }
    }

    private static int lock(com.mojang.brigadier.context.CommandContext<ServerCommandSource> context) {
        try {
            List<String> locked = manager(context.getSource()).lock();
            context.getSource().sendFeedback(() -> Text.literal("Locked " + locked.size() + " pack(s): " + locked), true);
            return 1;
        } catch (IOException exception) {
            context.getSource().sendError(Text.literal("Datapack Blocker lock failed: " + exception.getMessage()));
            return 0;
        }
    }

    private static int approve(com.mojang.brigadier.context.CommandContext<ServerCommandSource> context) {
        String name = StringArgumentType.getString(context, "name");
        try {
            boolean approved = manager(context.getSource()).approve(name);
            if (approved) {
                context.getSource().sendFeedback(() -> Text.literal(
                        "'" + name + "' approved and restored. Run /reload to load it."), true);
                return 1;
            } else {
                context.getSource().sendError(Text.literal("No quarantined pack named '" + name + "' was found."));
                return 0;
            }
        } catch (IOException exception) {
            context.getSource().sendError(Text.literal("Datapack Blocker approve failed: " + exception.getMessage()));
            return 0;
        }
    }
}
