# macroengine:core/state/get_score
# Prints the calling player's current state score.
# Usage: /function macroengine:core/state/get_score
tellraw @s ["",{"text":"[State] ","color":"aqua"},{"text":"current: ","color":"gray"},{"score":{"name":"@s","objective":"macroengine.state"},"color":"white","bold":true}]
