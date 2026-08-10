# macro:core/config/score_set
# Sets an integer config value on the macro.config scoreboard.
# Usage: $function macro:core/config/score_set {key:"damage",value:5}
# Read back: scoreboard players get #damage macro.config
$scoreboard players set #$(key) macro.config $(value)
