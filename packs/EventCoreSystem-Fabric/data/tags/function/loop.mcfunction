execute if data storage eventcore:config {removed:1} run return 0
scoreboard players add #ec ec.sys 1
execute unless entity @a run return 0
execute as @a[tag=ec.freezed,gamemode=!spectator] at @s run tp @s[type=minecraft:player] @s[type=minecraft:player]
