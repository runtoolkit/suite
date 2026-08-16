# macroengine:api/cmd/other/multi_cmd_adv [MACRO]
# Advanced multi-command execution with options.
# INPUT (macro args): $(list) — command list; $(options) — options compound
#
# SECURITY: sets multiCommands.type = "multi_cmd_adv" before run.
# Type is validated against security.multi_type_allowlist before execution.

# Tag type
data modify storage macroengine:engine multiCommands.type set value "multi_cmd_adv"
data modify storage macroengine:engine multiCommands.active set value 1b

# Validate type
execute if data storage macroengine:engine {security:{multi_type_allowlist:{multi_cmd_adv:0b}}} run data remove storage macroengine:engine multiCommands.type
execute if data storage macroengine:engine {security:{multi_type_allowlist:{multi_cmd_adv:0b}}} run data remove storage macroengine:engine multiCommands.active

$data merge storage macroengine:input {list:$(list),options:$(options)}

function macroengine:api/cmd/other/multi_cmd/advanced/run_with_options

# Clear type marker
data remove storage macroengine:engine multiCommands.type
data remove storage macroengine:engine multiCommands.active
