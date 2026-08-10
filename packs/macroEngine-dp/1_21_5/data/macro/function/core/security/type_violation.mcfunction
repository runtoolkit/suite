# macro:core/security/type_violation [1.21.5+ overlay]
# Extends base type_violation with test_block server-log entry.
#
# test_block (log mode) was added in Java Edition 25w03a (1.21.5).
# When powered by redstone it writes the message to the server log file,
# providing a persistent audit trail outside the in-game log buffer.
#
# Block placement: y=-62 in AME forceloaded chunk (0,0).
# Placed, powered, and removed in the same tick.

# ─── base type_violation (log + tellraw + kick) ──────────────────
data modify storage macro:input message set value "[Security] type_violation — command type not in allowlist"
data modify storage macro:input level set value "ERROR"
data modify storage macro:input color set value "red"
execute if score #ame.log_level ame.log_level matches 2.. run function macro:systems/log/add with storage macro:input {}
data remove storage macro:input message
data remove storage macro:input level
data remove storage macro:input color

tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"✘ ","color":"red"},{"text":"Security violation: command type not permitted in sandbox mode.","color":"red"}]
tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"TYPE VIOLATION ","color":"red","bold":true},{"selector":"@s","color":"gold"},{"text":" — blocked (not in allowlist)","color":"red"}]
#execute if entity @s[type=minecraft:player] run kick @s [AME] Security violation — command type not in allowlist

# ─── server log via test_block ───────────────────────────────────
setblock 0 -62 0 minecraft:test_block[mode=log]{message:"[AME SECURITY] type_violation — command type not in allowlist. Run /function macro:systems/log/show for details."}
setblock 0 -61 0 minecraft:redstone_block
setblock 0 -61 0 minecraft:air
setblock 0 -62 0 minecraft:air
