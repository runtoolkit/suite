# macro: $(id) $(slot)     as cart      (called by widget/draw_on_cart when `item replace` did not place the widget)
$tellraw @a[distance=..8] [{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"gui: could not draw widget ","color":"red"},{"text":"$(id)","color":"gold"},{"text":" in slot $(slot) (check name / lore / item)","color":"red"}]
