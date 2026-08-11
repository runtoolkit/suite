package com.runtoolkit.rtwrapper.command;

import com.mojang.brigadier.CommandDispatcher;
import com.mojang.brigadier.arguments.IntegerArgumentType;
import com.mojang.brigadier.arguments.StringArgumentType;
import com.mojang.brigadier.context.CommandContext;
import com.mojang.brigadier.suggestion.SuggestionProvider;
import com.runtoolkit.rtwrapper.audit.AuditLog;
import com.runtoolkit.rtwrapper.gui.CommandMenu;
import com.runtoolkit.rtwrapper.permission.PermissionGate;
import com.runtoolkit.rtwrapper.queue.CommandExecutor;
import com.runtoolkit.rtwrapper.storage.CommandRegistry;
import com.runtoolkit.rtwrapper.storage.RegisteredCommand;
import net.minecraft.command.CommandRegistryAccess;
import net.minecraft.server.command.CommandManager;
import net.minecraft.server.command.ServerCommandSource;
import net.minecraft.server.network.ServerPlayerEntity;
import net.minecraft.text.Text;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * /cmdname <subcommand> - replaces the /trigger-based dispatch system from
 * the RTWrapper datapack with a direct Brigadier subcommand tree.
 *
 * The command tree can be registered before the server has fully started, so
 * every subcommand body resolves its state (CommandRegistry/CommandExecutor/
 * AuditLog) at execution time via RTWrapperCommands - no fixed reference is
 * captured at registration time.
 *
 * Subcommands:
 *   /cmdname register <name> <permLevel 0-4> <action1;action2;...>  (level 4)
 *   /cmdname unregister <name>                                       (level 4)
 *   /cmdname list
 *   /cmdname run <name>
 *   /cmdname menu
 *   /cmdname reload                                                  (level 4)
 */
public final class CmdNameCommand {

    private CmdNameCommand() {
    }

    private static final SuggestionProvider<ServerCommandSource> COMMAND_NAME_SUGGESTIONS =
            (context, builder) -> {
                CommandRegistry registry = RTWrapperCommands.getRegistry(context.getSource());
                if (registry != null) {
                    for (String name : registry.all().keySet()) {
                        if (name.startsWith(builder.getRemaining())) {
                            builder.suggest(name);
                        }
                    }
                }
                return builder.buildFuture();
            };

    public static void register(CommandDispatcher<ServerCommandSource> dispatcher,
                                  CommandRegistryAccess registryAccess) {

        dispatcher.register(CommandManager.literal("cmdname")
                .executes(ctx -> {
                    ctx.getSource().sendFeedback(() -> Text.literal(
                            "Usage: /cmdname <register|unregister|list|run|menu|reload>"), false);
                    return 1;
                })
                .then(CommandManager.literal("register")
                        .requires(PermissionGate::canAdminister)
                        .then(CommandManager.argument("name", StringArgumentType.word())
                                .then(CommandManager.argument("permLevel", IntegerArgumentType.integer(0, 4))
                                        .then(CommandManager.argument("action", StringArgumentType.greedyString())
                                                .executes(CmdNameCommand::executeRegister)))))
                .then(CommandManager.literal("unregister")
                        .requires(PermissionGate::canAdminister)
                        .then(CommandManager.argument("name", StringArgumentType.word())
                                .suggests(COMMAND_NAME_SUGGESTIONS)
                                .executes(CmdNameCommand::executeUnregister)))
                .then(CommandManager.literal("list")
                        .executes(CmdNameCommand::executeList))
                .then(CommandManager.literal("run")
                        .then(CommandManager.argument("name", StringArgumentType.word())
                                .suggests(COMMAND_NAME_SUGGESTIONS)
                                .executes(CmdNameCommand::executeRun)))
                .then(CommandManager.literal("menu")
                        .executes(CmdNameCommand::executeMenu))
                .then(CommandManager.literal("reload")
                        .requires(PermissionGate::canAdminister)
                        .executes(CmdNameCommand::executeReload))
        );
    }

    /**
     * If registry/executor/auditLog aren't ready yet (a call arriving too
     * early, before the server has fully started), this returns a meaningful
     * error to the user instead of letting a NullPointerException propagate.
     */
    private static boolean notReady(ServerCommandSource source) {
        if (RTWrapperCommands.getRegistry(source) == null) {
            source.sendError(Text.literal("RTWrapper isn't ready yet, try again in a moment."));
            return true;
        }
        return false;
    }

