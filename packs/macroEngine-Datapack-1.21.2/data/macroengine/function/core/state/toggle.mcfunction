scoreboard players set $st_tog macroengine.tmp 0
$execute if data storage macroengine:engine {states:{$(player):"$(on)"}} run scoreboard players set $st_tog macroengine.tmp 1

$execute if score $st_tog macroengine.tmp matches 1 run data modify storage macroengine:engine states.$(player) set value "$(off)"
$execute if score $st_tog macroengine.tmp matches 0 run data modify storage macroengine:engine states.$(player) set value "$(on)"

data remove storage macroengine:output result
$data modify storage macroengine:output result set from storage macroengine:engine states.$(player)

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"state/toggle ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" (","color":"#555555"},{"text":"$(on)","color":"gray"},{"text":"↔","color":"#555555"},{"text":"$(off)","color":"gray"},{"text":") → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
