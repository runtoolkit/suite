# macroengine:core/fallback/storage_missing
# Called when expected NBT storage data is absent.
data modify storage macroengine:engine _log_add_tmp.message set value "[Fallback] storage_missing — required NBT key not found"
data modify storage macroengine:engine _log_add_tmp.level set value "WARN"
data modify storage macroengine:engine _log_add_tmp.color set value "yellow"
execute if score #macroengine.log_level macroengine.log_level matches 2.. run function macroengine:systems/log/add with storage macroengine:engine _log_add_tmp
data modify storage macroengine:output fallback set value {triggered:1b,reason:"storage_missing"}
return 0
