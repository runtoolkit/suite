package com.runtoolkit.rtwrapper.queue;

import com.runtoolkit.rtwrapper.audit.AuditLog;
import com.runtoolkit.rtwrapper.storage.RegisteredCommand;
import net.minecraft.server.command.ServerCommandSource;
import net.minecraft.server.MinecraftServer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.format.DateTimeFormatter;
import java.util.ArrayDeque;
import java.util.Collections;
import java.util.Deque;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    /** Max number of entries kept in the in-memory run history (feature: /rtwrapper history). */
    private static final int HISTORY_LIMIT = 50;

    private final AuditLog auditLog;

    /**
     * NEW FEATURE: per-command cooldown tracking.
     * Key: commandName + "|" + executorName, value: epoch millis of last run.
     * In-memory only (resets on server restart) - intentional, since a
     * cooldown is a short-lived rate-limit, not persistent state.
     */
    private final Map<String, Long> lastRunMillis = new HashMap<>();

    /**
     * NEW FEATURE: run history ring buffer for /rtwrapper history.
     * Bounded deque - oldest entry is dropped once HISTORY_LIMIT is exceeded.
     */
    private final Deque<String> history = new ArrayDeque<>();

    public CommandExecutor(AuditLog auditLog) {
        this.auditLog = auditLog;
    }

    /**
     * Checks whether executorName may run cmd right now, given its
     * configured cooldownSeconds. Returns 0 if allowed, or the number of
     * remaining seconds if still on cooldown. Does NOT record a run; call
     * runQueue afterward to actually execute and record the timestamp.
     */
    public int remainingCooldownSeconds(String executorName, RegisteredCommand cmd) {
        if (cmd.cooldownSeconds <= 0) return 0;
        Long last = lastRunMillis.get(cooldownKey(cmd.name, executorName));
        if (last == null) return 0;
        long elapsedMs = System.currentTimeMillis() - last;
        long remainingMs = (cmd.cooldownSeconds * 1000L) - elapsedMs;
        if (remainingMs <= 0) return 0;
        return (int) Math.ceil(remainingMs / 1000.0);
    }

    private static String cooldownKey(String commandName, String executorName) {
        return commandName + "|" + executorName;
    }

    /**
     * Runs a registered command's action list in sequence, in the context of
     * the ServerCommandSource of whoever triggered it. A single failing step
     * does not stop the chain (consistent with the original RTWrapper
     * behavior, where every variant silently handled its own failure via
     * `return fail`), but a failure is still recorded in the audit log.
     *
     * Callers are expected to have already checked remainingCooldownSeconds()
     * before calling this - runQueue itself does not re-check or enforce the
     * cooldown, it only stamps the last-run time once execution completes.
     */
    public void runQueue(ServerCommandSource source, String executorName, RegisteredCommand cmd) {
        MinecraftServer server = source.getServer();
        List<String> actions = cmd.actions;

        if (actions.isEmpty()) {
            auditLog.logExecution(executorName, cmd.name, true, "empty queue - no-op");
            recordHistory(executorName, cmd.name, "0/0 steps (empty)");
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

        // Stamp cooldown only after a real (non-empty) run completes.
        if (cmd.cooldownSeconds > 0) {
            lastRunMillis.put(cooldownKey(cmd.name, executorName), System.currentTimeMillis());
        }

        String detail = successCount + "/" + actions.size()
                + " steps ran without throwing (not a true success-count, see class javadoc)";
        auditLog.logExecution(executorName, cmd.name, true, detail);
        recordHistory(executorName, cmd.name, successCount + "/" + actions.size());
    }

    /** NEW FEATURE: records a run into the bounded in-memory history buffer. */
    private synchronized void recordHistory(String executorName, String commandName, String outcome) {
        String ts = DateTimeFormatter.ISO_LOCAL_TIME.format(java.time.LocalTime.now().withNano(0));
        history.addLast("[" + ts + "] " + executorName + " -> " + commandName + " (" + outcome + ")");
        while (history.size() > HISTORY_LIMIT) {
            history.removeFirst();
        }
    }

    /**
     * NEW FEATURE: returns the most recent run history entries, newest last,
     * for /rtwrapper history. This is in-memory only and resets on restart;
     * config/rtwrapper/audit.log remains the persistent source of truth.
     */
    public synchronized List<String> getHistory() {
        return Collections.unmodifiableList(List.copyOf(history));
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
