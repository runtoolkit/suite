# macro:core/fallback/entity_missing
# Called when a required entity target was not found.
data modify storage macro:input message set value "[Fallback] entity_missing — no valid target found"
data modify storage macro:input level set value "WARN"
data modify storage macro:input color set value "yellow"
execute if score #ame.log_level ame.log_level matches 2.. run function macro:systems/log/add with storage macro:input {}
data modify storage macro:output fallback set value {triggered:1b,reason:"entity_missing"}
return 0
