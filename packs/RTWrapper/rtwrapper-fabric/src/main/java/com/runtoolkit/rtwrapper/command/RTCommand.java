package com.runtoolkit.rtwrapper.command;

import java.util.HashMap;
import java.util.Map;

/**
 * Fixed, compile-time allowlist of every command RTWrapper is permitted to dispatch.
 *
 * This is the single most important difference from the datapack version.
 * The datapack did:
 *
 *   $function rtwrapper:core/wrappers/internal/$(cmd)
 *
 * ...which resolves an arbitrary string straight into a function call with
 * no allowlist and no permission check. Any datapack/command block able to
 * write into rtwrapper:api storage could trigger ANY wrapper, including
 * ban/op/kick/whitelist/transfer.
 *
 * Here, `cmd` from an incoming request is looked up against this enum.
 * If it doesn't match a known entry, the request is rejected before any
 * Brigadier command is ever built or dispatched — there is no code path
 * from "unrecognized string" to "command execution".
 *
 * minPermissionLevel encodes what RTWrapper.execute(...) will itself
 * enforce, in addition to whatever the source's own permission level is.
 * Administrative commands are pinned to level 2 (op) regardless of what
 * the caller passes in.
 */
public enum RTCommand {

    // --- Non-administrative / low-risk commands ---
    TP("tp", 0),
    TELEPORT("teleport", 0),
    SAY("say", 0),
    TELL("tell", 0),
    MSG("msg", 0),
    ME("me", 0),
    TELLRAW("tellraw", 0),
    TITLE("title", 0),
    EFFECT("effect", 0),
    GIVE("give", 0),
    CLEAR("clear", 0),
    XP("xp", 0),
    EXPERIENCE("experience", 0),
    GAMEMODE("gamemode", 2),
    WEATHER("weather", 2),
    TIME("time", 2),
    DIFFICULTY("difficulty", 2),
    SUMMON("summon", 2),
    KILL("kill", 2),
    SETBLOCK("setblock", 2),
    FILL("fill", 2),
    CLONE("clone", 2),
    SCOREBOARD("scoreboard", 2),
    TAG("tag", 2),
    TEAM("team", 2),
    GAMERULE("gamerule", 2),
    SCHEDULE("schedule", 2),
    FUNCTION("function", 2),
    TRIGGER("trigger", 0),
    DATA("data", 2),
    EXECUTE("execute", 2),
    BOSSBAR("bossbar", 2),
    PARTICLE("particle", 2),
    PLAYSOUND("playsound", 2),
    STOPSOUND("stopsound", 2),
    FORCELOAD("forceload", 2),
    WORLDBORDER("worldborder", 2),
    SPREADPLAYERS("spreadplayers", 2),
    SPAWNPOINT("spawnpoint", 2),
    SETWORLDSPAWN("setworldspawn", 2),
    ADVANCEMENT("advancement", 2),
    RECIPE("recipe", 2),
    ENCHANT("enchant", 2),
    ATTRIBUTE("attribute", 2),
    DAMAGE("damage", 2),
    LOOT("loot", 2),
    ITEM("item", 2),
    RIDE("ride", 2),
    PLACE("place", 2),
    ROTATE("rotate", 2),
    LOCATE("locate", 0),
    SEED("seed", 0),
    LIST("list", 0),

    // --- Administrative / high-risk commands — locked to permission level 4 ---
    OP("op", 4),
    DEOP("deop", 4),
    BAN("ban", 4),
    BAN_IP("ban-ip", 4),
    PARDON("pardon", 4),
    PARDON_IP("pardon-ip", 4),
    KICK("kick", 4),
    WHITELIST("whitelist", 4),
    TRANSFER("transfer", 4),
    STOP("stop", 4),
    SAVE_ALL("save-all", 4),
    SAVE_OFF("save-off", 4),
    SAVE_ON("save-on", 4),
    RELOAD("reload", 4),
    DATAPACK("datapack", 4),
    SETIDLETIMEOUT("setidletimeout", 4),
    DEBUGCONFIG("debugconfig", 4),
    PUBLISH("publish", 4),
    UNPUBLISH("unpublish", 4);

    private final String literal;
    private final int minPermissionLevel;

    RTCommand(String literal, int minPermissionLevel) {
        this.literal = literal;
        this.minPermissionLevel = minPermissionLevel;
    }

    public String literal() {
        return literal;
    }

    public int minPermissionLevel() {
        return minPermissionLevel;
    }

    private static final Map<String, RTCommand> BY_LITERAL = new HashMap<>();
    static {
        for (RTCommand c : values()) {
            BY_LITERAL.put(c.literal, c);
        }
    }

    /**
     * The only entry point from an untrusted string to an RTCommand.
     * Returns null (never throws, never resolves) if the string isn't a
     * known literal. Callers MUST treat null as "reject the request".
     */
    public static RTCommand fromLiteral(String literal) {
        if (literal == null) return null;
        return BY_LITERAL.get(literal);
    }
}
