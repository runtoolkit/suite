package io.runtoolkit.macroengine;

import net.minecraft.network.codec.ByteBufCodecs;
import net.minecraft.network.codec.StreamCodec;
import net.minecraft.network.protocol.common.custom.CustomPacketPayload;
import net.minecraft.resources.Identifier;

/**
 * C2S: sent by the client when it wants to change a field in the macroEngine
 * config menu.
 *
 * Real storage schema (verified from
 * datapacks/macroEngine/data/macroengine/function/core/config/set.mcfunction):
 *   $data modify storage macroengine:engine config.$(key) set value "$(value)"
 * i.e. there is NO separate "section" field — the key is written directly
 * to the config.<key> NBT path (a dot-separated key, e.g. "sandbox.enabled",
 * maps naturally onto nested NBT on the datapack side). So the payload only
 * carries key + value; the section field was removed.
 *
 * Real API source (verified via javap, 26.3-snapshot-5):
 *   - net.minecraft.network.protocol.common.custom.CustomPacketPayload
 *   - net.minecraft.network.protocol.common.custom.CustomPacketPayload.Type<T>(Identifier)
 *   - net.minecraft.network.codec.StreamCodec / ByteBufCodecs.STRING_UTF8
 */
public record MacroEngineConfigPayload(String key, String value) implements CustomPacketPayload {

    public static final CustomPacketPayload.Type<MacroEngineConfigPayload> TYPE =
            new CustomPacketPayload.Type<>(Identifier.fromNamespaceAndPath("macroengine", "config_set"));

    public static final StreamCodec<io.netty.buffer.ByteBuf, MacroEngineConfigPayload> CODEC =
            StreamCodec.composite(
                    ByteBufCodecs.STRING_UTF8, MacroEngineConfigPayload::key,
                    ByteBufCodecs.STRING_UTF8, MacroEngineConfigPayload::value,
                    MacroEngineConfigPayload::new
            );

    @Override
    public CustomPacketPayload.Type<MacroEngineConfigPayload> type() {
        return TYPE;
    }
}
