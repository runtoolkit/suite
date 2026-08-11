# example_pack:tick
# Runs every game tick. Keep this lean — call sub-functions for heavy logic.

# Check playtime milestones for all players
execute as @a run function example_pack:playtime/check
