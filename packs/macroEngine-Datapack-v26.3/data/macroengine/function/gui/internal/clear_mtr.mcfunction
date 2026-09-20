# macroengine:gui :: internal/clear_mtr
# Clears the macroengine:gui/mtr scratch storage before a fresh defs lookup, so stale keys from a
# previous meter_draw / meter_probe call (obj, max, width, id, c, cur) can never leak into the
# next one. Same idea as internal/clear_in / internal/clear_w.
data remove storage macroengine:gui_mtr cur
data remove storage macroengine:gui_mtr obj
data remove storage macroengine:gui_mtr max
data remove storage macroengine:gui_mtr width
data remove storage macroengine:gui_mtr id
data remove storage macroengine:gui_mtr c
