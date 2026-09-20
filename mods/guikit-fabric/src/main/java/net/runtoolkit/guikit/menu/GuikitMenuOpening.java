package net.runtoolkit.guikit.menu;

import net.minecraft.network.codec.ByteBufCodecs;
import net.minecraft.network.codec.StreamCodec;
import net.minecraft.resources.ResourceLocation;

/**
 * What the datapack put in storage guikit:in {menu:"ns:id"} before function guikit:api/open.
 * Sent server -> client so the correct GuikitMenuDefinition can be looked up on both sides.
 */
public record GuikitMenuOpening(ResourceLocation menuId, int page) {
    public static final StreamCodec<net.minecraft.network.RegistryFriendlyByteBuf, GuikitMenuOpening> STREAM_CODEC =
            StreamCodec.composite(
                    ResourceLocation.STREAM_CODEC, GuikitMenuOpening::menuId,
                    ByteBufCodecs.VAR_INT, GuikitMenuOpening::page,
                    GuikitMenuOpening::new
            );
}
