
# DL - Swing & Feedback Module
$swing @a[name=$(player),limit=1] $(hand)

# System Debug Log for staff (Only for users with 'macroengine.debug' tag)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/swing ","color":"aqua"},{"text":"$(player)","color":"white"}]
