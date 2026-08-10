package com.runtoolkit.rtwrapper.command;

import com.mojang.brigadier.CommandDispatcher;
import com.runtoolkit.rtwrapper.api.RTDispatchResult;
import com.runtoolkit.rtwrapper.api.RTRequest;
import com.runtoolkit.rtwrapper.api.RTWrapperAPI;
import com.runtoolkit.rtwrapper.api.RTWrapperConfig;
import com.mojang.brigadier.arguments.StringArgumentType;
import net.minecraft.server.command.CommandManager;
import net.minecraft.server.command.ServerCommandSource;
import net.minecraft.server.network.ServerPlayerEntity;
import net.minecraft.text.Text;

import java.util.Arrays;
import java.util.List;

/**
 * /rtwrapper run <cmd> [args...]
 * /rtwrapper autotick <on|off>
 * /rtwrapper silent <on|off>
 * /rtwrapper debug <on|off|listen|unlisten>
 * /rtwrapper status
 * /rtwrapper clear_queue
 * /rtwrapper enqueue <cmd> [args...]
 * /rtwrapper run_next
 * /rtwrapper drain
 *
 * Command-source entry point. The base command itself requires permission
 * level 2 (matches vanilla's own convention for most admin-adjacent
 * commands), and RTWrapperAPI.execute() applies the *per-command* level on
 * top of that — so a level-2 op typing "/rtwrapper run op Steve" still
 * gets rejected because OP requires level 4.
 *
 * The config/queue subcommands (autotick, silent, debug, status,
 * clear_queue, enqueue, run_next, drain) are direct parity with the
 * datapack's api/ functions of the same name — see RTWrapperConfig and
 * RTWrapperAPI for the actual behavior each one wraps.
 */
public final class RTWrapperCommand {

    private RTWrapperCommand() {}

    // Scoreboard-tag equivalent of the datapack's "rtwrapper.debug" player
    // tag used by debug/listen and debug/unlisten to decide who receives
    // debug tellraw messages.
    private static final String DEBUG_LISTENER_TAG = "rtwrapper.debug";

    public static void register(CommandDispatcher<ServerCommandSource> dispatcher) {
        dispatcher.register(
            CommandManager.literal("rtwrapper")
                .requires(source -> source.hasPermissionLevel(2))

                .then(CommandManager.literal("run")
                    .then(CommandManager.argument("cmd", StringArgumentType.word())
                        .then(CommandManager.argument("args", StringArgumentType.greedyString())
                            .executes(ctx -> runWithArgs(
                                ctx.getSource(),
                                StringArgumentType.getString(ctx, "cmd"),
                                StringArgumentType.getString(ctx, "args")))
                        )
                        .executes(ctx -> runWithArgs(
                            ctx.getSource(),
                            StringArgumentType.getString(ctx, "cmd"),
                            ""))
                    )
                )

                .then(CommandManager.literal("autotick")
                    .then(CommandManager.literal("on").executes(ctx -> setAutoTick(ctx.getSource(), true)))
                    .then(CommandManager.literal("off").executes(ctx -> setAutoTick(ctx.getSource(), false)))
                )

                .then(CommandManager.literal("silent")
                    .then(CommandManager.literal("on").executes(ctx -> setSilent(ctx.getSource(), true)))
                    .then(CommandManager.literal("off").executes(ctx -> setSilent(ctx.getSource(), false)))
                )

                .then(CommandManager.literal("debug")
                    .then(CommandManager.literal("on").executes(ctx -> setDebug(ctx.getSource(), true)))
                    .then(CommandManager.literal("off").executes(ctx -> setDebug(ctx.getSource(), false)))
                    .then(CommandManager.literal("listen").executes(ctx -> setDebugListener(ctx.getSource(), true)))
                    .then(CommandManager.literal("unlisten").executes(ctx -> setDebugListener(ctx.getSource(), false)))
                )

                .then(CommandManager.literal("status").executes(ctx -> status(ctx.getSource())))

                .then(CommandManager.literal("clear_queue").executes(ctx -> clearQueue(ctx.getSource())))

                .then(CommandManager.literal("enqueue")
                    .then(CommandManager.argument("cmd", StringArgumentType.word())
                        .then(CommandManager.argument("args", StringArgumentType.greedyString())
                            .executes(ctx -> enqueueWithArgs(
                                ctx.getSource(),
                                StringArgumentType.getString(ctx, "cmd"),
                                StringArgumentType.getString(ctx, "args")))
                        )
                        .executes(ctx -> enqueueWithArgs(
                            ctx.getSource(),
                            StringArgumentType.getString(ctx, "cmd"),
                            ""))
                    )
                )

                // Processes exactly one queued request. Mirrors
                // api/run_next.mcfunction / core/run/run_next.mcfunction.
                .then(CommandManager.literal("run_next").executes(ctx -> runNext(ctx.getSource())))

                // Drains the whole queue immediately (same-tick where
                // possible). Mirrors api/run.mcfunction's
                // core/run/run_actions drain — NOT the same as autotick,
                // which throttles to one request per tick.
                .then(CommandManager.literal("drain").executes(ctx -> drainQueue(ctx.getSource())))
        );
    }

    private static int runWithArgs(ServerCommandSource source, String cmdLiteral, String rawArgs) {
        List<String> args = splitArgs(rawArgs);
        RTDispatchResult result = RTWrapperAPI.execute(cmdLiteral, args, source);
        return report(source, cmdLiteral, result);
    }

