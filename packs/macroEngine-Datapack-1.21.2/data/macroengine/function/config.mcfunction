# macroengine:config
# Single source of runtime configuration (replaces _rt_origin + scattered defaults).
# Other packs may read macroengine:engine config / macroengine.meta scores; do not hardcode.

# ── Version (610 = 6.1.0) ──────────────────────────────────────────
scoreboard objectives add macroengine.meta dummy
scoreboard players set #runtoolkit.packs.macroengine.version macroengine.meta 610

# Archived flag: set to 1 to show archive warning on every /reload
# scoreboard players set #runtoolkit.archivedpacks.macroengine macroengine.meta 1
execute unless score #runtoolkit.archivedpacks.macroengine macroengine.meta = #runtoolkit.archivedpacks.macroengine macroengine.meta run scoreboard players set #runtoolkit.archivedpacks.macroengine macroengine.meta 0

# ── Engine defaults (only fill missing keys — preserves live data) ─
execute unless data storage macroengine:engine global run data modify storage macroengine:engine global set value {}
data modify storage macroengine:engine global.version set value "v6.1.0"

execute unless data storage macroengine:engine config run data modify storage macroengine:engine config set value {}

# Feature toggles (override via /data modify storage macroengine:engine config.*)
execute unless data storage macroengine:engine config.enabled run data modify storage macroengine:engine config.enabled set value 1b
execute unless data storage macroengine:engine config.debug_default run data modify storage macroengine:engine config.debug_default set value 0b
execute unless data storage macroengine:engine config.log_level run data modify storage macroengine:engine config.log_level set value 1
execute unless data storage macroengine:engine config.sandbox run data modify storage macroengine:engine config.sandbox set value 1b
execute unless data storage macroengine:engine config.reload_warn run data modify storage macroengine:engine config.reload_warn set value 1b
execute unless data storage macroengine:engine config.namespace_allowlist run data modify storage macroengine:engine config.namespace_allowlist set value ["macroengine:"]

# Mirror sandbox flag used by gate/* — gates are active by default (sandbox:1b).
# Disabling requires confirmation via macroengine:core/internal/load/gate/toggle/disable; re-enabling
# (macroengine:core/internal/load/gate/toggle/enable) does not.
execute if data storage macroengine:engine config{sandbox:1b} run data modify storage macroengine:engine sandbox set value 1b
execute unless data storage macroengine:engine config{sandbox:1b} run data modify storage macroengine:engine sandbox set value 0b

# Admin/cmd/sandbox min level storage. Enforced by core/internal/security/check_all
# ONLY while flags.experimental.strict_gating is on (see below) — otherwise these
# are read but never compared against anything, same as before that flag existed.
# Threshold 0 = everyone passes even when strict_gating is on; raise these once
# you've confirmed strict_gating is stable for your server.
execute unless data storage macroengine:engine security run data modify storage macroengine:engine security set value {}
execute unless data storage macroengine:engine security.admin_min_level run data modify storage macroengine:engine security.admin_min_level set value 0
execute unless data storage macroengine:engine security.cmd_min_level run data modify storage macroengine:engine security.cmd_min_level set value 0
execute unless data storage macroengine:engine security.sandbox_cmd_min_level run data modify storage macroengine:engine security.sandbox_cmd_min_level set value 0

# ── Experimental feature flags (systems/flag/experimental/*) ──────
# All default OFF. Each gates one piece of new/previously-removed
# functionality so it can be toggled without editing files or /reload
# stripping intent. See systems/flag/experimental/list.mcfunction for
# the authoritative description of each flag.
execute unless data storage macroengine:engine flags run data modify storage macroengine:engine flags set value {}
execute unless data storage macroengine:engine flags.experimental run data modify storage macroengine:engine flags.experimental set value {}
execute unless data storage macroengine:engine flags.experimental.strict_gating run data modify storage macroengine:engine flags.experimental.strict_gating set value 0b
execute unless data storage macroengine:engine flags.experimental.hologram run data modify storage macroengine:engine flags.experimental.hologram set value 0b
execute unless data storage macroengine:engine flags.experimental.particle_trail run data modify storage macroengine:engine flags.experimental.particle_trail set value 0b
execute unless data storage macroengine:engine flags.experimental.crafting_ui run data modify storage macroengine:engine flags.experimental.crafting_ui set value 0b
execute unless data storage macroengine:engine flags.experimental.waypoint run data modify storage macroengine:engine flags.experimental.waypoint set value 0b
execute unless data storage macroengine:engine flags.experimental.combat_tag run data modify storage macroengine:engine flags.experimental.combat_tag set value 0b
execute unless data storage macroengine:engine flags.experimental.scoreboard_hud run data modify storage macroengine:engine flags.experimental.scoreboard_hud set value 0b
