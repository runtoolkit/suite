# macro:api/dialog/internal/load_exec [1.20.5 overlay]
# Stub — /dialog command requires 1.21.6+.
# Sets the expected scoreboard/tag state for caller compatibility.
$scoreboard players set @s macro.dialog_load $(cooldown)
tag @s remove macro.dialog_opened
tag @s add macro.dialog_opened
tag @s add macro.dialog_closed
