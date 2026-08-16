package io.runtoolkit.macroengine.client;

import net.fabricmc.fabric.api.client.command.v2.ClientCommandRegistrationCallback;
import net.fabricmc.fabric.api.client.command.v2.ClientCommands;
import net.minecraft.client.Minecraft;

/**
 * Registers the "/macroengineconfig" client command — opens MacroEngineConfigScreen
 * when run.
 *
 * Real API (verified via javap, fabric-command-api-v2 3.1.0+26.3):
 *   - ClientCommandRegistrationCallback.EVENT.register((dispatcher, ctx) -> ...)
 *   - ClientCommands.literal(String) → LiteralArgumentBuilder<FabricClientCommandSource>
 *
 * NOTE: this command works purely client-side (just opens a Screen) without
 * any server communication — the send to the server only happens when the
 * "Save" button is pressed (MacroEngineConfigScreen.onSave).
 */
public final class MacroEngineClientCommands {
    private MacroEngineClientCommands() {
    }

    public static void register() {
        ClientCommandRegistrationCallback.EVENT.register((dispatcher, registryAccess) ->
                dispatcher.register(
                        ClientCommands.literal("macroengineconfig")
                                .executes(context -> {
                                    // NOTE: there is no Minecraft.setScreen(Screen) method,
                                    // and no accessible Minecraft.screen field could be
                                    // verified either (it didn't show up in the javap
                                    // output) — so instead of "make the current screen the
                                    // parent" we pass parent as null; MacroEngineConfigScreen
                                    // .onClose() then calls setScreenAndShow(null) (returns
                                    // to the in-game HUD).
                                    Minecraft client = Minecraft.getInstance();
                                    client.setScreenAndShow(new MacroEngineConfigScreen(null));
                                    return 1;
                                })
                )
        );
    }
}
