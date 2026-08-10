package com.runtoolkit.rtwrapper.api;

import com.runtoolkit.rtwrapper.command.RTCommand;
import net.minecraft.server.command.ServerCommandSource;

import java.util.List;
import java.util.Objects;

/**
 * A single command request.
 *
 * Deliberately immutable and requiring a real ServerCommandSource at
 * construction time. This is the structural fix for the datapack's core
 * flaw: there, a request was just NBT written into rtwrapper:api storage,
 * with no origin/authority attached to it at all — any datapack, command
 * block, or /data modify from any player could write {cmd:"op", ...} and
 * the wrapper would run it.
 *
 * Here, you cannot build an RTRequest without a ServerCommandSource. That
 * source carries the actual permission level of whoever/whatever is
 * asking. There is no "trust the string" path.
 */
public final class RTRequest {

    private final RTCommand command;
    private final List<String> args;
    private final ServerCommandSource source;

    private RTRequest(RTCommand command, List<String> args, ServerCommandSource source) {
        this.command = Objects.requireNonNull(command, "command");
        this.args = List.copyOf(args);
        this.source = Objects.requireNonNull(source, "source");
    }

    /**
     * Build a request from a known RTCommand. This is the path other mods
     * should use — it forces callers to have already resolved a literal
     * through RTCommand.fromLiteral() (or reference the enum directly),
     * so an unrecognized command literal can never reach this class.
     */
    public static RTRequest of(RTCommand command, List<String> args, ServerCommandSource source) {
        return new RTRequest(command, args, source);
    }

    public RTCommand command() {
        return command;
    }

    public List<String> args() {
        return args;
    }

    public ServerCommandSource source() {
        return source;
    }
}
