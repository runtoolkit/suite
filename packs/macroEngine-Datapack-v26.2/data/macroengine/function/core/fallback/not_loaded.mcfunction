# macroengine:core/fallback/not_loaded
# Called when the engine is not initialized.
data modify storage macroengine:engine _log_add_tmp.message set value "[Fallback] not_loaded — macroengine not initialized, run /function macroengine:load"
data modify storage macroengine:engine _log_add_tmp.level set value "ERROR"
data modify storage macroengine:engine _log_add_tmp.color set value "red"
execute if score #macroengine.log_level macroengine.log_level matches 1.. run function macroengine:systems/log/add with storage macroengine:engine _log_add_tmp
data modify storage macroengine:output fallback set value {triggered:1b,reason:"not_loaded"}
return 0
