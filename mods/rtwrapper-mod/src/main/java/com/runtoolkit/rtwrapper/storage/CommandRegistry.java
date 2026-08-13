package com.runtoolkit.rtwrapper.storage;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import net.minecraft.server.MinecraftServer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Optional;

/**
 * Holds the registered custom commands in config/rtwrapper/commands.json.
 * The Java counterpart of the `rtwrapper:triggers` storage in the RTWrapper
 * datapack, except this lives in the world's save directory rather than in
 * an NBT storage namespace.
 */
public class CommandRegistry {

    private static final Logger LOGGER = LoggerFactory.getLogger("rtwrapper/registry");
    private static final Gson GSON = new GsonBuilder().setPrettyPrinting().create();

    private final Path filePath;
    private final Map<String, RegisteredCommand> commands = new LinkedHashMap<>();

    public CommandRegistry(MinecraftServer server) {
        Path configDir = server.getSavePath(net.minecraft.util.WorldSavePath.ROOT)
                .resolve("rtwrapper");
        this.filePath = configDir.resolve("commands.json");
        load();
    }

    public synchronized void load() {
        commands.clear();
        if (!Files.exists(filePath)) {
            return;
        }
        try {
            String content = Files.readString(filePath, StandardCharsets.UTF_8);
            JsonArray arr = JsonParser.parseString(content).getAsJsonArray();
            for (var el : arr) {
                RegisteredCommand cmd = RegisteredCommand.fromJson(el.getAsJsonObject());
                commands.put(cmd.name, cmd);
            }
        } catch (IOException e) {
            LOGGER.error("Failed to read commands.json: {}", e.getMessage());
        }
    }

    public synchronized void save() {
        try {
            Files.createDirectories(filePath.getParent());
            JsonArray arr = new JsonArray();
            for (RegisteredCommand cmd : commands.values()) {
                arr.add(cmd.toJson());
            }
            Files.writeString(filePath, GSON.toJson(arr), StandardCharsets.UTF_8);
        } catch (IOException e) {
            LOGGER.error("Failed to write commands.json: {}", e.getMessage());
        }
    }

    public synchronized boolean register(RegisteredCommand cmd) {
        if (commands.containsKey(cmd.name)) {
            return false;
        }
        commands.put(cmd.name, cmd);
        save();
        return true;
    }

    public synchronized boolean unregister(String name) {
        boolean removed = commands.remove(name) != null;
        if (removed) save();
        return removed;
    }

    public synchronized Optional<RegisteredCommand> get(String name) {
        return Optional.ofNullable(commands.get(name));
    }

    public synchronized Map<String, RegisteredCommand> all() {
        return new LinkedHashMap<>(commands);
    }
}
