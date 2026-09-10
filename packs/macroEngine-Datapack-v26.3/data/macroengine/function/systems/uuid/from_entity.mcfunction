# ============================================================
# macroengine:systems/uuid/from_entity
# Converts the current entity's (@s) UUID to a hex string
#
# KULLANIM:
# execute as <entity> run function macroengine:systems/uuid/from_entity
#
# OUTPUT:
# macroengine:input value → "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
#
# Output is written to macroengine:input value (AME standard)
# Direct NBT read on each call — always up to date
# Negative byte error is fixed (see extract_bytes)
# ============================================================

# Copy entity UUID as int[4] to working storage
data modify storage macroengine:uuid _work set from entity @s UUID

# Load four ints to scoreboard (without writing scores to entity)
execute store result score $uuid.0 macroengine.tmp run data get storage macroengine:uuid _work[0]
execute store result score $uuid.1 macroengine.tmp run data get storage macroengine:uuid _work[1]
execute store result score $uuid.2 macroengine.tmp run data get storage macroengine:uuid _work[2]
execute store result score $uuid.3 macroengine.tmp run data get storage macroengine:uuid _work[3]

# Split into 16 bytes → convert to hex chars → concatenate UUID string
function macroengine:core/internal/systems/uuid/extract_bytes
function macroengine:core/internal/systems/uuid/get_hexes with storage macroengine:uuid _tmp
function macroengine:core/internal/systems/uuid/concat with storage macroengine:uuid _tmp
