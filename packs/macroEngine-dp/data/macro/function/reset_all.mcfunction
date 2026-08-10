function macro:core/disable/main

function macro:systems/hook/unbind_all
function macro:api/trigger/unbind_all
function macro:api/wand/unregister_all
data remove storage macro:engine interaction_binds
data remove storage macro:engine fibers
data remove storage macro:engine perm_triggers
data remove storage macro:engine perm_trigger_names
data remove storage macro:engine log_display
data remove storage macro:engine schedules
data remove storage macro:engine global.tick
data remove storage macro:engine global.epoch

tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"Engine disabled. ","color":"red"},{"text":"Restart → ","color":"#555555"},{"text":"/reload","color":"aqua","bold":true,"underlined":true}]