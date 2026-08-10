# macro:systems/hook/internal/run_cmd [MACRO]
# INPUT: $(cmd)
# @s = the triggering player

# SECURITY: central gate
execute unless function macro:core/security/cmd_gate run return 0

execute if score #ame.log_level ame.log_level matches 4.. run tellraw @a[tag=macro.debug] ["",{"text":"[Hook] ","color":"aqua"},{"selector":"@s","color":"gold"},{"text":" cmd executed","color":"#555555"}]
$$(cmd)
