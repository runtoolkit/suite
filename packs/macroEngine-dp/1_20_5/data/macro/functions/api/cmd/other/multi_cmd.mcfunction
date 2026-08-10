# macro:api/cmd/other/multi_cmd [MACRO] [1.20.5 overlay]
# Executes a list of commands in order.
# INPUT (macro args): $(commands) — list of command strings/objects
#
# SECURITY: sets multiCommands.type = "multi_cmd" before run.
# Type is validated against security.multi_type_allowlist before execution.

data modify storage macro:engine multiCommands.type set value "multi_cmd"
data modify storage macro:engine multiCommands.active set value 1b

execute unless function macro:core/security/multi_type_check run data remove storage macro:engine multiCommands.type
execute unless function macro:core/security/multi_type_check run data remove storage macro:engine multiCommands.active
execute unless function macro:core/security/multi_type_check run return 0

$data modify storage macro:engine _mcmd_queue set value $(commands)
data modify storage macro:engine _mcmd_options set value {error_mode:"continue",profile:0b,spread:0}

execute at @s run function macro:api/cmd/other/multi_cmd/run
tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/other/multi_cmd ","color":"aqua"},{"text":"▶ executing batch","color":"#555555"}]}

data remove storage macro:engine multiCommands.type
data remove storage macro:engine multiCommands.active
