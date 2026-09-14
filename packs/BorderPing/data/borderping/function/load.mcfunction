# BorderPing - runs once on datapack (re)load
scoreboard objectives add bp_warned dummy
tellraw @a {"text":"[BorderPing] loaded.","color":"gray"}
