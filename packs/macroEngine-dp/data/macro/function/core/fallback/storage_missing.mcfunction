# macro:core/fallback/storage_missing
# Called when expected NBT storage data is absent.
data modify storage macro:input message set value "[Fallback] storage_missing — required NBT key not found"
data modify storage macro:input level set value "WARN"
data modify storage macro:input color set value "yellow"
execute if score #ame.log_level ame.log_level matches 2.. run function macro:systems/log/add with storage macro:input {}
data modify storage macro:output fallback set value {triggered:1b,reason:"storage_missing"}
return 0
