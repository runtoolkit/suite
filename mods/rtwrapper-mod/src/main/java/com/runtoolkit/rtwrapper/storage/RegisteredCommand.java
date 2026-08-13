package com.runtoolkit.rtwrapper.storage;

import com.google.gson.JsonObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Definition of a custom command registered under /cmdname.
 * The Java counterpart of the `rtwrapper:triggers registry` entry in the
 * original RTWrapper datapack - except here it's registered directly as a
 * Brigadier subcommand instead of a trigger/scoreboard.
 */
public class RegisteredCommand {

    /** Subcommand name: /cmdname <name> */
    public String name;

    /** Minimum OP permission level required to run this command (0-4). */
    public int permissionLevel;

    /** Vanilla commands to run in sequence (the Java counterpart of RTWrapper's action queue). */
    public List<String> actions = new ArrayList<>();

    /** Description shown in the Chest GUI. */
    public String description = "";

    /** Whether this command should appear in the Chest GUI menu. */
    public boolean visibleInGui = true;

    public RegisteredCommand() {
    }

    public RegisteredCommand(String name, int permissionLevel, List<String> actions, String description) {
        this.name = name;
        this.permissionLevel = permissionLevel;
        this.actions = actions;
        this.description = description;
    }

    public JsonObject toJson() {
        JsonObject obj = new JsonObject();
        obj.addProperty("name", name);
        obj.addProperty("permissionLevel", permissionLevel);
        obj.addProperty("description", description);
        obj.addProperty("visibleInGui", visibleInGui);
        com.google.gson.JsonArray arr = new com.google.gson.JsonArray();
        for (String action : actions) {
            arr.add(action);
        }
        obj.add("actions", arr);
        return obj;
    }

    public static RegisteredCommand fromJson(JsonObject obj) {
        RegisteredCommand cmd = new RegisteredCommand();
        cmd.name = obj.get("name").getAsString();
        cmd.permissionLevel = obj.has("permissionLevel") ? obj.get("permissionLevel").getAsInt() : 2;
        cmd.description = obj.has("description") ? obj.get("description").getAsString() : "";
        cmd.visibleInGui = obj.has("visibleInGui") ? obj.get("visibleInGui").getAsBoolean() : true;
        cmd.actions = new ArrayList<>();
        if (obj.has("actions")) {
            for (var el : obj.getAsJsonArray("actions")) {
                cmd.actions.add(el.getAsString());
            }
        }
        return cmd;
    }
}
