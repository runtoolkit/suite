# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/freeze/internal/apply [INTERNAL]
# Runs AS the player to be frozen, AT their position.
#
# 1. Summons an invisible Marker armor stand at the player's feet.
# Marker=1b means no hitbox and no tick overhead.
# 2. Copies the player's macroengine.pid to the stand's macroengine.freeze_id
# so the tick function can match player↔stand reliably.
# 3. Tags both the stand (macroengine.freeze_anchor) and the player
# (macroengine.frozen).
# ─────────────────────────────────────────────────────────────────

# Summon the anchor stand at player's exact position
summon minecraft:armor_stand ~ ~ ~ {Invisible:1b,Marker:1b,NoGravity:1b,Tags:["macroengine.freeze_anchor"]}

# Copy this player's PID to a tmp score, then copy to the nearest
# anchor stand (the one we just summoned — always nearest to us).
scoreboard players operation $freeze_link macroengine.tmp = @s macroengine.pid
execute as @e[tag=macroengine.freeze_anchor,sort=nearest,limit=1] run scoreboard players operation @s macroengine.freeze_id = $freeze_link macroengine.tmp

# Tag the player as frozen
tag @s add macroengine.frozen

# Notify and play sound
playsound macroengine:ui.freeze master @s ~ ~ ~ 0.9 0.9
tellraw @s ["",{"text":"\uE000","color":"#00AAAA"},{"text":" ","color":"#00AAAA"},{"translate":"macroengine.msg.freeze","color":"#00aaff","bold":true}]
