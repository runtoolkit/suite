# macroengine:config
# Single source of runtime configuration (replaces _rt_origin + scattered defaults).
# Other packs may read macroengine:engine config / macroengine.meta scores; do not hardcode.

# ── Version (602 = 6.0.2) ──────────────────────────────────────────
scoreboard objectives add macroengine.meta dummy
scoreboard players set #runtoolkit.packs.macroengine.version macroengine.meta 602

# Archived flag: set to 1 to show archive warning on every /reload
# scoreboard players set #runtoolkit.archivedpacks.macroengine macroengine.meta 1
execute unless score #runtoolkit.archivedpacks.macroengine macroengine.meta = #runtoolkit.archivedpacks.macroengine macroengine.meta run scoreboard players set #runtoolkit.archivedpacks.macroengine macroengine.meta 0

# ── Engine defaults (only fill missing keys — preserves live data) ─
execute unless data storage macroengine:engine global run data modify storage macroengine:engine global set value {}
data modify storage macroengine:engine global.version set value "v6.0.2"

execute unless data storage macroengine:engine config run data modify storage macroengine:engine config set value {}

# Feature toggles (override via /data modify storage macroengine:engine config.*)
execute unless data storage macroengine:engine config.enabled run data modify storage macroengine:engine config.enabled set value 1b
execute unless data storage macroengine:engine config.debug_default run data modify storage macroengine:engine config.debug_default set value 0b
execute unless data storage macroengine:engine config.log_level run data modify storage macroengine:engine config.log_level set value 1
execute unless data storage macroengine:engine config.sandbox run data modify storage macroengine:engine config.sandbox set value 1b
execute unless data storage macroengine:engine config.reload_warn run data modify storage macroengine:engine config.reload_warn set value 1b
execute unless data storage macroengine:engine config.namespace_allowlist run data modify storage macroengine:engine config.namespace_allowlist set value ["macroengine:"]

# Mirror sandbox flag used by gate/* — gates are active by default (sandbox:1b).
# Disabling requires confirmation via macroengine_load:gate/toggle/disable; re-enabling
# (macroengine_load:gate/toggle/enable) does not.
execute if data storage macroengine:engine config{sandbox:1b} run data modify storage macroengine:engine sandbox set value 1b
execute unless data storage macroengine:engine config{sandbox:1b} run data modify storage macroengine:engine sandbox set value 0b

# Admin min level storage (legacy readers; not enforced when gates removed)
execute unless data storage macroengine:engine security run data modify storage macroengine:engine security set value {}
execute unless data storage macroengine:engine security.admin_min_level run data modify storage macroengine:engine security.admin_min_level set value 0
execute unless data storage macroengine:engine security.cmd_min_level run data modify storage macroengine:engine security.cmd_min_level set value 0
execute unless data storage macroengine:engine security.sandbox_cmd_min_level run data modify storage macroengine:engine security.sandbox_cmd_min_level set value 0
