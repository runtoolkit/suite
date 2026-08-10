scoreboard players set #auto_tick rtw.config 0
data modify storage rtwrapper:runtime config.auto_tick set value 0b
tellraw @s [{"text":"[RTWrapper] auto tick off","color":"gold"}]
