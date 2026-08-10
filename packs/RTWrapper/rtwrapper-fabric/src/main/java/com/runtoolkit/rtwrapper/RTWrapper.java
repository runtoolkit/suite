package com.runtoolkit.rtwrapper;

import com.runtoolkit.rtwrapper.api.RTWrapperAPI;
import com.runtoolkit.rtwrapper.api.RTWrapperConfig;
import com.runtoolkit.rtwrapper.command.RTWrapperCommand;
import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.command.v2.CommandRegistrationCallback;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerTickEvents;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RTWrapper implements ModInitializer {

    public static final String MOD_ID = "rtwrapper";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitialize() {
        CommandRegistrationCallback.EVENT.register(
                (dispatcher, registryAccess, environment) -> RTWrapperCommand.register(dispatcher));

        // Datapack parity: autotick is OFF by default (RTWrapperConfig
        // default matches load.mcfunction's #auto_tick=0). When enabled,
        // exactly one queued request is processed per tick — never a full
        // drain — mirroring core/tick.mcfunction's
        // "if #auto_tick matches 1.. run function core/run/run_next".
        // Draining the whole queue every tick was the wrong behavior here:
        // a caller that queues e.g. 200 requests in one go would blow past
        // the TPS 18-19 floor requirement in a single tick if autotick
        // drained everything instead of throttling to one-per-tick.
        ServerTickEvents.END_SERVER_TICK.register(server -> {
            if (RTWrapperConfig.isAutoTick()) {
                RTWrapperAPI.runNext();
            }
            // Drains anything scheduled via RTWrapperAPI.executeDelayed(...)
            // that has reached its target tick. Independent of the autotick
            // queue above — this runs regardless of the autotick setting,
            // since a caller explicitly requesting a delay expects it to
            // fire on schedule either way.
            com.runtoolkit.rtwrapper.api.ScheduledDispatch.tick();
        });

        LOGGER.info("RTWrapper loaded (native allowlist dispatch, {} commands registered)",
                com.runtoolkit.rtwrapper.command.RTCommand.values().length);
    }
}
