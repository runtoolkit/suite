# macroengine:core/tick/pause — Suspend all tick channels until macroengine:core/tick/resume
data modify storage macroengine:engine tick.paused set value 1b
tellraw @s [{"text":"[DL] ","color":"gold"},{"text":"Tick engine paused.","color":"red"}]