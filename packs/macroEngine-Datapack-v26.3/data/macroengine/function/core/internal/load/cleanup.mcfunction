schedule clear macroengine:core/lib/sync_tick

forceload remove -30000000 1600
forceload remove 0 0

scoreboard players reset @a macroengine_menu
scoreboard players reset @a macroengine_run

scoreboard players reset $tick macroengine.tmp
scoreboard players reset $pq_depth macroengine.tmp
# $epoch intentionally preserved — cooldown expiry times depend on it

data remove storage macroengine:engine queue
data remove storage macroengine:engine events
data remove storage macroengine:engine event_context
data remove storage macroengine:engine _event_tmp
data remove storage macroengine:engine cooldowns
data remove storage macroengine:engine throttle
data remove storage macroengine:engine players
data remove storage macroengine:engine flags
data remove storage macroengine:engine states
data remove storage macroengine:engine schedules
data remove storage macroengine:engine _input_stack
data remove storage macroengine:engine _repeat
data remove storage macroengine:engine _rng_state
data remove storage macroengine:engine _felist_input
data remove storage macroengine:engine _felist_state
data remove storage macroengine:engine _felist_current
data remove storage macroengine:engine _felist_i
data remove storage macroengine:engine log_display
scoreboard players reset #macroengine.log_count macroengine.tmp
data remove storage macroengine:engine trigger_binds
data remove storage macroengine:engine _tc_binds
data remove storage macroengine:engine _tc_current
data remove storage macroengine:engine _tc_unbind
data remove storage macroengine:engine _tc_uval
data remove storage macroengine:engine interaction_binds
data remove storage macroengine:engine _ia_iter
data remove storage macroengine:engine _ia_cur
data remove storage macroengine:engine _ia_ubinds
data remove storage macroengine:engine _ia_ufilter
data remove storage macroengine:engine _ia_ucur
data remove storage macroengine:engine teams
data remove storage macroengine:engine global
data remove storage macroengine:output result

# rate_limit module cleanup
data remove storage macroengine:engine rate_limit

scoreboard objectives remove macroengine.tmp
scoreboard objectives remove macroengine.time
scoreboard objectives remove macroengine_menu
scoreboard objectives remove macroengine_run
scoreboard objectives remove macroengine_action
scoreboard objectives remove macroengine.dialog_load
scoreboard objectives remove health
scoreboard objectives remove macroengine.pre_version

scoreboard objectives remove macroengine.Flags
scoreboard objectives remove macroengine.hook_eat
scoreboard objectives remove macroengine.hook_fish
scoreboard objectives remove macroengine.state

tag @a remove macroengine.dialog_opened
tag @a remove macroengine.dialog_closed
advancement revoke @a from macroengine:hidden/root

scoreboard objectives remove macroengine.pid
scoreboard objectives remove macroengine.rightClick
data remove storage macroengine:engine wand_binds
data remove storage macroengine:engine _wand_iter
data remove storage macroengine:engine _wand_current
data remove storage macroengine:engine _wand_unbinds
data remove storage macroengine:engine _wand_filter_tag
data remove storage macroengine:engine _wand_cur
data remove storage macroengine:engine player_pids
data remove storage macroengine:engine _pid_seq

# Hook module cleanup
scoreboard objectives remove macroengine.hook_online
scoreboard objectives remove macroengine.hook_deaths
scoreboard objectives remove macroengine.hook_placed
scoreboard objectives remove macroengine.hook_lvl
scoreboard objectives remove macroengine.hook_lvl_new
scoreboard objectives remove macroengine.hook_sneak
scoreboard objectives remove macroengine.hook_sprint
scoreboard objectives remove macroengine.hook_elytra
tag @a remove macroengine.hook_dead
tag @a remove macroengine.hook_sneaking
tag @a remove macroengine.hook_sprinting
tag @a remove macroengine.hook_gliding
scoreboard objectives remove macroengine.hook_tool_used
scoreboard objectives remove macroengine.hook_item_used
scoreboard objectives remove macroengine.hook_entity_killed
scoreboard objectives remove macroengine.hook_using_item
scoreboard objectives remove macroengine.hook_killed_by_arrow
scoreboard objectives remove macroengine.hook_hero_of_the_village
scoreboard objectives remove macroengine.hook_dim_changed
scoreboard objectives remove macroengine.hook_traded
scoreboard objectives remove macroengine.hook_jump
scoreboard objectives remove macroengine.hook_open_chest
scoreboard objectives remove macroengine.hook_drop
scoreboard objectives remove macroengine.hook_target_hit
data remove storage macroengine:engine hook_binds
data remove storage macroengine:engine _hook_iter
data remove storage macroengine:engine _hook_ctx
data remove storage macroengine:engine _hook_fire_event
data remove storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_unbinds
data remove storage macroengine:engine _hook_filter_event

# Fiber module cleanup
data remove storage macroengine:engine fibers

# Region watch cleanup
data remove storage macroengine:engine region_watches

# Batch module cleanup
data remove storage macroengine:engine batches

# Once-per-player cleanup
data remove storage macroengine:engine once_per_player

# UUID cache cleanup
data remove storage macroengine:engine _uuid_cache

# pid init temp cleanup
data remove storage macroengine:engine _pid_init_tmp

# Color API cleanup
# palette and gradients are intentionally preserved (pack-owned data).
# _names is rebuilt each load by systems/color/init.
# fork_warn flags are transient — cleared on clean unload.
data remove storage macroengine:engine color._names
data remove storage macroengine:engine fork_warn
data remove storage macroengine:engine fork_warn_tick

# BUGFIX v6.0.1: macroengine.meta scoreboard (used by _rt_origin watermark check)
# was never removed on disable/cleanup, causing scoreboard pollution across reloads.
scoreboard objectives remove macroengine.meta