    private static int executeRegister(CommandContext<ServerCommandSource> ctx) {
        ServerCommandSource source = ctx.getSource();
        if (notReady(source)) return 0;
        CommandRegistry registry = RTWrapperCommands.getRegistry(source);
        AuditLog auditLog = RTWrapperCommands.getAuditLog(source);

        String name = StringArgumentType.getString(ctx, "name");
        int permLevel = IntegerArgumentType.getInteger(ctx, "permLevel");
        String actionLine = StringArgumentType.getString(ctx, "action");

        // Allow chaining multiple steps with ';':
        // /cmdname register heal 2 effect give {player} instant_health;heal @s
        List<String> actions = new ArrayList<>();
        for (String part : actionLine.split(";")) {
            String trimmed = part.trim();
            if (!trimmed.isEmpty()) actions.add(trimmed);
        }

        RegisteredCommand cmd = new RegisteredCommand(name, permLevel, actions, "");
        boolean ok = registry.register(cmd);

        String executorName = source.getName();
        if (!ok) {
            source.sendError(Text.literal("'" + name + "' is already registered. Unregister it first."));
            auditLog.logAdmin(executorName, "register", name + " -> FAILED (already exists)");
            return 0;
        }

        source.sendFeedback(() -> Text.literal("Registered: /cmdname run " + name +
                " (permission level " + permLevel + ", " + actions.size() + " step(s))"), true);
        auditLog.logAdmin(executorName, "register", name + " (level=" + permLevel + ", steps=" + actions.size() + ")");
        return 1;
    }

    private static int executeUnregister(CommandContext<ServerCommandSource> ctx) {
        ServerCommandSource source = ctx.getSource();
        if (notReady(source)) return 0;
        CommandRegistry registry = RTWrapperCommands.getRegistry(source);
        AuditLog auditLog = RTWrapperCommands.getAuditLog(source);

        String name = StringArgumentType.getString(ctx, "name");
        boolean ok = registry.unregister(name);
        String executorName = source.getName();

        if (!ok) {
            source.sendError(Text.literal("'" + name + "' is not registered."));
            auditLog.logAdmin(executorName, "unregister", name + " -> FAILED (not found)");
            return 0;
        }
        source.sendFeedback(() -> Text.literal("Removed: " + name), true);
        auditLog.logAdmin(executorName, "unregister", name);
        return 1;
    }

    private static int executeList(CommandContext<ServerCommandSource> ctx) {
        ServerCommandSource source = ctx.getSource();
        if (notReady(source)) return 0;
        CommandRegistry registry = RTWrapperCommands.getRegistry(source);

        Map<String, RegisteredCommand> all = registry.all();
        if (all.isEmpty()) {
            source.sendFeedback(() -> Text.literal("No custom commands registered."), false);
            return 0;
        }
        source.sendFeedback(() -> Text.literal("Registered commands (" + all.size() + "):"), false);
        for (RegisteredCommand cmd : all.values()) {
            boolean access = PermissionGate.canExecute(source, cmd.permissionLevel);
            String marker = access ? "[+]" : "[x]";
            source.sendFeedback(() -> Text.literal("  " + marker + " " + cmd.name +
                    " (level " + cmd.permissionLevel + ", " + cmd.actions.size() + " step(s))"), false);
        }
        return 1;
    }

    private static int executeRun(CommandContext<ServerCommandSource> ctx) {
        ServerCommandSource source = ctx.getSource();
        if (notReady(source)) return 0;
        CommandRegistry registry = RTWrapperCommands.getRegistry(source);
        CommandExecutor executor = RTWrapperCommands.getExecutor(source);
        AuditLog auditLog = RTWrapperCommands.getAuditLog(source);

        String name = StringArgumentType.getString(ctx, "name");
        String executorName = source.getName();

        var opt = registry.get(name);
        if (opt.isEmpty()) {
            source.sendError(Text.literal("'" + name + "' is not registered."));
            return 0;
        }
        RegisteredCommand cmd = opt.get();

        if (!PermissionGate.canExecute(source, cmd.permissionLevel)) {
            source.sendError(Text.literal("Running this command requires permission level " +
                    cmd.permissionLevel + "."));
            auditLog.logExecution(executorName, name, false,
                    "insufficient permission (required=" + cmd.permissionLevel + ")");
            return 0;
        }

        executor.runQueue(source, executorName, cmd);
        source.sendFeedback(() -> Text.literal("Ran: " + name), true);
        return 1;
    }

    private static int executeMenu(CommandContext<ServerCommandSource> ctx) {
        ServerCommandSource source = ctx.getSource();
        if (notReady(source)) return 0;
        CommandRegistry registry = RTWrapperCommands.getRegistry(source);
        CommandExecutor executor = RTWrapperCommands.getExecutor(source);
        AuditLog auditLog = RTWrapperCommands.getAuditLog(source);

        ServerPlayerEntity player = source.getPlayer();
        if (player == null) {
            source.sendError(Text.literal("This command can only be used by players."));
            return 0;
        }
        CommandMenu.open(player, registry, executor, auditLog);
        return 1;
    }

    private static int executeReload(CommandContext<ServerCommandSource> ctx) {
        ServerCommandSource source = ctx.getSource();
        if (notReady(source)) return 0;
        CommandRegistry registry = RTWrapperCommands.getRegistry(source);
        AuditLog auditLog = RTWrapperCommands.getAuditLog(source);

        registry.load();
        source.sendFeedback(() -> Text.literal("RTWrapper registry reloaded from disk (" +
                registry.all().size() + " command(s))."), true);
        auditLog.logAdmin(source.getName(), "reload", registry.all().size() + " command(s) loaded");
        return 1;
    }
}
