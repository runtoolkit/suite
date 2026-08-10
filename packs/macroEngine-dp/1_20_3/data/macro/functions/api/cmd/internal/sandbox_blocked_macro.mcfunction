# macro:api/cmd/internal/sandbox_blocked_macro [1.20.3 overlay]
# INPUT: $(_sandbox_cmd) — read from macro:engine storage via `with storage macro:engine {}`
# Appends a WARN entry to the log buffer and notifies debug admins.
# Do NOT call directly — use macro:api/cmd/internal/sandbox_blocked.
$data modify storage macro:input message set value "[SANDBOX] cmd/$(_sandbox_cmd) blocked"
data modify storage macro:input level set value "WARN"
data modify storage macro:input color set value "yellow"
execute if score #ame.log_level ame.log_level matches 2.. run function macro:systems/log/add with storage macro:input {}
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"SANDBOX ","color":"red","bold":true},{"text":"cmd/$(_sandbox_cmd) blocked","color":"red"}]
data remove storage macro:input message
data remove storage macro:input level
data remove storage macro:input color
