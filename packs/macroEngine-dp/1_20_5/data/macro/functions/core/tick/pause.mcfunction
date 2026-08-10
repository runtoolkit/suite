# macro:core/tick/pause — Suspend all tick channels until macro:core/tick/resume
data modify storage macro:engine tick.paused set value 1b
tellraw @s [{"text":"[AME] ","color":"gold"},{"text":"Tick engine paused.","color":"red"}]