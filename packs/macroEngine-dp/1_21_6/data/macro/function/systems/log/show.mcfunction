execute unless data storage macro:engine log_display[0] run tellraw @s {"text":"[Log] No entries.","color":"gray","italic":false}
execute unless data storage macro:engine log_display[0] run return 0

function macro:core/lib/input_push
data modify storage macro:engine _felist_input set from storage macro:engine log_display
data modify storage macro:input func set value "macro:systems/log/internal/print_entry"
function macro:core/lib/for_each_list with storage macro:input {}
function macro:core/lib/input_pop
