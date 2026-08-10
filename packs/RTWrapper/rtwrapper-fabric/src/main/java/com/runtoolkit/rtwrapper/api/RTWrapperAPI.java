package com.runtoolkit.rtwrapper.api;

import com.mojang.brigadier.exceptions.CommandSyntaxException;
import com.runtoolkit.rtwrapper.command.RTCommand;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.command.ServerCommandSource;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

/**
 * Public API surface other mods use instead of writing to shared NBT storage.
 *
 * Design decisions that map directly onto the datapack's actual problems:
 *
 * 1. allowlist: RTCommand is a closed enum (see RTCommand.java). There is
 *    no string-to-function-path resolution anywhere in this class.
 *
 * 2. permission: every request carries a real ServerCommandSource. Before
 *    building/running anything, execute() checks
 *    source.hasPermissionLevel(command.minPermissionLevel()). For admin
 *    commands (op/ban/kick/whitelist/transfer/...) that's level 4 — a
 *    console or a permission-4 source, not "whatever wrote to storage".
 *
 * 3. no ambient authority: unlike the datapack, there is no shared mutable
 *    storage another mod/datapack can poke to trigger a command. The only
 *    way in is this method call, and it requires a real source object you
 *    can't forge from a command block or /data modify.
 *
 * 4. queue is in-memory and per-tick bounded, not unbounded NBT — avoids
 *    the TOCTOU window the datapack had between "queue written" and
 *    "queue read/executed" a tick later, since here dispatch happens
 *    synchronously in the caller's own call, no cross-tick handoff needed
 *    unless the caller explicitly enqueues.
 */
public final class RTWrapperAPI {

    private RTWrapperAPI() {}

    // Bounded queue for callers that want fire-and-forget batching via
    // enqueue()/runQueued(). Deliberately capped — the datapack's
    // rtwrapper:runtime queue was an unbounded NBT list any source could
    // grow arbitrarily.
    private static final int MAX_QUEUE_SIZE = 256;
    private static final Deque<RTRequest> QUEUE = new ArrayDeque<>();

    /**
     * Execute a single request immediately, synchronously.
     * This is the primary entry point.
     */
    public static RTDispatchResult execute(RTRequest request) {
        RTCommand command = request.command();
        ServerCommandSource source = request.source();
        String sourceName = source.getName();
        int actualLevel = effectivePermissionLevel(source);

        // Permission check now goes through PermissionOverrides so a
        // stricter config-set level is honored; it can never be looser
        // than RTCommand's compiled-in default (see PermissionOverrides).
        int required = PermissionOverrides.effectiveLevel(command);
        if (!source.hasPermissionLevel(required)) {
            RTWrapperConfig.incrementErrors();
            RTDispatchResult denied = RTDispatchResult.permissionDenied(required, actualLevel);
            AuditLog.record(sourceName, actualLevel, command.literal(), request.args(), denied);
            return denied;
        }

        if (!RateLimiter.tryAcquire(sourceName)) {
            RTWrapperConfig.incrementErrors();
            RTDispatchResult limited = RTDispatchResult.commandFailed(
                    "Rate limit exceeded (" + RateLimiter.limit() + " per " + RateLimiter.windowMillis() + "ms)");
            AuditLog.record(sourceName, actualLevel, command.literal(), request.args(), limited);
            return limited;
        }

        if (!CommandCooldown.tryRun(sourceName, command)) {
            RTWrapperConfig.incrementErrors();
            RTDispatchResult onCooldown = RTDispatchResult.commandFailed(
                    "Command on cooldown, " + CommandCooldown.remaining(sourceName, command) + "ms remaining");
            AuditLog.record(sourceName, actualLevel, command.literal(), request.args(), onCooldown);
            return onCooldown;
        }

        String fullCommand = buildCommandString(command, request.args());
        MinecraftServer server = source.getServer();

        try {
            int result = server.getCommandManager().getDispatcher().execute(fullCommand, source);
            RTWrapperConfig.incrementProcessed();
            RTDispatchResult dispatchResult;
            if (result <= 0) {
                RTWrapperConfig.incrementErrors();
                dispatchResult = RTDispatchResult.commandFailed("Command returned non-positive result: " + fullCommand);
            } else {
                dispatchResult = RTDispatchResult.success();
            }
            AuditLog.record(sourceName, actualLevel, command.literal(), request.args(), dispatchResult);
            return dispatchResult;
        } catch (CommandSyntaxException e) {
            RTWrapperConfig.incrementProcessed();
            RTWrapperConfig.incrementErrors();
            RTDispatchResult failed = RTDispatchResult.commandFailed(e.getMessage());
            AuditLog.record(sourceName, actualLevel, command.literal(), request.args(), failed);
            return failed;
        }
    }

