# macro:core/state/set_score
# Sets a player's integer state on the macro.state scoreboard.
# Usage: $function macro:core/state/set_score {value:1}
# States: 0=idle 1=combat 2=menu (define your own)
$scoreboard players set @s macro.state $(value)
