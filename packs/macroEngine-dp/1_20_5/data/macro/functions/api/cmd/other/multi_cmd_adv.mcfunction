# macro:api/cmd/other/multi_cmd_adv [MACRO] [1.20.5 overlay]
# Advanced multi-command execution with options.
# INPUT (macro args): $(list) — command list; $(options) — options compound
#
# SECURITY: sets multiCommands.type = "multi_cmd_adv" before run.
# Type is validated against security.multi_type_allowlist before execution.

data modify storage macro:engine multiCommands.type set value "multi_cmd_adv"
data modify storage macro:engine multiCommands.active set value 1b

execute unless function macro:core/security/multi_type_check run data remove storage macro:engine multiCommands.type
execute unless function macro:core/security/multi_type_check run data remove storage macro:engine multiCommands.active
execute unless function macro:core/security/multi_type_check run return 0

$data merge storage macro:input {list:$(list),options:$(options)}

function macro:api/cmd/other/multi_cmd/advanced/run_with_options

data remove storage macro:engine multiCommands.type
data remove storage macro:engine multiCommands.active
