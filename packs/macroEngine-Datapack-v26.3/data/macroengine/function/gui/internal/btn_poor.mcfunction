# macroengine:gui :: internal/btn_poor     as player     reads storage macroengine:gui_btn cur.poor
function macroengine:gui/internal/clear_in
data modify storage macroengine:gui_in msg set value "You can't afford that."
execute if data storage macroengine:gui_btn cur.poor run data modify storage macroengine:gui_in msg set from storage macroengine:gui_btn cur.poor
data modify storage macroengine:gui_in color set value "red"
function macroengine:gui/widget/say
