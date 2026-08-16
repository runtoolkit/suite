# macroengine:systems/geo/region_watch/internal/register_exec [MACRO]
# INPUT: $(id), $(x1), $(y1), $(z1), $(x2), $(y2), $(z2)
#        $(on_enter), $(on_leave) — opsiyonel func
#        $(on_enter_cmd), $(on_leave_cmd) — opsiyonel cmd
#
# region_watches stored as list: [{id,x1,...,on_enter,...}, ...]
# If same id exists, filter it out first, then append.

# Varsa sil (unregister_filter pattern)
data modify storage macroengine:engine _rw_unbind_id set from storage macroengine:input id
data modify storage macroengine:engine _rw_new set value []
data modify storage macroengine:engine _rw_src set from storage macroengine:engine region_watches
function macroengine:core/internal/systems/geo/region_watch/unregister_filter
data modify storage macroengine:engine region_watches set from storage macroengine:engine _rw_new
data remove storage macroengine:engine _rw_new
data remove storage macroengine:engine _rw_src
data remove storage macroengine:engine _rw_unbind_id

# Create new record and append
$data modify storage macroengine:engine region_watches append value {id:"$(id)",x1:$(x1),y1:$(y1),z1:$(z1),x2:$(x2),y2:$(y2),z2:$(z2)}

# on_enter / on_leave func — last appended element [-1]
execute if data storage macroengine:input on_enter run data modify storage macroengine:engine region_watches[-1].on_enter set from storage macroengine:input on_enter
execute if data storage macroengine:input on_leave run data modify storage macroengine:engine region_watches[-1].on_leave set from storage macroengine:input on_leave

# on_enter_cmd / on_leave_cmd
execute if data storage macroengine:input on_enter_cmd run data modify storage macroengine:engine region_watches[-1].on_enter_cmd set from storage macroengine:input on_enter_cmd
execute if data storage macroengine:input on_leave_cmd run data modify storage macroengine:engine region_watches[-1].on_leave_cmd set from storage macroengine:input on_leave_cmd

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"geo/region_watch/register ","color":"aqua"},{"text":"$(id)","color":"white"},{"text":" ($(x1),$(y1),$(z1))→($(x2),$(y2),$(z2))","color":"#555555"}]
