# macro:api/cmd/internal/sandbox_blocked_macro [MACRO] [1.20.5 overlay]
# INPUT: $(_sandbox_cmd) — read from macro:engine storage.
# Logs WARN entry, notifies debug admins, and kicks the player.
$data modify storage macro:input message set value "[SANDBOX] cmd/$(_sandbox_cmd) blocked"
data modify storage macro:input level set value "WARN"
data modify storage macro:input color set value "yellow"
execute if score #ame.log_level ame.log_level matches 2.. run function macro:systems/log/add with storage macro:input {}
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"SANDBOX ","color":"red","bold":true},{"text":"cmd/$(_sandbox_cmd) blocked","color":"red"}]
data remove storage macro:input message
data remove storage macro:input level
data remove storage macro:input color
execute if entity @s[type=minecraft:player] run tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Command blocked in sandbox mode.","color":"red"}]
#execute if entity @s[type=minecraft:player] run kick @s [AME] Sandbox violation — command blocked
