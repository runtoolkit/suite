# macroengine:experimental/combat_tag/tick
# Runs every tick from core/tick/player_systems.mcfunction (only while
# flags.experimental.combat_tag is on).
#
# Detects "this player just dealt damage" via a stat-delta on
# macroengine.exp_dmg_dealt (same convention as the hook_* stat
# objectives in core/internal/systems/hook/tick_scan.mcfunction),
# tags the player macroengine.experimental.combat_tagged, and starts
# (or refreshes) a 15s (300 tick) countdown. On expiry the tag is
# removed and the player is notified.
#
# NOTE: uses damage_dealt, i.e. only the attacker gets tagged, not
# the victim — a deliberate simplification for a first experimental
# pass (a full implementation would also tag the victim via a
# damage-taken stat and correlate attacker/victim pairs).

execute unless data storage macroengine:engine flags.experimental{combat_tag:1b} run return 0

# New damage dealt this tick -> (re)apply tag + reset timer to 300
execute as @a[scores={macroengine.exp_dmg_dealt=1..}] run tag @s add macroengine.experimental.combat_tagged
execute as @a[scores={macroengine.exp_dmg_dealt=1..}] run scoreboard players set @s macroengine.exp_combat_timer 300
execute as @a[scores={macroengine.exp_dmg_dealt=1..},tag=!macroengine.experimental._combat_notified] run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"⚔ Combat tagged — 15s","color":"red"}]
execute as @a[scores={macroengine.exp_dmg_dealt=1..}] run tag @s add macroengine.experimental._combat_notified
scoreboard players set @a[scores={macroengine.exp_dmg_dealt=1..}] macroengine.exp_dmg_dealt 0

# Countdown for currently-tagged players
execute as @a[tag=macroengine.experimental.combat_tagged,scores={macroengine.exp_combat_timer=1..}] run scoreboard players remove @s macroengine.exp_combat_timer 1

# Expiry
execute as @a[tag=macroengine.experimental.combat_tagged,scores={macroengine.exp_combat_timer=0}] run tag @s remove macroengine.experimental.combat_tagged
execute as @a[tag=macroengine.experimental.combat_tagged,scores={macroengine.exp_combat_timer=0}] run tag @s remove macroengine.experimental._combat_notified
execute as @a[tag=!macroengine.experimental.combat_tagged,tag=macroengine.experimental._combat_notified,scores={macroengine.exp_combat_timer=0}] run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Combat tag expired","color":"gray"}]
execute as @a[tag=!macroengine.experimental.combat_tagged,tag=macroengine.experimental._combat_notified,scores={macroengine.exp_combat_timer=0}] run tag @s remove macroengine.experimental._combat_notified
