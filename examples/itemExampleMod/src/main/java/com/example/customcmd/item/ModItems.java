package com.example.customcmd.item;

import com.example.customcmd.CustomCmdMod;
import com.example.customcmd.component.ModComponents;
import net.minecraft.core.Registry;
import net.minecraft.core.registries.BuiltInRegistries;
import net.minecraft.core.registries.Registries;
import net.minecraft.resources.Identifier;
import net.minecraft.resources.ResourceKey;
import net.minecraft.world.item.Item;

import java.util.function.Function;

public class ModItems {

    public static final Item TITLE_ITEM = register(
        "title_item",
        TitleItem::new,
        new Item.Properties()
            .component(ModComponents.TITLE_TRIGGER, true)
    );

    private static <T extends Item> T register(
        String name,
        Function<Item.Properties, T> factory,
        Item.Properties properties
    ) {
        ResourceKey<Item> key = ResourceKey.create(
            Registries.ITEM,
            Identifier.fromNamespaceAndPath(CustomCmdMod.MOD_ID, name)
        );
        T item = factory.apply(properties.setId(key));
        Registry.register(BuiltInRegistries.ITEM, key, item);
        return item;
    }

    public static void initialize() {
        CustomCmdMod.LOGGER.info("ModItems yüklendi.");
    }
}
