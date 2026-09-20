# macroengine:gui :: internal/btn_cond     as player     reads storage macroengine:gui_btn cur.cond
# Result: #cond macroengine.gui_tmp = 1 when the button has no condition or it passes, else 0.
scoreboard players set #cond macroengine.gui_tmp 1
execute unless data storage macroengine:gui_btn cur.cond run return 1
function macroengine:gui/internal/clear_cond
data remove storage macroengine:gui_cnd cur
data modify storage macroengine:gui_cnd cur set from storage macroengine:gui_btn cur.cond
function macroengine:gui/cond/load_cur
function macroengine:gui/cond/check
