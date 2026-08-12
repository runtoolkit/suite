package com.runtoolkit.rtwrapper.audit;

import net.minecraft.server.MinecraftServer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Writes every gated command execution attempt to both the server console
 * and config/rtwrapper/audit.log.
 *
 * The original RTWrapper datapack had no auditing mechanism of this kind
 * (only silent/debug flags) - this is an entirely new feature.
 */
public class AuditLog {

    private static final Logger LOGGER = LoggerFactory.getLogger("rtwrapper/audit");
    private static final DateTimeFormatter TS_FORMAT =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    private final Path logFile;

    public AuditLog(MinecraftServer server) {
        Path configDir = server.getSavePath(net.minecraft.util.WorldSavePath.ROOT)
                .resolve("rtwrapper");
        this.logFile = configDir.resolve("audit.log");
        try {
            Files.createDirectories(configDir);
            if (!Files.exists(logFile)) {
                Files.createFile(logFile);
            }
        } catch (IOException e) {
            LOGGER.error("Failed to create audit.log: {}", e.getMessage());
        }
    }

    /**
     * Logs whether a command execution attempt passed the permission gate
     * and whether it actually ran.
     */
    public void logExecution(String executorName, String commandName, boolean allowed, String detail) {
        String ts = LocalDateTime.now().format(TS_FORMAT);
        String status = allowed ? "ALLOW" : "DENY";
        String line = String.format("[%s] [%s] %s -> /rtwrapper %s (%s)",
                ts, status, executorName, commandName, detail);

        if (allowed) {
            LOGGER.info(line);
        } else {
            LOGGER.warn(line);
        }
        writeToFile(line);
    }

    public void logAdmin(String executorName, String action, String detail) {
        String ts = LocalDateTime.now().format(TS_FORMAT);
        String line = String.format("[%s] [ADMIN] %s -> %s (%s)", ts, executorName, action, detail);
        LOGGER.info(line);
        writeToFile(line);
    }

    private synchronized void writeToFile(String line) {
        try (BufferedWriter writer = Files.newBufferedWriter(
                logFile, StandardCharsets.UTF_8,
                StandardOpenOption.CREATE, StandardOpenOption.APPEND)) {
            writer.write(line);
            writer.newLine();
        } catch (IOException e) {
            LOGGER.error("Failed to write to audit.log: {}", e.getMessage());
        }
    }
}
