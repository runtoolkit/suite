# macroengine:gui :: widget/cooldown_start   as player   storage macroengine:gui_in {ticks:N}
# Sets macroengine.gui_cd if free. Result: 1 = allowed (cooldown now running), 0 = still cooling down.
execute if score @s macroengine.gui_cd matches 1.. run return 0
function macroengine:gui/internal/cd_set with storage macroengine:gui_in
return 1
