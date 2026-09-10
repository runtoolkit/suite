# macroengine:api/wand/internal/tick_scan
# Every tick: detect players with macroengine.rightClick score 1+,
# check their held item, run the matching bind.

# Module toggle guard — skips this module when disabled via macroengine:api/toggle/wand/false
execute unless data storage macroengine:engine {modules:{wand:1b}} run return 0

execute unless data storage macroengine:engine wand_binds[0] run return 0

execute as @a[scores={macroengine.rightClick=1..}] at @s run function macroengine:core/internal/api/wand/dispatch
scoreboard players set @a[scores={macroengine.rightClick=1..}] macroengine.rightClick 0
