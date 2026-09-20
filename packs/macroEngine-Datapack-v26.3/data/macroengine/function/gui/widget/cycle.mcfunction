# macroengine:gui :: widget/cycle   as player
# storage macroengine:gui_in {obj:"score", n:3, last:2, wrap:1b}      (last = n-1)
function macroengine:gui/internal/cycle with storage macroengine:gui_in
scoreboard players set @s macroengine.gui_dirty 1
