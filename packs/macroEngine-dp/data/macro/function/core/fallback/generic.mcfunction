# macro:core/fallback/generic
# Called when no specific fallback applies.
data modify storage macro:input message set value "[Fallback] generic fallback triggered"
data modify storage macro:input level set value "WARN"
data modify storage macro:input color set value "yellow"
execute if score #ame.log_level ame.log_level matches 2.. run function macro:systems/log/add with storage macro:input {}
data modify storage macro:output fallback set value {triggered:1b,reason:"generic"}
return 0
