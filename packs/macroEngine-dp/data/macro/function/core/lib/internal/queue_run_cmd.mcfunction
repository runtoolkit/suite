# SECURITY: central gate
execute unless function macro:core/security/cmd_gate run return 0

tellraw @a[tag=macro.admin] [{"selector":"@s","color":"gold"},{"text":" - command executed","color":"yellow"}]

$$(cmd)
