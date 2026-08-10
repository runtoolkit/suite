execute unless score $epoch macro.time matches -2147483648..2147483647 run scoreboard players set $epoch macro.time 0
scoreboard players set $tick macro.tmp 0

scoreboard players set $pq_depth macro.tmp 0

scoreboard players set $pb_four macro.tmp 1

execute unless data storage macro:engine throttle run data modify storage macro:engine throttle set value {}

execute unless data storage macro:engine flags run data modify storage macro:engine flags set value {}
execute unless data storage macro:engine states run data modify storage macro:engine states set value {}

execute unless data storage macro:engine permissions run data modify storage macro:engine permissions set value {}

execute unless data storage macro:engine perm_triggers run data modify storage macro:engine perm_triggers set value {}
execute unless data storage macro:engine perm_trigger_names run data modify storage macro:engine perm_trigger_names set value []

execute unless data storage macro:engine trigger_binds run data modify storage macro:engine trigger_binds set value []

execute unless data storage macro:engine interaction_binds run data modify storage macro:engine interaction_binds set value {attack:[], use:[]}

execute unless data storage macro:engine player_pids run data modify storage macro:engine player_pids set value {}
execute unless data storage macro:engine _pid_seq run data modify storage macro:engine _pid_seq set value 0

# UUID module init
function macro:systems/uuid/internal/init

# once_per_player module init
execute unless data storage macro:engine once_per_player run data modify storage macro:engine once_per_player set value {}

# Wand module init
execute unless data storage macro:engine wand_binds run data modify storage macro:engine wand_binds set value []

# Hook module init
execute unless data storage macro:engine hook_binds run data modify storage macro:engine hook_binds set value []

# lib/fiber module init
execute unless data storage macro:engine fibers run data modify storage macro:engine fibers set value {}
data remove storage macro:engine fibers._pending

# geo/region_watch module init
# Watches are cleared on reload — must re-register on each load
data remove storage macro:engine region_watches
data modify storage macro:engine region_watches set value []

# lib/batch module init
# Incomplete batches are cleared on reload
data remove storage macro:engine batches
data modify storage macro:engine batches set value {}

# ─────────────────────────────────────────────────────────────────
# Security module v5.1.0+ additions
# BREAKING CHANGE: sandbox_allowlist is now a compound {} (was list []).
# Empty compound {} = all sandbox commands blocked.
# multi_type_allowlist: compound of permitted multiCommands.type values.
# multiCommands: tracks active multi-command execution context.
# ─────────────────────────────────────────────────────────────────
execute if data storage macro:engine security.sandbox_allowlist[] run data modify storage macro:engine security.sandbox_allowlist set value {}
execute unless data storage macro:engine security run data modify storage macro:engine security set value {trust_players:0b,cmd_min_level:3,sandbox_cmd_min_level:4,admin_min_level:2,admin_can_override:0b,sandbox_allowlist:{}}
execute unless data storage macro:engine security.sandbox_allowlist run data modify storage macro:engine security.sandbox_allowlist set value {}
execute unless data storage macro:engine security.multi_type_allowlist run data modify storage macro:engine security.multi_type_allowlist set value {multi_cmd:1b,multi_cmd_adv:1b}

data remove storage macro:engine multiCommands
data modify storage macro:engine multiCommands set value {type:"",active:0b}
