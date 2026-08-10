# macro:core/fallback/no_permission
# Called when the executor lacks macro.admin tag.
data modify storage macro:input message set value "[Fallback] no_permission — macro.admin tag required"
data modify storage macro:input level set value "WARN"
data modify storage macro:input color set value "yellow"
execute if score #ame.log_level ame.log_level matches 2.. run function macro:systems/log/add with storage macro:input {}
data modify storage macro:output fallback set value {triggered:1b,reason:"no_permission"}
return 0
