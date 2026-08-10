# macro:systems/log/show
# Usage: /function macro:systems/log/show
# Prints the log buffer to the calling player.
# Requires: macro.admin tag
execute unless entity @s[tag=macro.admin] run return 0

tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"━━━ Log Buffer ","color":"aqua"},{"text":"(level: ","color":"#555555"},{"score":{"name":"#ame.log_level","objective":"ame.log_level"},"color":"white"},{"text":")","color":"#555555"},{"text":"━━━━━━━━━━━━━","color":"#555555"}]
execute unless data storage macro:engine log_display[0] run tellraw @s ["",{"text":"  ","color":"#555555"},{"text":"(empty)","color":"gray","italic":true}]
execute unless data storage macro:engine log_display[0] run return 0

function macro:core/lib/input_push
data modify storage macro:engine _felist_input set from storage macro:engine log_display
data modify storage macro:input func set value "macro:systems/log/internal/print_entry"
function macro:core/lib/for_each_list with storage macro:input {}
function macro:core/lib/input_pop

tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
