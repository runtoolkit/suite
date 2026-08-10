package com.example.customcmd;

import com.mojang.brigadier.arguments.IntegerArgumentType;
import net.fabricmc.fabric.api.command.v2.CommandRegistrationCallback;
import net.minecraft.commands.CommandSourceStack;
import net.minecraft.commands.Commands;
import net.minecraft.commands.arguments.EntityArgument;
import net.minecraft.network.chat.Component;
import net.minecraft.server.level.ServerPlayer;

import java.util.Collection;

public class CustomCommand {

    public static void register() {
        CommandRegistrationCallback.EVENT.register((dispatcher, registryAccess, environment) ->
            dispatcher.register(
                Commands.literal("mycommand")
                    .requires(source -> source.isPlayer())
                    .then(Commands.argument("oyuncu", EntityArgument.players())
                        .then(Commands.argument("miktar", IntegerArgumentType.integer(1, 9999))
                            .executes(ctx -> execute(
                                ctx.getSource(),
                                EntityArgument.getPlayers(ctx, "oyuncu"),
                                IntegerArgumentType.getInteger(ctx, "miktar")
                            ))
                        )
                    )
            )
        );
    }

    private static int execute(CommandSourceStack source, Collection<ServerPlayer> targets, int amount) {
        for (ServerPlayer player : targets) {
            player.sendSystemMessage(
                Component.literal("Sana " + amount + " birim verildi!")
            );
            source.sendSuccess(
                () -> Component.literal(player.getName().getString() + " -> " + amount + " birim"),
                true
            );
        }
        return targets.size();
    }
}
