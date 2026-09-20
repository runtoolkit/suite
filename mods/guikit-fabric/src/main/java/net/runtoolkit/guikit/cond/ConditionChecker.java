package net.runtoolkit.guikit.cond;

import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.level.GameType;

/**
 * Java port of guikit:cond/check and the cond/t_*.mcfunction chain.
 *
 * UNVERIFIED, higher risk than the rest of this scaffold:
 * - Score: player.getServer().getScoreboard() access pattern (getOrCreatePlayerScore /
 *   ScoreHolder / ScoreAccess) has changed shape across recent versions. Check against
 *   your exact Mojang-mapped Scoreboard class before relying on this.
 * - Advancement: server.getAdvancements().get(ResourceLocation) -> AdvancementHolder, then
 *   player.getAdvancements().getOrStartProgress(holder).isDone() -- verify the exact method
 *   names for 26.3, this area of the API moves often.
 * Everything else here (tag, gamemode, level, dimension, item count) is on stable,
 * long-unchanged API and is lower risk.
 */
public final class ConditionChecker {
    private ConditionChecker() {}

    public static boolean check(ServerPlayer player, Condition cond) {
        boolean result = evaluate(player, cond);
        return cond.not() != result; // XOR
    }

    private static boolean evaluate(ServerPlayer player, Condition cond) {
        return switch (cond) {
            case Condition.Score c -> checkScore(player, c);
            case Condition.ItemCount c -> countItem(player, c.item()) >= c.min();
            case Condition.Tag c -> player.getTags().contains(c.tag());
            case Condition.Gamemode c -> {
                GameType wanted = switch (c.mode()) {
                    case "survival" -> GameType.SURVIVAL;
                    case "creative" -> GameType.CREATIVE;
                    case "adventure" -> GameType.ADVENTURE;
                    case "spectator" -> GameType.SPECTATOR;
                    default -> null;
                };
                yield wanted != null && player.gameMode.getGameModeForPlayer() == wanted;
            }
            case Condition.Level c -> {
                int level = player.experienceLevel;
                boolean min = c.min() == null || level >= c.min();
                boolean max = c.max() == null || level <= c.max();
                yield min && max;
            }
            case Condition.Dimension c -> player.level().dimension().location().equals(c.dimension());
            case Condition.Advancement c -> checkAdvancement(player, c);
            case Condition.PredicateCond c -> checkPredicate(player, c);
            case Condition.All c -> {
                for (Condition child : c.of()) {
                    if (!check(player, child)) yield false;
                }
                yield true; // empty list passes, same as the datapack
            }
            case Condition.Any c -> {
                for (Condition child : c.of()) {
                    if (check(player, child)) yield true;
                }
                yield false; // no child passed (including the empty-list case), same as the datapack
            }
        };
    }

    private static boolean checkScore(ServerPlayer player, Condition.Score c) {
        MinecraftServer server = player.getServer();
        if (server == null) return false;
        // UNVERIFIED -- see class javadoc. Sketch only:
        // var score = server.getScoreboard().getOrCreatePlayerScore(player, objective);
        // int value = score.get();
        throw new UnsupportedOperationException(
                "guikit: wire this to your Scoreboard API shape before use -- see ConditionChecker javadoc");
    }

    private static int countItem(ServerPlayer player, net.minecraft.resources.ResourceLocation item) {
        int total = 0;
        for (ItemStack stack : player.getInventory().items) {
            if (!stack.isEmpty() && stack.getItem().builtInRegistryHolder().key().location().equals(item)) {
                total += stack.getCount();
            }
        }
        return total;
    }

    private static boolean checkAdvancement(ServerPlayer player, Condition.Advancement c) {
        // UNVERIFIED -- see class javadoc.
        throw new UnsupportedOperationException(
                "guikit: wire this to your Advancements API shape before use -- see ConditionChecker javadoc");
    }

    private static boolean checkPredicate(ServerPlayer player, Condition.PredicateCond c) {
        // UNVERIFIED -- LootContext-based predicate evaluation against player.
        throw new UnsupportedOperationException(
                "guikit: wire this to your predicate-evaluation API shape before use -- see ConditionChecker javadoc");
    }
}
