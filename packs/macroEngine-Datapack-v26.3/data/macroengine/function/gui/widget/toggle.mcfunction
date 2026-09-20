# macroengine:gui :: widget/toggle   as player   storage macroengine:gui_in {obj:"my_score"}
# Result: new state (0/1)
function macroengine:gui/internal/toggle with storage macroengine:gui_in
scoreboard players set @s macroengine.gui_dirty 1
