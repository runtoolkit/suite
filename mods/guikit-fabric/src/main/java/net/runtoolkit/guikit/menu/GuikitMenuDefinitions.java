package net.runtoolkit.guikit.menu;

import net.minecraft.resources.ResourceLocation;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Replaces storage guikit:reg menus."ns:id" = {...}. A menu-providing mod calls
 * GuikitMenuDefinitions.register(id, definition) from its own onInitialize -- the direct
 * equivalent of a menu datapack adding itself to #guikit:register. No load-order tag needed:
 * Fabric's onInitialize ordering + this being a plain map handles it.
 */
public final class GuikitMenuDefinitions {
    private static final Map<ResourceLocation, GuikitMenuDefinition> REGISTRY = new LinkedHashMap<>();

    private GuikitMenuDefinitions() {}

    public static void register(ResourceLocation id, GuikitMenuDefinition definition) {
        REGISTRY.put(id, definition);
    }

    public static GuikitMenuDefinition get(ResourceLocation id) {
        return REGISTRY.get(id);
    }
}
