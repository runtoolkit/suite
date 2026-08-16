# macroengine:core/internal/cmd/ban_apply
# The actual ban logic, run either directly (gates off) or after gate
# confirmation (gates on, the default).
$ban $(player) $(reason)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/ban ","color":"aqua"},{"text":"$(player) $(reason)","color":"white"}]
