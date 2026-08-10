# macro:core/fallback/not_loaded
# Called when the engine is not initialized.
data modify storage macro:input message set value "[Fallback] not_loaded — macroEngine not initialized, run /function macro:load"
data modify storage macro:input level set value "ERROR"
data modify storage macro:input color set value "red"
execute if score #ame.log_level ame.log_level matches 1.. run function macro:systems/log/add with storage macro:input {}
data modify storage macro:output fallback set value {triggered:1b,reason:"not_loaded"}
return 0
