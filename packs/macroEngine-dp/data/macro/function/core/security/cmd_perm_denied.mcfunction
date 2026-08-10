# ─────────────────────────────────────────────────────────────────
# macro:core/security/cmd_perm_denied
# Fired by cmd_gate when @s lacks sufficient ame.perm_level.
# Logs a WARN entry and notifies the player.
# ─────────────────────────────────────────────────────────────────
data modify storage macro:input message set value "[Security] cmd_gate — insufficient perm_level"
data modify storage macro:input level set value "WARN"
data modify storage macro:input color set value "yellow"
execute if score #ame.log_level ame.log_level matches 2.. run function macro:systems/log/add with storage macro:input {}
data remove storage macro:input message
data remove storage macro:input level
data remove storage macro:input color

tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Insufficient permission level to execute this command.","color":"red"}]
tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"SECURITY ","color":"red","bold":true},{"selector":"@s","color":"gold"},{"text":" — cmd blocked (perm_level too low)","color":"red"}]
