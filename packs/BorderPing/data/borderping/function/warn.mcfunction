# Called as the player entering the outer boundary zone.
scoreboard players set @s bp_warned 1
title @s actionbar {"text":"⚠ Approaching world border","color":"red","bold":true}
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 0.6
