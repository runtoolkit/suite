package com.runtoolkit.rtwrapper.api;

import com.runtoolkit.rtwrapper.command.RTCommand;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Lets a server operator require a *stricter* permission level than
 * RTCommand's compiled-in default for specific commands, via config.
 *
 * Deliberately one-directional: an override can only raise the effective
 * required level, never lower it below RTCommand.minPermissionLevel().
 * Allowing overrides to loosen permissions would let a config file
 * silently punch a hole in exactly the allowlist/permission design
 * RTCommand's Javadoc describes as the structural fix for the datapack's
 * "any writer can trigger op/ban/kick" flaw — a mistyped or tampered
 * config could reintroduce that gap. Tightening only has no such failure
 * mode: the worst a bad config does is make a command less available,
 * never more.
 *
 * RTWrapperAPI.execute() should consult effectiveLevel(command) instead
 * of command.minPermissionLevel() directly once this is wired in.
 */
public final class PermissionOverrides {

    private PermissionOverrides() {}

    private static final Map<RTCommand, Integer> OVERRIDES = new ConcurrentHashMap<>();

    /**
     * Set a stricter minimum permission level for a command. Silently
     * clamps to at least the command's compiled-in default — this method
     * cannot be used to loosen permissions, by design (see class Javadoc).
     */
    public static void override(RTCommand command, int requiredLevel) {
        int floor = command.minPermissionLevel();
        int effective = Math.max(floor, requiredLevel);
        if (effective == floor) {
            OVERRIDES.remove(command);
        } else {
            OVERRIDES.put(command, effective);
        }
    }

    public static void clear(RTCommand command) {
        OVERRIDES.remove(command);
    }

    public static void clearAll() {
        OVERRIDES.clear();
    }

    /** The level actually enforced for this command: the override if set, otherwise the compiled-in default. */
    public static int effectiveLevel(RTCommand command) {
        return OVERRIDES.getOrDefault(command, command.minPermissionLevel());
    }

    public static boolean hasOverride(RTCommand command) {
        return OVERRIDES.containsKey(command);
    }
}
