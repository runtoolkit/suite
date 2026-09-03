
# DL - Universal World Clock Controller
# Usage: /function ame:clock_handler {clock:"macroengine:test", action:"set", value:"12000"}
$time of $(clock) $(action) $(value)

# System Debug Log for staff (Only for users with 'macroengine.debug' tag)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"clock/system_update ","color":"aqua"},{"text":"$(clock) ","color":"white"},{"text":"action:","color":"gray"},{"text":"$(action) ","color":"gold"},{"text":"value:","color":"gray"},{"text":"$(value)","color":"yellow"}]
