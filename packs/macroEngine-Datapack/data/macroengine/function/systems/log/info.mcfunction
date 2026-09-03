# macroengine:systems/log/info
# Usage: $function macroengine:systems/log/info {message:"[System] Something happened"}
# Level: 3
$data modify storage macroengine:engine _log_add_tmp.message set value "$(message)"
data modify storage macroengine:engine _log_add_tmp.level set value "INFO"
data modify storage macroengine:engine _log_add_tmp.color set value "gray"
execute if score #macroengine.log_level macroengine.log_level matches 3.. run function macroengine:systems/log/add with storage macroengine:engine _log_add_tmp
