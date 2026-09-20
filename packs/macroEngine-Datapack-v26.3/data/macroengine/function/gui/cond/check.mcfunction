# macroengine:gui :: cond/check    as player    storage macroengine:gui_cond = {type:"...", ..., not:1b}
# Result: #cond macroengine.gui_tmp = 1 (passed) / 0 (failed), and the same value is returned.
#
# Types (keys in brackets are optional):
#   score        {obj:"coins", [min:N], [max:N]}      unset score = fails
#   item_count   {item:"minecraft:diamond", [min:N]}  min defaults to 1; plain id or #tag only
#   tag          {tag:"vip"}
#   gamemode     {mode:"survival"}                    survival | creative | adventure | spectator
#   advancement  {adv:"minecraft:story/root"}
#   predicate    {pred:"ns:name"}
#   level        {[min:N], [max:N]}                    XP level (not a scoreboard); both optional
#   all / any    {of:[{type:..}, {type:..}]}           every / at least one element passes. Elements must be
#                                                      leaf types above (a nested all/any counts as failed)
# `not:1b` inverts the result. Unknown type / missing key = fails (closed).
#
#   function macroengine:gui/internal/clear_cond
#   data merge storage macroengine:gui_cond {type:"score", obj:"coins", min:10}
#   function macroengine:gui/cond/check
#   execute if score #cond macroengine.gui_tmp matches 1 run ...
#
# One small function per type (no big execute chains), same as the rest of the pack.
scoreboard players set #cond macroengine.gui_tmp 0
execute if data storage macroengine:gui_cond {type:"all"} run return run function macroengine:gui/cond/t_all
execute if data storage macroengine:gui_cond {type:"any"} run return run function macroengine:gui/cond/t_any
execute if data storage macroengine:gui_cond {type:"score"} run function macroengine:gui/cond/t_score
execute if data storage macroengine:gui_cond {type:"item_count"} run function macroengine:gui/cond/t_item_count
execute if data storage macroengine:gui_cond {type:"tag"} if data storage macroengine:gui_cond tag run function macroengine:gui/cond/t_tag with storage macroengine:gui_cond
execute if data storage macroengine:gui_cond {type:"gamemode"} if data storage macroengine:gui_cond mode run function macroengine:gui/cond/t_gamemode with storage macroengine:gui_cond
execute if data storage macroengine:gui_cond {type:"advancement"} if data storage macroengine:gui_cond adv run function macroengine:gui/cond/t_advancement with storage macroengine:gui_cond
execute if data storage macroengine:gui_cond {type:"predicate"} if data storage macroengine:gui_cond pred run function macroengine:gui/cond/t_predicate with storage macroengine:gui_cond
execute if data storage macroengine:gui_cond {type:"level"} run function macroengine:gui/cond/t_level
execute if data storage macroengine:gui_cond {not:1b} run function macroengine:gui/cond/negate
return run scoreboard players get #cond macroengine.gui_tmp
