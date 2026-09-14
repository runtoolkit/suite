# DailyBonus - runs once on datapack (re)load
scoreboard objectives add db_last_day dummy
scoreboard objectives add db_gameday dummy
scoreboard players set #const24000 db_gameday 24000
tellraw @a {"text":"[DailyBonus] loaded.","color":"gray"}
