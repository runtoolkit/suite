# ame_load:load/storages
# Initializes macro:engine storage fields that do not yet exist.
#
# SAFETY DESIGN
# -------------
# EVERY write here uses 'execute unless data storage ...' guards.
# This means:
#   - Fields that already exist from a prior session are NOT overwritten.
#   - Only fields missing from storage are initialized.
#   - Nondeterministic overwrite behaviour is impossible in this file.
#
# Fields that are INTENTIONALLY cleared on each reload are listed with
# explicit comments explaining why.
#
# SCOREBOARD SAFETY
# -----------------
# Epoch is preserved across reloads — cooldown expiry times depend on it.
# Tick counter is reset (irrelevant across reloads — just a monotonic counter).
# pq_depth is reset (queue state cannot survive reload safely).
#
# STORAGE VERSION GUARD
# ---------------------
# validate.mcfunction blocks a second load if global{loaded:1b} is set,
# so we only reach here when storage is either:
#   (a) fresh / never initialized, or
#   (b) was cleanly disabled via macro:disable (cleanup removed global).
# In both cases, initializing with 'unless data' guards is safe.

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
# fibers._pending is always cleared — incomplete fibers from a prior tick
# cannot be safely resumed across a reload boundary
data remove storage macro:engine fibers._pending

# geo/region_watch module init
# Region watches are always cleared on reload — all packs must re-register
# their watches in the #macro:init function tag. This is intentional:
# region watch registrations are transient and pack-owned.
data remove storage macro:engine region_watches
data modify storage macro:engine region_watches set value []

# lib/batch module init
# Incomplete batches are always cleared on reload — they cannot be safely
# resumed across a reload boundary (executing context is gone).
data remove storage macro:engine batches
data modify storage macro:engine batches set value {}

# Wand cooldown module — separate storage (avoids collision with macro:cooldown)
execute unless data storage macro:engine wand_cooldowns run data modify storage macro:engine wand_cooldowns set value {}

# ─────────────────────────────────────────────────────────────────
# Security module init (v5.0.0+)
# BREAKING CHANGE: trust_players defaults to 0b — players must have
# ame.perm_level explicitly set. macro.admin tag alone gives no access.
#
# Fields (all preserved across reloads via 'unless data' guards):
#   trust_players         0b = players not trusted (default, breaking)
#   cmd_min_level         min ame.perm_level to trigger $$(cmd) [3]
#   sandbox_cmd_min_level stricter $$(cmd) floor when sandbox:1b [4]
#   admin_min_level       min level for cmd/ functions (check_all) [2]
#   admin_can_override    0b = admins cannot bypass security rules
#   sandbox_allowlist     list of allowed command prefixes in sandbox []
# ─────────────────────────────────────────────────────────────────
execute unless data storage macro:engine security run data modify storage macro:engine security set value {trust_players:0b,cmd_min_level:3,sandbox_cmd_min_level:4,admin_min_level:2,admin_can_override:0b,sandbox_allowlist:[]}
# ─────────────────────────────────────────────────────────────────
# Security module v5.1.0+ additions
# BREAKING CHANGE: sandbox_allowlist is now a compound {} (was list []).
# Empty compound {} = all sandbox commands blocked.
# multi_type_allowlist: compound of permitted multiCommands.type values.
# multiCommands: tracks active multi-command execution context.
# ─────────────────────────────────────────────────────────────────
# Reset security to new compound format (migration: [] → {})
execute if data storage macro:engine security.sandbox_allowlist[] run data modify storage macro:engine security.sandbox_allowlist set value {}
execute unless data storage macro:engine security run data modify storage macro:engine security set value {trust_players:0b,cmd_min_level:3,sandbox_cmd_min_level:4,admin_min_level:2,admin_can_override:0b,sandbox_allowlist:{}}
execute unless data storage macro:engine security.sandbox_allowlist run data modify storage macro:engine security.sandbox_allowlist set value {}
execute unless data storage macro:engine security.multi_type_allowlist run data modify storage macro:engine security.multi_type_allowlist set value {multi_cmd:1b,multi_cmd_adv:1b}

# multiCommands context tracker (always reset on load — transient state)
data remove storage macro:engine multiCommands
data modify storage macro:engine multiCommands set value {type:"",active:0b}

# ─────────────────────────────────────────────────────────────────
# Module toggle init (macro:api/toggle)
# Each module defaults to enabled (1b) on first load.
# Preserved across reloads via 'unless data' guards — admin toggles survive /reload.
# Disable a module:  /function macro:api/toggle/<name>/false
# Enable a module:   /function macro:api/toggle/<name>/true
# List module states: /function macro:api/toggle/list
# ─────────────────────────────────────────────────────────────────
execute unless data storage macro:engine modules.hook run data modify storage macro:engine modules.hook set value 1b
execute unless data storage macro:engine modules.interaction run data modify storage macro:engine modules.interaction set value 1b
execute unless data storage macro:engine modules.perm run data modify storage macro:engine modules.perm set value 1b
execute unless data storage macro:engine modules.wand run data modify storage macro:engine modules.wand set value 1b
execute unless data storage macro:engine modules.geo run data modify storage macro:engine modules.geo set value 1b
