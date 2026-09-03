# macroengine:core/internal/load/loader/scoreboards
# (moved from macroengine:core/internal/load/load/scoreboards in v6.0.2 — load/ vs loader/
#  separates gate/confirmation logic from the actual init routines)

scoreboard objectives add macroengine.tmp dummy
scoreboard objectives add macroengine.meta dummy
scoreboard objectives add macroengine.time dummy
scoreboard objectives add macroengine_menu trigger
scoreboard objectives add macroengine_run trigger
scoreboard objectives add macroengine_action trigger
scoreboard objectives add macroengine.pre_version dummy
scoreboard objectives add macroengine.pid dummy
scoreboard objectives add macroengine.freeze_id dummy
scoreboard objectives add macroengine.onlinePlayers dummy

# Wand module — carrot_on_a_stick right-click tracker
scoreboard objectives add macroengine.rightClick minecraft.used:minecraft.carrot_on_a_stick

# Hook module scoreboards
scoreboard objectives add macroengine.hook_online dummy
# BUGFIX: existing players should not re-trigger as new joins after reload
scoreboard players set @a macroengine.hook_online 1
scoreboard objectives add macroengine.hook_deaths deathCount
# NOTE: placed_blocks is not a general statistic — must be used as dummy
scoreboard objectives add macroengine.hook_placed dummy
scoreboard objectives add macroengine.hook_lvl dummy
scoreboard objectives add macroengine.hook_lvl_new dummy
# New hook scoreboards
scoreboard objectives add macroengine.hook_sneak dummy
scoreboard objectives add macroengine.hook_sprint dummy
scoreboard objectives add macroengine.hook_elytra dummy
# block_break — item_durability_changed advancement-based
scoreboard objectives add macroengine.hook_tool_used dummy
# item_use, entity_kill advancement-based
scoreboard objectives add macroengine.hook_item_used dummy
scoreboard objectives add macroengine.hook_entity_killed dummy
# using_item, killed_by_arrow, hero_of_the_village
scoreboard objectives add macroengine.hook_using_item dummy
scoreboard objectives add macroengine.hook_killed_by_arrow dummy
scoreboard objectives add macroengine.hook_hero_of_the_village dummy

# geo/region_watch — no scoreboard needed for enter/leave tracking (uses entity tags)

# hook/dimension_change — changed_dimension advancement-based
scoreboard objectives add macroengine.hook_dim_changed dummy

# hook/trade — villager_trade advancement-based
scoreboard objectives add macroengine.hook_traded dummy

# Tick dispatch (simplified, no channel registry)
scoreboard objectives add macroengine.tick dummy
scoreboard objectives add macroengine.tick_flags dummy
scoreboard objectives add macroengine.Flags dummy

# Player stat hooks
scoreboard objectives add macroengine.hook_jump minecraft.custom:minecraft.jump
scoreboard objectives add macroengine.hook_open_chest minecraft.custom:minecraft.open_chest
scoreboard objectives add macroengine.hook_drop minecraft.custom:minecraft.drop
scoreboard objectives add macroengine.hook_target_hit minecraft.custom:minecraft.target_hit

# hook/eat — consume_item advancement-based
scoreboard objectives add macroengine.hook_eat dummy
# hook/fish_caught — fishing_rod_hooked advancement-based
scoreboard objectives add macroengine.hook_fish dummy

# input/validate module — scratch scores, all on the existing macroengine.tmp
# objective rather than a new one (macroengine.Len, macroengine.DotHits, etc. all live here)

# Log level system: 0=off 1=error 2=warn 3=info 4=debug
scoreboard objectives add macroengine.log_level dummy
execute unless score #macroengine.log_level macroengine.log_level matches 0.. run scoreboard players set #macroengine.log_level macroengine.log_level 3

# Config scoreboard — fast integer config values (no storage lookup needed)
scoreboard objectives add macroengine.config dummy

# Gamerule module — scratch scoreboard for numeric range checks
scoreboard objectives add macroengine.gamerule dummy

# State scoreboard — per-player state machine (0=idle 1=combat 2=menu ...)
scoreboard objectives add macroengine.state dummy

# Permission level — read by core/internal/security/check_all against the
# security.cmd_min_level / sandbox_cmd_min_level / admin_min_level thresholds
# (only enforced while flags.experimental.strict_gating is on).
# Default: 1 (base user). macroengine.admin tag always bypasses this
# regardless of numeric value, so admins don't need it set manually.
scoreboard objectives add macroengine.perm_level dummy

# experimental/combat_tag — damage_dealt delta detection (same
# stat-delta pattern as the hook_* objectives above), plus a countdown
# timer per tagged player. Self-contained: only touched while
# flags.experimental.combat_tag is on.
scoreboard objectives add macroengine.exp_dmg_dealt minecraft.custom:minecraft.damage_dealt
scoreboard objectives add macroengine.exp_combat_timer dummy