    /**
     * Schedule a request to run delayTicks ticks from now instead of
     * immediately. Delegates to ScheduledDispatch; drained by
     * RTWrapper's existing tick hook.
     */
    public static void executeDelayed(RTRequest request, long delayTicks) {
        ScheduledDispatch.schedule(request, delayTicks);
    }

    /**
     * Convenience overload: resolve a literal against the allowlist first.
     * Unknown literals are rejected here, before an RTRequest ever exists.
     */
    public static RTDispatchResult execute(String cmdLiteral, List<String> args, ServerCommandSource source) {
        RTCommand command = RTCommand.fromLiteral(cmdLiteral);
        if (command == null) {
            return RTDispatchResult.unknownCommand(cmdLiteral);
        }
        return execute(RTRequest.of(command, args, source));
    }

    /**
     * Queue a request for later batch execution (e.g. from runQueued(),
     * called once per tick by the mod's own tick handler). Bounded to
     * prevent unbounded growth.
     */
    public static boolean enqueue(RTRequest request) {
        synchronized (QUEUE) {
            if (QUEUE.size() >= MAX_QUEUE_SIZE) {
                return false;
            }
            QUEUE.add(request);
            return true;
        }
    }

    /**
     * Drain and execute everything currently queued. Returns per-request
     * results in submission order.
     */
    public static List<RTDispatchResult> runQueued() {
        List<RTRequest> batch;
        synchronized (QUEUE) {
            batch = new ArrayList<>(QUEUE);
            QUEUE.clear();
        }
        List<RTDispatchResult> results = new ArrayList<>(batch.size());
        for (RTRequest r : batch) {
            results.add(execute(r));
        }
        return results;
    }

    /**
     * Process exactly one queued request, if any. This is what the
     * autotick tick handler calls — mirrors the datapack's
     * core/run/run_next, which intentionally processes only one action
     * per tick so a long queue can't blow the TPS floor in one go.
     * Returns null if the queue was empty.
     */
    public static RTDispatchResult runNext() {
        RTRequest request;
        synchronized (QUEUE) {
            request = QUEUE.poll();
        }
        if (request == null) {
            return null;
        }
        return execute(request);
    }

    /**
     * Discard everything currently queued without executing it.
     * Mirrors api/clear_queue.mcfunction. Returns how many requests were
     * dropped.
     */
    public static int clearQueue() {
        synchronized (QUEUE) {
            int size = QUEUE.size();
            QUEUE.clear();
            return size;
        }
    }

    /**
     * Enqueue several requests as one logical batch, in order. Mirrors
     * api/enqueue_batch: every element goes through the same queue and
     * dispatch path as a single enqueue would, no atomic rollback if one
     * element fails — a failed element just counts as an error and the
     * rest of the batch still runs.
     * Returns how many of the requests were actually enqueued (fewer than
     * requests.size() if the bounded queue filled up partway through).
     */
    public static int enqueueBatch(List<RTRequest> requests) {
        int enqueued = 0;
        for (RTRequest r : requests) {
            if (!enqueue(r)) {
                break;
            }
            enqueued++;
        }
        return enqueued;
    }

    public static int queueSize() {
        synchronized (QUEUE) {
            return QUEUE.size();
        }
    }

    private static String buildCommandString(RTCommand command, List<String> args) {
        StringBuilder sb = new StringBuilder(command.literal());
        for (String arg : args) {
            sb.append(' ').append(arg);
        }
        return sb.toString();
    }

    private static int effectivePermissionLevel(ServerCommandSource source) {
        for (int level = 4; level >= 0; level--) {
            if (source.hasPermissionLevel(level)) {
                return level;
            }
        }
        return 0;
    }
}
