package com.runtoolkit.rtwrapper.api;

import com.runtoolkit.rtwrapper.command.RTCommand;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Minimum time between successive runs of the *same command* by the
 * *same source*. This is a different guard from RateLimiter: RateLimiter
 * caps total throughput per source across all commands in a window;
 * CommandCooldown targets repeat-spamming one specific command (e.g. a
 * player mashing a "/rtw effect ..." trigger) regardless of how far under
 * their overall rate limit they are.
 *
 * Cooldowns are opt-in per RTCommand via configure(); commands with no
 * configured cooldown are unaffected (default behavior is unchanged from
 * before this feature existed). Keyed on (source, command) so a cooldown
 * on GIVE for player A doesn't block player B, and a cooldown on GIVE
 * doesn't affect TP.
 */
public final class CommandCooldown {

    private CommandCooldown() {}

    private static final Map<RTCommand, Long> COOLDOWNS_MILLIS = new ConcurrentHashMap<>();
    private static final Map<String, Long> LAST_RUN = new ConcurrentHashMap<>();

    /** Configure a cooldown (in milliseconds) for a given command. 0 or negative clears it. */
    public static void configure(RTCommand command, long cooldownMillis) {
        if (cooldownMillis <= 0) {
            COOLDOWNS_MILLIS.remove(command);
        } else {
            COOLDOWNS_MILLIS.put(command, cooldownMillis);
        }
    }

    public static long configuredCooldown(RTCommand command) {
        return COOLDOWNS_MILLIS.getOrDefault(command, 0L);
    }

    private static String key(String sourceName, RTCommand command) {
        return sourceName + "\u0000" + command.literal();
    }

    /**
     * Returns true and records this attempt as the new "last run" if the
     * (source, command) pair is off cooldown. Returns false without
     * recording if still on cooldown. Commands with no configured
     * cooldown always return true.
     */
    public static boolean tryRun(String sourceName, RTCommand command) {
        long cooldown = COOLDOWNS_MILLIS.getOrDefault(command, 0L);
        if (cooldown <= 0) {
            return true;
        }
        long now = System.currentTimeMillis();
        String k = key(sourceName, command);
        Long last = LAST_RUN.get(k);
        if (last != null && now - last < cooldown) {
            return false;
        }
        LAST_RUN.put(k, now);
        return true;
    }

    /** Milliseconds remaining before (source, command) is off cooldown; 0 if already available. */
    public static long remaining(String sourceName, RTCommand command) {
        long cooldown = COOLDOWNS_MILLIS.getOrDefault(command, 0L);
        if (cooldown <= 0) return 0L;
        Long last = LAST_RUN.get(key(sourceName, command));
        if (last == null) return 0L;
        long elapsed = System.currentTimeMillis() - last;
        return Math.max(0L, cooldown - elapsed);
    }

    public static void reset(String sourceName, RTCommand command) {
        LAST_RUN.remove(key(sourceName, command));
    }

    public static void resetAll() {
        LAST_RUN.clear();
    }
}
