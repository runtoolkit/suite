# ame_load:safe_load/no [1.20.5 overlay]
# Enhanced load cancellation with detailed logging.
# Use INSTEAD OF ame_load:load/no for audited environments.

execute unless score #pending ame.load matches 1 run return 0

summon minecraft:marker ~ ~ ~ {Tags:["macro.safe_gate_no"],CustomName:'{"text":"AME"}'}
execute as @e[type=minecraft:marker,tag=macro.safe_gate_no,limit=1] run say [AME SAFE GATE] safe_load/no — load CANCELLED by operator.
execute as @e[type=minecraft:marker,tag=macro.safe_gate_no,limit=1] run say [AME SAFE GATE] Storage has NOT been modified.
execute if entity @s[type=minecraft:player] run execute as @e[type=minecraft:marker,tag=macro.safe_gate_no,limit=1] run say [AME SAFE GATE] Cancelled by a player.
execute unless entity @s[type=minecraft:player] run execute as @e[type=minecraft:marker,tag=macro.safe_gate_no,limit=1] run say [AME SAFE GATE] Cancelled by server/console.
execute as @e[type=minecraft:marker,tag=macro.safe_gate_no,limit=1] run kill @s

execute if entity @s[type=minecraft:player] run tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"safe_load cancelled. Storage untouched.","color":"yellow"}]

function ame_load:load/no
