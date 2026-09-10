# macroengine:systems/log/warn
# Usage: $function macroengine:systems/log/warn {message:"[System] Something suspicious"}
# Level: 2
$data modify storage macroengine:engine _log_add_tmp.message set value "$(message)"
data modify storage macroengine:engine _log_add_tmp.level set value "WARN"
data modify storage macroengine:engine _log_add_tmp.color set value "yellow"
execute if score #macroengine.log_level macroengine.log_level matches 2.. run function macroengine:systems/log/add with storage macroengine:engine _log_add_tmp
