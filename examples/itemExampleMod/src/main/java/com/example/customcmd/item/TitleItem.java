package com.example.customcmd.item;

import com.example.customcmd.component.ModComponents;
import net.minecraft.network.chat.Component;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.InteractionHand;
import net.minecraft.world.InteractionResult;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.Item;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.level.Level;

public class TitleItem extends Item {

    public TitleItem(Properties properties) {
        super(properties);
    }

    @Override
    public InteractionResult use(Level level, Player player, InteractionHand hand) {
        ItemStack stack = player.getItemInHand(hand);

        if (level.isClientSide()) {
            return InteractionResult.SUCCESS;
        }

        Boolean active = stack.get(ModComponents.TITLE_TRIGGER);
        if (active == null || !active) {
            player.sendSystemMessage(
                Component.literal("[TitleItem] Component yok veya false.")
            );
            return InteractionResult.FAIL;
        }

        if (player instanceof ServerPlayer serverPlayer) {
            level.getServer().getCommands().performPrefixedCommand(
                serverPlayer.createCommandSourceStack(),
                "title " + serverPlayer.getName().getString() + " title {\"text\":\"test123\"}"
            );
        }

        return InteractionResult.SUCCESS;
    }
}
