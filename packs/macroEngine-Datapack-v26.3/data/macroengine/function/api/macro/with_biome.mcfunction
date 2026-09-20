# ─────────────────────────────────────────────
# macroengine:api/macro/with_advancement [MACRO]
#

# Clear pipe
data remove storage macroengine:engine _macro_pipe

# Default: not completed
$data modify storage macroengine:engine _macro_pipe.$(var) set value "empty"

# Set to 1b if the player has completed the tag
$execute as @a[name=$(player),limit=1] unless biome $(z) $(y) $(z) $(biome) run data modify storage macroengine:engine _macro_pipe.$(var) set value 1b
$execute as @a[name=$(player),limit=1] unless biome $(z) $(y) $(z) $(biome) run data modify storage macroengine:engine _macro_pipe.$(var) set value 0b

# Call target function with pipe as macro source
$function $(func) with storage macroengine:engine _macro_pipe