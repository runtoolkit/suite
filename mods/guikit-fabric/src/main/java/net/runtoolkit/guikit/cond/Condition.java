package net.runtoolkit.guikit.cond;

import net.minecraft.resources.ResourceLocation;

import java.util.List;

/**
 * Java port of storage guikit:cond {type:"...", ..., not:1b}.
 * Every variant carries its own `not`, same as the datapack. Unlike the datapack, `not` is
 * applied uniformly here (including on all/any) -- the datapack's README documented an
 * inconsistent quirk on leaf types with an unknown key ("known quirk"); that quirk is not
 * reproduced here, since nothing depended on it deliberately.
 */
public sealed interface Condition {
    boolean not();

    record Score(String objective, Integer min, Integer max, boolean not) implements Condition {}
    record ItemCount(ResourceLocation item, int min, boolean not) implements Condition {}
    record Tag(String tag, boolean not) implements Condition {}
    record Gamemode(String mode, boolean not) implements Condition {}
    record Advancement(ResourceLocation advancement, boolean not) implements Condition {}
    record PredicateCond(ResourceLocation predicate, boolean not) implements Condition {}
    record Level(Integer min, Integer max, boolean not) implements Condition {}
    record Dimension(ResourceLocation dimension, boolean not) implements Condition {}
    record All(List<Condition> of, boolean not) implements Condition {}
    record Any(List<Condition> of, boolean not) implements Condition {}
}
