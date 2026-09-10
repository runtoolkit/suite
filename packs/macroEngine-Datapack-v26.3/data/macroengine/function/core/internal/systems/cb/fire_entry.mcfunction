# macroengine:systems/cb/internal/fire_entry
# Fires the command in _cb_entry via command block.
# Reuses api/cb/internal machinery.

# Copy to input storage, reuse exec path
data modify storage macroengine:input cb set from storage macroengine:engine _cb_entry
function macroengine:core/internal/api/cb/exec with storage macroengine:input cb
data remove storage macroengine:input cb
