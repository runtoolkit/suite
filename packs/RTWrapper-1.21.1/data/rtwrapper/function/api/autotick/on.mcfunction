scoreboard players set #auto_tick rtw.config 1
data modify storage rtwrapper:runtime config.auto_tick set value 1b
tellraw @s [{"text":"[RTWrapper] auto tick on","color":"gold"}]