    private static int enqueueWithArgs(ServerCommandSource source, String cmdLiteral, String rawArgs) {
        RTCommand command = RTCommand.fromLiteral(cmdLiteral);
        if (command == null) {
            source.sendError(Text.literal("[RTWrapper] Unknown or disallowed command: " + cmdLiteral));
            return 0;
        }
        List<String> args = splitArgs(rawArgs);
        boolean queued = RTWrapperAPI.enqueue(RTRequest.of(command, args, source));
        if (!queued) {
            source.sendError(Text.literal("[RTWrapper] Queue is full, request dropped: " + cmdLiteral));
            return 0;
        }
        maybeDebugFeedback(source, "enqueued: " + cmdLiteral + " (queue size now " + RTWrapperAPI.queueSize() + ")");
        return 1;
    }

    private static int runNext(ServerCommandSource source) {
        maybeDebugFeedback(source, "run_next");
        RTDispatchResult result = RTWrapperAPI.runNext();
        if (result == null) {
            maybeFeedback(source, "queue empty, nothing to run");
            return 1;
        }
        return report(source, "run_next", result);
    }

    private static int drainQueue(ServerCommandSource source) {
        maybeDebugFeedback(source, "drain (run_actions)");
        List<RTDispatchResult> results = RTWrapperAPI.runQueued();
        long failed = results.stream().filter(r -> !r.isSuccess()).count();
        maybeFeedback(source, "drained " + results.size() + " request(s), " + failed + " failed");
        return 1;
    }

    private static int setAutoTick(ServerCommandSource source, boolean value) {
        RTWrapperConfig.setAutoTick(value);
        maybeFeedback(source, "auto tick " + (value ? "on" : "off"));
        return 1;
    }

    private static int setSilent(ServerCommandSource source, boolean value) {
        RTWrapperConfig.setSilent(value);
        // Deliberately still sends this one confirmation even when turning
        // silent on — matches the datapack, whose silent/on.mcfunction
        // also always tellraws its own confirmation regardless of the
        // silent flag it's setting.
        source.sendFeedback(() -> Text.literal("[RTWrapper] silent " + (value ? "on" : "off")), false);
        return 1;
    }

    private static int setDebug(ServerCommandSource source, boolean value) {
        RTWrapperConfig.setDebug(value);
        source.sendFeedback(() -> Text.literal("[RTWrapper] debug " + (value ? "on" : "off")), false);
        return 1;
    }

    private static int setDebugListener(ServerCommandSource source, boolean listen) {
        if (!(source.getEntity() instanceof ServerPlayerEntity player)) {
            source.sendError(Text.literal("[RTWrapper] debug listen/unlisten requires a player source"));
            return 0;
        }
        if (listen) {
            player.addCommandTag(DEBUG_LISTENER_TAG);
            source.sendFeedback(() -> Text.literal("[RTWrapper] you will receive debug messages"), false);
        } else {
            player.removeCommandTag(DEBUG_LISTENER_TAG);
            source.sendFeedback(() -> Text.literal("[RTWrapper] debug listener removed"), false);
        }
        return 1;
    }

    private static int status(ServerCommandSource source) {
        source.sendFeedback(() -> Text.literal(
                "[RTWrapper] processed=" + RTWrapperConfig.processedCount()
                        + " errors=" + RTWrapperConfig.errorCount()
                        + " queue=" + RTWrapperAPI.queueSize()
                        + " auto_tick=" + RTWrapperConfig.isAutoTick()
                        + " silent=" + RTWrapperConfig.isSilent()
                        + " debug=" + RTWrapperConfig.isDebug()
        ), false);
        return 1;
    }

    private static int clearQueue(ServerCommandSource source) {
        int dropped = RTWrapperAPI.clearQueue();
        source.sendFeedback(() -> Text.literal("[RTWrapper] cleared " + dropped + " queued request(s)"), false);
        return 1;
    }

    private static List<String> splitArgs(String rawArgs) {
        return rawArgs.isBlank() ? List.of() : Arrays.asList(rawArgs.split(" +"));
    }

    private static int report(ServerCommandSource source, String cmdLiteral, RTDispatchResult result) {
        switch (result.status()) {
            case SUCCESS -> {
                source.sendFeedback(() -> Text.literal("[RTWrapper] OK: " + cmdLiteral), false);
                return 1;
            }
            case UNKNOWN_COMMAND -> {
                source.sendError(Text.literal("[RTWrapper] Unknown or disallowed command: " + cmdLiteral));
                return 0;
            }
            case PERMISSION_DENIED -> {
                source.sendError(Text.literal("[RTWrapper] Permission denied: " + result.message()));
                return 0;
            }
            case COMMAND_FAILED -> {
                source.sendError(Text.literal("[RTWrapper] Command failed: " + result.message()));
                return 0;
            }
            default -> {
                return 0;
            }
        }
    }

    // Only sends if debug is on — matches the datapack's pattern of gating
    // its verbose "[RTWrapper] ..." tellraws behind #debug rtw.config.
    private static void maybeDebugFeedback(ServerCommandSource source, String message) {
        if (RTWrapperConfig.isDebug()) {
            source.sendFeedback(() -> Text.literal("[RTWrapper] " + message), false);
        }
    }

    // Sends unless silent is on — matches the datapack's #silent gate on
    // its own status/confirmation tellraws (distinct from the #debug gate
    // above, same as the two separate scoreboards in load.mcfunction).
    private static void maybeFeedback(ServerCommandSource source, String message) {
        if (!RTWrapperConfig.isSilent()) {
            source.sendFeedback(() -> Text.literal("[RTWrapper] " + message), false);
        }
    }
}

