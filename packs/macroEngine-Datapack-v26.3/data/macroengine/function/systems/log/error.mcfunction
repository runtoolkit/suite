# macroengine:systems/log/error
# Usage: $function macroengine:systems/log/error {message:"[System] Something failed"}
# Level: 1 — always shown unless log is off
$data modify storage macroengine:engine _log_add_tmp.message set value "$(message)"
data modify storage macroengine:engine _log_add_tmp.level set value "ERROR"
data modify storage macroengine:engine _log_add_tmp.color set value "red"
execute if score #macroengine.log_level macroengine.log_level matches 1.. run function macroengine:systems/log/add with storage macroengine:engine _log_add_tmp
