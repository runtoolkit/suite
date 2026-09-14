# /function quickshare:share
# Drops a copy of the item in the executing player's main hand at their feet
# (the original stays in hand), with a per-player 5s (100 tick) cooldown
# tracked on qs_cooldown. Uses a summoned item_display as a scratch entity
# to clone the item's NBT via /data, then converts it to a real item entity.
execute if score @s qs_cooldown matches 1.. run tellraw @s {"text":"[QuickShare] Cooldown active.","color":"red"}
execute unless score @s qs_cooldown matches 1.. run scoreboard players set @s qs_cooldown 100
execute unless score @s qs_cooldown matches 101.. at @s run function quickshare:drop_mainhand_copy
