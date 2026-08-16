# macroengine:core/internal/api/item/use_cooldown_apply
# Internal — do not call directly. Final pass of api/item/use_cooldown.
# Expects: {player:"...",slot:"...",macroengine:{...}}

$item modify entity @a[name=$(player),limit=1] $(slot) macroengine:item_modifier/set_custom_data
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"item/use_cooldown ","color":"aqua"},{"text":"$(player) ","color":"white"},{"text":"slot=$(slot)","color":"gray"}]
