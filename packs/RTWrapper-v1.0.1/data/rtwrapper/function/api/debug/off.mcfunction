scoreboard players set #debug rtw.config 0
data modify storage rtwrapper:runtime config.debug set value 0b
tellraw @s [{"text":"[RTWrapper] debug off","color":"gold"}]
