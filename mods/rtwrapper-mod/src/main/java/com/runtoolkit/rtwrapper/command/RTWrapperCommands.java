package com.runtoolkit.rtwrapper.command;

import com.runtoolkit.rtwrapper.audit.AuditLog;
import com.runtoolkit.rtwrapper.queue.CommandExecutor;
import com.runtoolkit.rtwrapper.storage.CommandRegistry;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.command.ServerCommandSource;

import java.util.HashMap;
import java.util.Map;

/**
 * Central state store holding a CommandRegistry / CommandExecutor / AuditLog
 * triple per MinecraftServer instance. This is the standard Fabric way of
 * keeping server-lifecycle-bound state instead of a global static singleton
 * (a single JVM could in theory host more than one server instance - e.g.
 * during testing).
 *
 * The command tree is registered once (CommandRegistrationCallback), but on
 * every execution the correct state for the current server is resolved
 * through this class via ServerCommandSource.getServer().
 */
public final class RTWrapperCommands {

    private static final Map<MinecraftServer, CommandRegistry> REGISTRIES = new HashMap<>();
    private static final Map<MinecraftServer, CommandExecutor> EXECUTORS = new HashMap<>();
    private static final Map<MinecraftServer, AuditLog> AUDIT_LOGS = new HashMap<>();

    private RTWrapperCommands() {
    }

    public static void attach(MinecraftServer server) {
        AuditLog auditLog = new AuditLog(server);
        CommandRegistry registry = new CommandRegistry(server);
        CommandExecutor executor = new CommandExecutor(auditLog);

        AUDIT_LOGS.put(server, auditLog);
        REGISTRIES.put(server, registry);
        EXECUTORS.put(server, executor);
    }

    public static void detach(MinecraftServer server) {
        REGISTRIES.remove(server);
        EXECUTORS.remove(server);
        AUDIT_LOGS.remove(server);
    }

    public static CommandRegistry getRegistry(ServerCommandSource source) {
        return REGISTRIES.get(source.getServer());
    }

    public static CommandExecutor getExecutor(ServerCommandSource source) {
        return EXECUTORS.get(source.getServer());
    }

    public static AuditLog getAuditLog(ServerCommandSource source) {
        return AUDIT_LOGS.get(source.getServer());
    }
}
