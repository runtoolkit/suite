# macroengine:api/gamerule/set [MACRO]
# Sets a custom gamerule value, persists it in storage, and dispatches
# a callback function when the value matches a defined condition.
#
# INPUT (macro args via `with storage macroengine:input {}`):
# $(rule) — rule name string, e.g. "pvp_enabled"
# $(value) — value string: "true", "false", or a number string e.g. "10"
#
# OPTIONAL storage keys (set before calling, removed after):
# macroengine:input gr_on_true — function to call when value is "true"
# macroengine:input gr_on_false — function to call when value is "false"
# macroengine:input gr_on_value — function to call for any numeric match
# macroengine:input gr_matches — scoreboard range string, e.g. "5..10" (used with gr_on_value)
#
# EXAMPLE:
# data modify storage macroengine:input rule set value "pvp_enabled"
# data modify storage macroengine:input value set value "true"
# data modify storage macroengine:input gr_on_true set value "mypack:pvp/enable"
# data modify storage macroengine:input gr_on_false set value "mypack:pvp/disable"
# function macroengine:api/gamerule/set with storage macroengine:input {}
#
# RETURN: 1 on success, 0 on guard failure.

# ── Normalize rule name: spaces → underscores, then lowercase ────────────────
data modify storage macroengine_string:input replace.String set from storage macroengine:input rule
data modify storage macroengine_string:input replace.Find set value " "
data modify storage macroengine_string:input replace.Replace set value "_"
function macroengine_string:util/replace
data modify storage macroengine_string:input to_lowercase.String set from storage macroengine_string:output replace
data remove storage macroengine_string:input replace
function macroengine_string:util/to_lowercase/fast
data modify storage macroengine:input _gamerule_norm set from storage macroengine_string:output to_lowercase

# ── Persist value in engine storage ──────────────────────────────────────────
function macroengine:core/internal/api/gamerule/persist with storage macroengine:input {}

# ── Dispatch callbacks ────────────────────────────────────────────────────────
function macroengine:core/internal/api/gamerule/dispatch with storage macroengine:input {}

# ── Debug log ─────────────────────────────────────────────────────────────────
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"gamerule/set ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(_gamerule_norm)","color":"white"},{"text":" = ","color":"#555555"},{"text":"$(value)","color":"green"}]

# ── Cleanup ───────────────────────────────────────────────────────────────────
data remove storage macroengine:input _gamerule_norm
