# ============================================================
# macroengine:systems/uuid/from_array
# Converts int array in macroengine:input value to UUID string
#
# KULLANIM:
# data modify storage macroengine:input value set value [I; a, b, c, d]
# function macroengine:systems/uuid/from_array
#
# INPUT:
# macroengine:input value → [I; int0, int1, int2, int3]
#
# OUTPUT:
# macroengine:input value → "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
#
# Output is written to macroengine:input value (AME standard)
# ============================================================

# Read int[4] array directly from macroengine:input value
execute store result score $uuid.0 macroengine.tmp run data get storage macroengine:input value[0]
execute store result score $uuid.1 macroengine.tmp run data get storage macroengine:input value[1]
execute store result score $uuid.2 macroengine.tmp run data get storage macroengine:input value[2]
execute store result score $uuid.3 macroengine.tmp run data get storage macroengine:input value[3]

# Split into 16 bytes → convert to hex chars → concatenate UUID string
function macroengine:core/internal/systems/uuid/extract_bytes
function macroengine:core/internal/systems/uuid/get_hexes with storage macroengine:uuid _tmp
function macroengine:core/internal/systems/uuid/concat with storage macroengine:uuid _tmp
