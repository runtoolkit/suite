# type:"cmd" → {cmd:"say hello"}
# Security: only executors with the macro.admin tag may run this.
execute unless entity @s[tag=macro.admin] run return 0
tellraw @a[tag=macro.admin] [{"selector":"@s","color":"gold"},{"text":" - command executed","color":"yellow"}]

$$(cmd)
