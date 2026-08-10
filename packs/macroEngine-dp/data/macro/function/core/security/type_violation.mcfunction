# macro:core/security/type_violation
# Fired when a command type or sandbox command is not in the allowlist.
# Logs an ERROR entry, notifies admins, and kicks the offending player.
#
# Context: @s = the player who triggered the violation.

# Log entry
data modify storage macro:input message set value "[Security] type_violation — command type not in allowlist"
data modify storage macro:input level set value "ERROR"
data modify storage macro:input color set value "red"
execute if score #ame.log_level ame.log_level matches 2.. run function macro:systems/log/add with storage macro:input {}
data remove storage macro:input message
data remove storage macro:input level
data remove storage macro:input color

# Notify player
tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Security violation: command type not permitted in sandbox mode.","color":"red"}]

# Notify debug admins
tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"TYPE VIOLATION ","color":"red","bold":true},{"selector":"@s","color":"gold"},{"text":" — blocked (not in allowlist)","color":"red"}]

# Kick the player from server (requires function-level perm >= 3)
#execute if entity @s[type=minecraft:player] run kick @s [AME] Security violation — command type not in allowlist
