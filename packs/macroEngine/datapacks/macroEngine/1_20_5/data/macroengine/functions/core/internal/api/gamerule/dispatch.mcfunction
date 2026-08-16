# macroengine:api/gamerule/internal/dispatch
# Evaluates the value and calls the appropriate callback function.
# Called exclusively by macroengine:api/gamerule/set — do NOT call directly.
#
# INPUT (storage macroengine:input):
# value — raw value string: "true", "false", or numeric string
# gr_on_true — (optional) function to call when value is "true"
# gr_on_false — (optional) function to call when value is "false"
# gr_on_value — (optional) function to call for numeric match
# gr_matches — (optional) scoreboard range string, e.g. "5..10"

# ── Boolean: true ────────────────────────────────────────────────────────────
execute if data storage macroengine:input {value:"true"} if data storage macroengine:input gr_on_true run return run function macroengine:core/internal/api/gamerule/call_on_true with storage macroengine:input {}

# ── Boolean: false ───────────────────────────────────────────────────────────
execute if data storage macroengine:input {value:"false"} if data storage macroengine:input gr_on_false run return run function macroengine:core/internal/api/gamerule/call_on_false with storage macroengine:input {}

# ── Numeric with explicit matches range ──────────────────────────────────────
execute if data storage macroengine:input gr_on_value if data storage macroengine:input gr_matches run function macroengine:core/internal/api/gamerule/numeric_check with storage macroengine:input {}
