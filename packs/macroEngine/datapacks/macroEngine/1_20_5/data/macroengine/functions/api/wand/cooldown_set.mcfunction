# ─────────────────────────────────────────────────────────────────
# macroengine:api/wand/cooldown_set
# Applies a cooldown to wand usage.
# NOTE: Wand cooldowns are stored under macroengine:engine wand_cooldowns;
# this avoids collision with macroengine:cooldown module's "$(player).$(key)" path
# so there is zero risk of key collision.
#
# INPUT:
# $(player) → player name
# $(tag) → wand tag
# $(duration) → cooldown duration (in ticks)
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $wcd_dur macroengine.tmp $(duration)
execute store result score $wcd_now macroengine.tmp run scoreboard players get $epoch macroengine.time
scoreboard players operation $wcd_now macroengine.tmp += $wcd_dur macroengine.tmp
$execute store result storage macroengine:engine wand_cooldowns.$(player).$(tag) int 1 run scoreboard players get $wcd_now macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"wand/cooldown_set ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" [$(tag)] ","color":"#555555"},{"text":"$(duration)t","color":"green"}]
