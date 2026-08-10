# macro:api/cmd/other/multi_cmd_adv [MACRO]
# Advanced multi-command execution with options.
# INPUT (macro args): $(list) — command list; $(options) — options compound
#
# SECURITY: sets multiCommands.type = "multi_cmd_adv" before run.
# Type is validated against security.multi_type_allowlist before execution.

# Tag type
data modify storage macro:engine multiCommands.type set value "multi_cmd_adv"
data modify storage macro:engine multiCommands.active set value 1b

# Validate type
execute if data storage macro:engine {security:{multi_type_allowlist:{multi_cmd_adv:0b}}} run data remove storage macro:engine multiCommands.type
execute if data storage macro:engine {security:{multi_type_allowlist:{multi_cmd_adv:0b}}} run data remove storage macro:engine multiCommands.active
execute if data storage macro:engine {security:{multi_type_allowlist:{multi_cmd_adv:0b}}} run return run function macro:core/security/multi_type_check

$data merge storage macro:input {list:$(list),options:$(options)}

function macro:api/cmd/other/multi_cmd/advanced/run_with_options

# Clear type marker
data remove storage macro:engine multiCommands.type
data remove storage macro:engine multiCommands.active
