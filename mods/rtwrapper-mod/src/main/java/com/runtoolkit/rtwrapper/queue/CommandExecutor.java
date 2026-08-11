package com.runtoolkit.rtwrapper.queue;

import com.runtoolkit.rtwrapper.audit.AuditLog;
import com.runtoolkit.rtwrapper.storage.RegisteredCommand;
import net.minecraft.server.command.ServerCommandSource;
import net.minecraft.server.MinecraftServer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

/**
 * Runs the vanilla commands listed in RegisteredCommand.actions in sequence.
 *
 * This is the conceptual counterpart of the original RTWrapper datapack's
 * `rtwrapper:api/run` -> `run_actions` queue chain (storage-driven, advanced
 * through macro functions) - except here it's a plain Java loop calling
 * server.getCommandManager().executeWithPrefix, since there's no need to
 * persist extra "queue state" on the Java side; the whole chain runs
 * synchronously within a single tick.
 */
public class CommandExecutor {

    private static final Logger LOGGER = LoggerFactory.getLogger("rtwrapper/queue");

    private final AuditLog auditLog;

    public CommandExecutor(AuditLog auditLog) {
        this.auditLog = auditLog;
    }

    /**
     * Runs a registered command's action list in sequence, in the context of
     * the ServerCommandSource of whoever triggered it. A single failing step
     * does not stop the chain (consistent with the original RTWrapper
     * behavior, where every variant silently handled its own failure via
     * `return fail`), but a failure is still recorded in the audit log.
     */
    public void runQueue(ServerCommandSource source, String executorName, RegisteredCommand cmd) {
        MinecraftServer server = source.getServer();
        List<String> actions = cmd.actions;

        if (actions.isEmpty()) {
            auditLog.logExecution(executorName, cmd.name, true, "empty queue - no-op");
            return;
        }

        int successCount = 0;
        for (String rawCommand : actions) {
            String resolved = resolvePlaceholders(rawCommand, executorName);
            try {
                int result = server.getCommandManager().executeWithPrefix(source, resolved);
                if (result > 0) {
                    successCount++;
                } else {
                    LOGGER.warn("rtwrapper: step '{}' inside '{}' returned 0",
                            resolved, cmd.name);
                }
            } catch (Exception e) {
                LOGGER.error("rtwrapper: step '{}' inside '{}' threw an error: {}",
                        resolved, cmd.name, e.getMessage());
            }
        }

        String detail = successCount + "/" + actions.size() + " steps succeeded";
        auditLog.logExecution(executorName, cmd.name, true, detail);
    }

    /**
     * Simple placeholder resolution: {player} -> the name of the player who
     * triggered the command. A simplified Java counterpart of RTWrapper's
     * $(target) macro-style parameters.
     */
    private String resolvePlaceholders(String command, String executorName) {
        return command.replace("{player}", executorName);
    }
}
