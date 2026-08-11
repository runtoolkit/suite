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
 *
 * NOT: 1.21.4+ mapping'lerinde CommandManager#executeWithPrefix artık int
 * degil void donuyor (1.20.1/1.19.2'de int'ti). Bu yuzden "kac adim
 * gercekten basarili oldu" bilgisini eskisi gibi return-code uzerinden
 * ayirt edemiyoruz. successCount burada sadece "exception firlatmadan
 * calisti" anlamina gelir - komutun sessizce 0 hedef bulup basarisiz
 * olmasi (ornegin "execute if" kosulu tutmadigi durumlar) exception
 * atmayacagi icin successCount'a "basarili" olarak yansir. Bu, eski
 * `result > 0` kontrolune gore GERCEK bir hassasiyet kaybidir, syntax
 * duzeltmesi degildir. Daha dogru bir sonuc kodu istenirse
 * CommandExecutionContext tabanli execute overload'ina gecmek gerekir
 * (bunun icin projenin gercek minecraft/yarn_mappings versiyonu teyit
 * edilmeli).
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
                // executeWithPrefix artik void donuyor (1.21.4+ mapping).
                // Exception firlatmazsa "calisti" sayiyoruz; bu, komutun
                // gercekten etkili oldugu anlamina gelmez.
                server.getCommandManager().executeWithPrefix(source, resolved);
                successCount++;
            } catch (Exception e) {
                LOGGER.error("rtwrapper: step '{}' inside '{}' threw an error: {}",
                        resolved, cmd.name, e.getMessage());
            }
        }

        String detail = successCount + "/" + actions.size()
                + " steps ran without throwing (not a true success-count, see class javadoc)";
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
