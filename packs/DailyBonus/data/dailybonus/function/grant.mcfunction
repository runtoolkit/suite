# Called as the player whose db_last_day is behind the current in-game day.
# Marks them caught up first, so a mid-loot-table crash or a repeated call
# in the same tick can't hand out the bonus twice.
scoreboard players operation @s db_last_day = #day db_gameday
loot give @s loot dailybonus:daily_reward
title @s actionbar {"text":"Daily bonus claimed!","color":"gold","bold":true}
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 1 1
