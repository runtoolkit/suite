# RTWrapper core bootstrap.
# Scoreboards are intentionally stable fake-player state; existing values are not overwritten.

execute if data storage rtwrapper:meta {loaded:1b} run return 0

scoreboard objectives add rtw.config dummy
scoreboard objectives add rtw.status dummy

function rtwrapper:core/meta_init
# # execute if score #debug rtw.config matches 1.. run tellraw @a[tag=rtwrapper.debug] [{"text":"[RTWrapper] meta gate checked (status/version left untouched if already present)","color":"gray"}]

# Gate #2: load-once config. `matches 0..` is true for any already-initialized score (0 or
# higher) and false only when the objective entry does not exist yet, so a value an operator
# set at runtime (including 0) is never overwritten by /reload.
execute unless score #debug rtw.config matches 0.. run scoreboard players set #debug rtw.config 0
execute unless score #silent rtw.config matches 0.. run scoreboard players set #silent rtw.config 1
execute unless score #auto_tick rtw.config matches 0.. run scoreboard players set #auto_tick rtw.config 0
execute unless score #processed rtw.status matches 0.. run scoreboard players set #processed rtw.status 0
execute unless score #errors rtw.status matches 0.. run scoreboard players set #errors rtw.status 0

# Bind storage roots if missing. Other packs may write rtwrapper:api request/args.
execute unless data storage rtwrapper:runtime config run data modify storage rtwrapper:runtime config set value {version:"v1.0.0",debug:0b,silent:1b,auto_tick:0b}
execute unless data storage rtwrapper:runtime queue run data modify storage rtwrapper:runtime queue set value []
execute unless data storage rtwrapper:runtime current run data modify storage rtwrapper:runtime current set value {}
execute unless data storage rtwrapper:api request run data modify storage rtwrapper:api request set value {}
execute unless data storage rtwrapper:api params run data modify storage rtwrapper:api params set value {}
execute unless data storage rtwrapper:api batch run data modify storage rtwrapper:api batch set value []

data modify storage rtwrapper:meta loaded set value 1b
# # execute if score #debug rtw.config matches 1.. run tellraw @a[tag=rtwrapper.debug] [{"text":"[RTWrapper] load complete","color":"gold"}]
# # execute if score #debug rtw.config matches 1.. run tellraw @a[tag=rtwrapper.debug] [{"text":"[RTWrapper]   debug=","color":"gray"},{"score":{name:"#debug",objective:"rtw.config"},color:"white"},{"text":" silent=","color":"gray"},{"score":{name:"#silent",objective:"rtw.config"},color:"white"},{"text":" auto_tick=","color":"gray"},{"score":{name:"#auto_tick",objective:"rtw.config"},color:"white"}]
# # execute if score #debug rtw.config matches 1.. run tellraw @a[tag=rtwrapper.debug] [{"text":"[RTWrapper]   processed=","color":"gray"},{"score":{name:"#processed",objective:"rtw.status"},color:"white"},{"text":" errors=","color":"gray"},{"score":{name:"#errors",objective:"rtw.status"},color:"white"}]
# # execute if score #debug rtw.config matches 1.. run tellraw @a[tag=rtwrapper.debug] [{"text":"[RTWrapper]   meta.version=","color":"gray"},{"storage":"rtwrapper:api","nbt":"version"}]
