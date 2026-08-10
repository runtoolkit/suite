# macro:systems/log/add (internal)
# Called by error/warn/info/debug — do not call directly.
# Appends to the 30-entry ring buffer in macro:engine log_display.
execute unless data storage macro:engine log_display run data modify storage macro:engine log_display set value []

$data modify storage macro:engine log_display append value {text:"[$(level)] $(message)",color:"$(color)"}

scoreboard players add #ame.log_count macro.tmp 1
execute if score #ame.log_count macro.tmp matches 31.. run data remove storage macro:engine log_display[0]
execute if score #ame.log_count macro.tmp matches 31.. run scoreboard players remove #ame.log_count macro.tmp 1
