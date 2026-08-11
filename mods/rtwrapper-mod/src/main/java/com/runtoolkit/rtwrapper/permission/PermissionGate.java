package com.runtoolkit.rtwrapper.permission;

import net.minecraft.server.command.ServerCommandSource;

/**
 * Vanilla OP-level (0-4) gate check.
 * Every registered command carries its own required permission level
 * (RegisteredCommand.permissionLevel); this class simply centralizes the
 * check against a ServerCommandSource.
 */
public final class PermissionGate {

    private PermissionGate() {
    }

    /** Does the caller have the level required by this specific command? */
    public static boolean canExecute(ServerCommandSource source, int requiredLevel) {
        return source.hasPermissionLevel(requiredLevel);
    }

    /**
     * Fixed threshold for administrative subcommands (register/unregister/reload).
     * Set to 4 (owner/server-operator level) because register can bind any
     * vanilla command chain to a subcommand - including sensitive ones like
     * ban/op/whitelist - so it's gated at the highest OP level.
     */
    public static final int ADMIN_LEVEL = 4;

    public static boolean canAdminister(ServerCommandSource source) {
        return source.hasPermissionLevel(ADMIN_LEVEL);
    }
}
