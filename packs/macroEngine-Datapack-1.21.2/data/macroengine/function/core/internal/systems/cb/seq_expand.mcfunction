# macroengine:systems/cb/internal/seq_expand
# Converts cb.cmds list + interval into individual cb_queue entries.
# Each entry gets ticks_left = (index + 1) * interval.

# Init sequence state
data modify storage macroengine:engine _cb_seq set from storage macroengine:input cb
execute store result score #cb_seq_idx macroengine.tmp run data get storage macroengine:engine _cb_seq.interval
scoreboard players set #cb_seq_step macroengine.tmp 0

execute if data storage macroengine:engine _cb_seq.cmds[0] run function macroengine:core/internal/systems/cb/seq_expand_loop
data remove storage macroengine:engine _cb_seq
