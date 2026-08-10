# macro:systems/log/warn
# Usage: $function macro:systems/log/warn {message:"[System] Something suspicious"}
# Level: 2
$data modify storage macro:input message set value "$(message)"
data modify storage macro:input level set value "WARN"
data modify storage macro:input color set value "yellow"
execute if score #ame.log_level ame.log_level matches 2.. run function macro:systems/log/add with storage macro:input {}
