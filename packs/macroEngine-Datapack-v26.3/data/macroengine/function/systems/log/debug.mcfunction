# macroengine:systems/log/debug
# Usage: $function macroengine:systems/log/debug {message:"[System] Trace detail"}
# Level: 4 — only shown when debug mode active
$data modify storage macroengine:engine _log_add_tmp.message set value "$(message)"
data modify storage macroengine:engine _log_add_tmp.level set value "DEBUG"
data modify storage macroengine:engine _log_add_tmp.color set value "dark_gray"
execute if score #macroengine.log_level macroengine.log_level matches 4.. run function macroengine:systems/log/add with storage macroengine:engine _log_add_tmp
