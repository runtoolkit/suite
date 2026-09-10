# ============================================================
# macroengine:systems/uuid/match
# Compares @s entity's UUID with macroengine:input value
# If matched, runs macroengine:input func function
#
# KULLANIM:
# data modify storage macroengine:input value set value "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
# data modify storage macroengine:input func set value "mynamespace:my_function"
# execute as <entity> run function macroengine:systems/uuid/match
#
# INPUT:
# macroengine:input value → UUID string to compare (expected)
# macroengine:input func → function to run if matched
#
# NOTE: func is run in the same entity context.
# ============================================================

# Save expected UUID string to temporary field
# (from_entity call overwrites macroengine:input value)
data modify storage macroengine:uuid _match_target set from storage macroengine:input value

# Convert @s UUID to string → macroengine:input value
function macroengine:systems/uuid/from_entity

# Compare: if matched, run func
# Is the current UUID (macroengine:input value) equal to the expected?
function macroengine:core/internal/systems/uuid/match_check with storage macroengine:input
