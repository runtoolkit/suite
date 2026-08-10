# macro:systems/log/debug
# Usage: $function macro:systems/log/debug {message:"[System] Trace detail"}
# Level: 4 — only shown when debug mode active
$data modify storage macro:input message set value "$(message)"
data modify storage macro:input level set value "DEBUG"
data modify storage macro:input color set value "dark_gray"
execute if score #ame.log_level ame.log_level matches 4.. run function macro:systems/log/add with storage macro:input {}
