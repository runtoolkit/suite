package net.runtoolkit.guikit.menu;

import net.minecraft.resources.ResourceLocation;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.item.ItemStack;

/**
 * Java port of widget/pay_score, widget/pay_item, widget/pay_xp. Each returns true = paid,
 * false = not enough (nothing taken), same contract as the datapack functions.
 */
public final class Payment {
    private Payment() {}

    /** UNVERIFIED -- see ConditionChecker javadoc, same Scoreboard-API caveat applies here. */
    public static boolean payScore(ServerPlayer player, String objective, int amount) {
        throw new UnsupportedOperationException(
                "guikit: wire this to your Scoreboard API shape before use");
    }

    public static boolean payItem(ServerPlayer player, ResourceLocation item, int count) {
        int have = 0;
        for (ItemStack stack : player.getInventory().items) {
            if (!stack.isEmpty() && stack.getItem().builtInRegistryHolder().key().location().equals(item)) {
                have += stack.getCount();
            }
        }
        if (have < count) return false;

        int remaining = count;
        for (ItemStack stack : player.getInventory().items) {
            if (remaining <= 0) break;
            if (stack.isEmpty() || !stack.getItem().builtInRegistryHolder().key().location().equals(item)) continue;
            int take = Math.min(remaining, stack.getCount());
            stack.shrink(take);
            remaining -= take;
        }
        return true;
    }

    public static boolean payXp(ServerPlayer player, int amountLevels) {
        if (player.experienceLevel < amountLevels) return false;
        player.giveExperienceLevels(-amountLevels);
        return true;
    }
}
