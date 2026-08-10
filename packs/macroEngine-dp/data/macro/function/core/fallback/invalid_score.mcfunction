# macro:core/fallback/invalid_score
# Called when a required scoreboard value is absent or out of range.
data modify storage macro:input message set value "[Fallback] invalid_score — score missing or out of range, using default"
data modify storage macro:input level set value "WARN"
data modify storage macro:input color set value "yellow"
execute if score #ame.log_level ame.log_level matches 2.. run function macro:systems/log/add with storage macro:input {}
data modify storage macro:output fallback set value {triggered:1b,reason:"invalid_score"}
return 0
