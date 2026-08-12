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
 * /rtwrapper <subcommand> - replaces the /trigger-based dispatch system from
 * the RTWrapper datapack with a direct Brigadier subcommand tree.
 *
 * Renamed from the original /cmdname to /rtwrapper on request, so the
 * command name matches the mod/project name (runtoolkit/RTWrapper).
 *
 * The command tree can be registered before the server has fully started, so
 * every subcommand body resolves its state (CommandRegistry/CommandExecutor/
 * AuditLog) at execution time via RTWrapperCommands - no fixed reference is
 * captured at registration time.
 *
 * Subcommands:
 *   /rtwrapper register <name> <permLevel 0-4> <action1;action2;...>  (level 4)
 *   /rtwrapper unregister <name>                                       (level 4)
 *   /rtwrapper list
 *   /rtwrapper info <name>                                             (NEW)
 *   /rtwrapper run <name> [confirm]
 *   /rtwrapper menu
 *   /rtwrapper history                                                 (NEW)
 *   /rtwrapper reload                                                  (level 4)
 */
public final class RTWrapperCommand {

    private RTWrapperCommand() {
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

        dispatcher.register(CommandManager.literal("rtwrapper")
                .executes(ctx -> {
                    ctx.getSource().sendFeedback(() -> Text.literal(
                            "Usage: /rtwrapper <register|unregister|list|info|run|menu|history|reload>"), false);
                    return 1;
                })
                .then(CommandManager.literal("register")
                        .requires(PermissionGate::canAdminister)
                        .then(CommandManager.argument("name", StringArgumentType.word())
                                .then(CommandManager.argument("permLevel", IntegerArgumentType.integer(0, 4))
                                        .then(CommandManager.argument("action", StringArgumentType.greedyString())
                                                .executes(RTWrapperCommand::executeRegister)))))
                .then(CommandManager.literal("unregister")
                        .requires(PermissionGate::canAdminister)
                        .then(CommandManager.argument("name", StringArgumentType.word())
                                .suggests(COMMAND_NAME_SUGGESTIONS)
                                .executes(RTWrapperCommand::executeUnregister)))
                .then(CommandManager.literal("list")
                        .executes(RTWrapperCommand::executeList))
                .then(CommandManager.literal("info")
                        .then(CommandManager.argument("name", StringArgumentType.word())
                                .suggests(COMMAND_NAME_SUGGESTIONS)
                                .executes(RTWrapperCommand::executeInfo)))
                .then(CommandManager.literal("run")
                        .then(CommandManager.argument("name", StringArgumentType.word())
                                .suggests(COMMAND_NAME_SUGGESTIONS)
                                .executes(RTWrapperCommand::executeRun)
                                .then(CommandManager.literal("confirm")
                                        .executes(ctx -> executeRun(ctx, true)))))
                .then(CommandManager.literal("menu")
                        .executes(RTWrapperCommand::executeMenu))
                .then(CommandManager.literal("history")
                        .requires(PermissionGate::canAdminister)
                        .executes(RTWrapperCommand::executeHistory))
                .then(CommandManager.literal("reload")
                        .requires(PermissionGate::canAdminister)
                        .executes(RTWrapperCommand::executeReload))
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
        // /rtwrapper register heal 2 effect give {player} instant_health;heal @s
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

        source.sendFeedback(() -> Text.literal("Registered: /rtwrapper run " + name +
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
            String cooldownTag = cmd.cooldownSeconds > 0 ? " (cooldown " + cmd.cooldownSeconds + "s)" : "";
            String confirmTag = cmd.requireConfirm ? " [confirm required]" : "";
            source.sendFeedback(() -> Text.literal("  " + marker + " " + cmd.name +
                    " (level " + cmd.permissionLevel + ", " + cmd.actions.size() + " step(s))" +
                    cooldownTag + confirmTag), false);
        }
        return 1;
    }

    /**
     * NEW FEATURE: /rtwrapper info <name> - shows the full definition of a
     * registered command (description, permission level, cooldown, confirm
     * requirement, and every action step in order). /rtwrapper list only
     * gives a one-line summary; this is the detailed view, useful before
     * running an unfamiliar command or when auditing what an admin
     * previously registered.
     */
    private static int executeInfo(CommandContext<ServerCommandSource> ctx) {
        ServerCommandSource source = ctx.getSource();
        if (notReady(source)) return 0;
        CommandRegistry registry = RTWrapperCommands.getRegistry(source);

        String name = StringArgumentType.getString(ctx, "name");
        var opt = registry.get(name);
        if (opt.isEmpty()) {
            source.sendError(Text.literal("'" + name + "' is not registered."));
            return 0;
        }
        RegisteredCommand cmd = opt.get();

        source.sendFeedback(() -> Text.literal("=== " + cmd.name + " ==="), false);
        source.sendFeedback(() -> Text.literal("Description: " +
                (cmd.description.isEmpty() ? "(none)" : cmd.description)), false);
        source.sendFeedback(() -> Text.literal("Permission level: " + cmd.permissionLevel), false);
        source.sendFeedback(() -> Text.literal("Cooldown: " +
                (cmd.cooldownSeconds > 0 ? cmd.cooldownSeconds + "s" : "none")), false);
        source.sendFeedback(() -> Text.literal("Requires confirm: " + cmd.requireConfirm), false);
        source.sendFeedback(() -> Text.literal("Visible in GUI: " + cmd.visibleInGui), false);
        source.sendFeedback(() -> Text.literal("Steps (" + cmd.actions.size() + "):"), false);
        for (int i = 0; i < cmd.actions.size(); i++) {
            int stepNum = i + 1;
            String step = cmd.actions.get(i);
            source.sendFeedback(() -> Text.literal("  " + stepNum + ". " + step), false);
        }
        return 1;
    }

    private static int executeRun(CommandContext<ServerCommandSource> ctx) {
        return executeRun(ctx, false);
    }

    /**
     * @param confirmed whether the caller invoked "/rtwrapper run <name> confirm"
     *                  rather than plain "/rtwrapper run <name>".
     */
    private static int executeRun(CommandContext<ServerCommandSource> ctx, boolean confirmed) {
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

        // NEW FEATURE: confirmation gate for commands flagged requireConfirm.
        if (cmd.requireConfirm && !confirmed) {
            source.sendError(Text.literal("'" + name +
                    "' requires confirmation. Run: /rtwrapper run " + name + " confirm"));
            auditLog.logExecution(executorName, name, false, "blocked - confirmation required");
            return 0;
        }

        // NEW FEATURE: per-player cooldown gate.
        int remaining = executor.remainingCooldownSeconds(executorName, cmd);
        if (remaining > 0) {
            source.sendError(Text.literal("'" + name + "' is on cooldown for you: " +
                    remaining + "s remaining."));
            auditLog.logExecution(executorName, name, false,
                    "blocked - cooldown (" + remaining + "s remaining)");
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

    /**
     * NEW FEATURE: /rtwrapper history - prints the most recent in-memory run
     * history (see CommandExecutor.getHistory()). Restricted to admin level
     * since it exposes who ran what and when, which is the same sensitivity
     * class as reading audit.log directly.
     */
    private static int executeHistory(CommandContext<ServerCommandSource> ctx) {
        ServerCommandSource source = ctx.getSource();
        if (notReady(source)) return 0;
        CommandExecutor executor = RTWrapperCommands.getExecutor(source);

        List<String> history = executor.getHistory();
        if (history.isEmpty()) {
            source.sendFeedback(() -> Text.literal("No commands have been run yet this session."), false);
            return 0;
        }
        source.sendFeedback(() -> Text.literal("Recent runs (" + history.size() + ", newest last):"), false);
        for (String line : history) {
            source.sendFeedback(() -> Text.literal("  " + line), false);
        }
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
