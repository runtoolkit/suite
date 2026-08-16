# macroengine:core/internal/cmd/kick_apply
# The actual kick logic, run either directly (gates off) or after gate
# confirmation (gates on, the default).
$kick $(player) $(reason)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/kick ","color":"aqua"},{"text":"$(player) $(reason)","color":"white"}]
