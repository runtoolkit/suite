# ame_load:safe_load/yes
# Enhanced load confirmation gate with additional security precautions.
# Use INSTEAD OF ame_load:load/yes when operating in a security-critical context.
#
# PRECAUTIONS (over load/yes):
#   1. Gate must be open (#pending == 1)
#   2. Player caller: must have macro.admin tag
#   3. Player caller: must have ame.perm_level >= 4 (super-admin)
#   4. Verifies engine is NOT already loaded
#   5. Logs all checks to server output via marker
#
# Non-player callers (server console / other datapacks) are trusted and bypass
# the player checks — they are already op-gated by the server.
#
# USAGE:
#   /function ame_load:safe_load/yes

# Guard: gate must be open
execute unless score #pending ame.load matches 1 run return 0

# Guard: already confirmed
execute if score #confirmed ame.load matches 1 run return 0

# Non-player callers: trusted — delegate directly
execute unless entity @s[type=minecraft:player] run summon minecraft:marker ~ ~ ~ {Tags:["macro.safe_gate"],CustomName:{"text":"AME"}}
execute unless entity @s[type=minecraft:player] run execute as @e[type=minecraft:marker,tag=macro.safe_gate,limit=1] run say [AME SAFE GATE] Confirmed by server/console — delegating to load/yes.
execute unless entity @s[type=minecraft:player] run execute as @e[type=minecraft:marker,tag=macro.safe_gate,limit=1] run kill @s
execute unless entity @s[type=minecraft:player] run function ame_load:load/yes
execute unless entity @s[type=minecraft:player] run return 0

# Player checks: macro.admin tag required
execute unless entity @s[tag=macro.admin] run tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"✘ safe_load/yes denied — macro.admin tag required.","color":"red"}]
execute unless entity @s[tag=macro.admin] run return 0

# Player checks: perm_level >= 4 required
execute unless score @s ame.perm_level matches 4.. run tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"✘ safe_load/yes denied — ame.perm_level >= 4 required.","color":"red"}]
execute unless score @s ame.perm_level matches 4.. run return 0

# Guard: engine must NOT be already loaded
execute if data storage macro:engine global{loaded:1b} run tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"✘ safe_load/yes denied — engine is already loaded.","color":"red"}]
execute if data storage macro:engine global{loaded:1b} run return 0

# All checks passed — announce via marker
summon minecraft:marker ~ ~ ~ {Tags:["macro.safe_gate"],CustomName:{"text":"AME"}}
execute as @e[type=minecraft:marker,tag=macro.safe_gate,limit=1] run say [AME SAFE GATE] ============================================
execute as @e[type=minecraft:marker,tag=macro.safe_gate,limit=1] run say [AME SAFE GATE] safe_load/yes — all security checks PASSED.
execute as @e[type=minecraft:marker,tag=macro.safe_gate,limit=1] run say [AME SAFE GATE]   macro.admin tag: OK
execute as @e[type=minecraft:marker,tag=macro.safe_gate,limit=1] run say [AME SAFE GATE]   perm_level >= 4: OK
execute as @e[type=minecraft:marker,tag=macro.safe_gate,limit=1] run say [AME SAFE GATE]   engine not loaded: OK
execute as @e[type=minecraft:marker,tag=macro.safe_gate,limit=1] run say [AME SAFE GATE]   Delegating to load/yes...
execute as @e[type=minecraft:marker,tag=macro.safe_gate,limit=1] run say [AME SAFE GATE] ============================================
execute as @e[type=minecraft:marker,tag=macro.safe_gate,limit=1] run kill @s

# Delegate to regular load/yes
function ame_load:load/yes


# Enable sandbox mode
data modify storage macro:engine sandbox set value 1b

# Leave players unsafe by default (v5.0.0 default is already 0b)
data modify storage macro:engine security set value {trust_players:0b,cmd_min_level:3,sandbox_cmd_min_level:4,admin_min_level:2,admin_can_override:0b,sandbox_allowlist:[]}
