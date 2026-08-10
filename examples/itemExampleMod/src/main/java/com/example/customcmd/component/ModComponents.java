package com.example.customcmd.component;

import com.example.customcmd.CustomCmdMod;
import com.mojang.serialization.Codec;
import net.minecraft.core.Registry;
import net.minecraft.core.component.DataComponentType;
import net.minecraft.core.registries.BuiltInRegistries;
import net.minecraft.core.registries.Registries;
import net.minecraft.resources.Identifier;
import net.minecraft.resources.ResourceKey;

public class ModComponents {

    public static final DataComponentType<Boolean> TITLE_TRIGGER =
        Registry.register(
            BuiltInRegistries.DATA_COMPONENT_TYPE,
            ResourceKey.create(Registries.DATA_COMPONENT_TYPE,
                Identifier.fromNamespaceAndPath(CustomCmdMod.MOD_ID, "title_trigger")),
            DataComponentType.<Boolean>builder()
                .persistent(Codec.BOOL)
                .build()
        );

    public static void initialize() {
        CustomCmdMod.LOGGER.info("ModComponents yüklendi.");
    }
}
