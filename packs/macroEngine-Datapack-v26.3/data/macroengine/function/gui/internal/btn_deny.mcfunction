# macroengine:gui :: internal/btn_deny     as player     reads storage macroengine:gui_btn cur.deny
function macroengine:gui/internal/clear_in
data modify storage macroengine:gui_in msg set value "Not available."
execute if data storage macroengine:gui_btn cur.deny run data modify storage macroengine:gui_in msg set from storage macroengine:gui_btn cur.deny
data modify storage macroengine:gui_in color set value "red"
function macroengine:gui/widget/say
