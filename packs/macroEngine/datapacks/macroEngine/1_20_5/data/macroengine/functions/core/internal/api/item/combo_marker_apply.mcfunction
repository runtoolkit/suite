# macroengine:core/internal/api/item/combo_marker_apply
# Internal — do not call directly. Second pass of api/item/combo_marker.
# Expects: {player:"...",slot:"...",macroengine:{...}}

$item modify entity @a[name=$(player),limit=1] $(slot) macroengine:item_modifier/set_custom_data
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"item/combo_marker ","color":"aqua"},{"text":"$(player) ","color":"white"},{"text":"slot=$(slot)","color":"gray"}]
