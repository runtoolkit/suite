# macroengine:core/internal/systems/rate_limit/clear_work
# Internal — do not call directly.
#
# Scheduled 3 ticks after systems/rate_limit/check writes to the shared
# macroengine:rl_work scratch storage (ensure_key, rule, prune_before,
# new_hit), so it doesn't sit populated between calls. 'replace' collapses
# repeated check calls within the same 3-tick window onto a single
# pending clear — safe because every write into rl_work is a 'set value'
# / 'set from', never an append, so nothing here is ever read back across
# calls; a stale key can only be unclaimed scratch data.
#
# NOTE: "data remove storage <id>" with no path is not valid — /data
# remove can only delete a key under a storage, never the storage root
# itself (see https://minecraft.wiki/w/Commands/data). Every top-level
# key ever written to rl_work across check/evaluate/prune must be listed
# here explicitly: ensure_key, rule, prune_before, rule_key, new_hit.
data remove storage macroengine:rl_work ensure_key
data remove storage macroengine:rl_work rule
data remove storage macroengine:rl_work prune_before
data remove storage macroengine:rl_work rule_key
data remove storage macroengine:rl_work new_hit
