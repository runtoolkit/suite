# macroengine:systems/log/add (internal)
# Called by error/warn/info/debug — do not call directly.
# Appends to the 30-entry ring buffer in macroengine:engine log_display.
execute unless data storage macroengine:engine log_display run data modify storage macroengine:engine log_display set value []

$data modify storage macroengine:engine log_display append value {text:"[$(level)] $(message)",color:"$(color)"}

scoreboard players add #macroengine.log_count macroengine.tmp 1
execute if score #macroengine.log_count macroengine.tmp matches 31.. run data remove storage macroengine:engine log_display[0]
execute if score #macroengine.log_count macroengine.tmp matches 31.. run scoreboard players remove #macroengine.log_count macroengine.tmp 1
