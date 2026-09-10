# macroengine:core/config/score_set
# Sets an integer config value on the macroengine.config scoreboard.
# Usage: $function macroengine:core/config/score_set {key:"damage",value:5}
# Read back: scoreboard players get #damage macroengine.config
$scoreboard players set #$(key) macroengine.config $(value)
