package shop;

import com.mojang.brigadier.Command;
import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.command.v2.CommandRegistrationCallback;
import net.minecraft.server.command.CommandManager;
import net.minecraft.server.network.ServerPlayerEntity;
import net.minecraft.text.Text;

public final class GuigenMod implements ModInitializer {
  @Override
  public void onInitialize() {
    CommandRegistrationCallback.EVENT.register((dispatcher, registry, env) ->
      dispatcher.register(
        CommandManager.literal("main").executes(ctx -> {
          ServerPlayerEntity player = ctx.getSource().getPlayer();
          if (player == null) return 0;
          player.sendMessage(Text.literal("[guigen] /function shop:menu/main/open"));
          return Command.SINGLE_SUCCESS;
        })
      )
    );
  }
}
