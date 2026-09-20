# macroengine:gui :: internal/clear_in
# `data merge` keeps old keys, and `data remove storage X` needs a path, so the
# scratch storage is cleared key by key. Call this BEFORE `data merge storage macroengine:gui_in {...}`
# so keys from a previous widget call (wrap, min, max, delta, ...) can never leak.
data remove storage macroengine:gui_in color
data remove storage macroengine:gui_in count
data remove storage macroengine:gui_in delta
data remove storage macroengine:gui_in item
data remove storage macroengine:gui_in last
data remove storage macroengine:gui_in max
data remove storage macroengine:gui_in menu
data remove storage macroengine:gui_in min
data remove storage macroengine:gui_in msg
data remove storage macroengine:gui_in n
data remove storage macroengine:gui_in obj
data remove storage macroengine:gui_in page
data remove storage macroengine:gui_in pitch
data remove storage macroengine:gui_in sound
data remove storage macroengine:gui_in ticks
data remove storage macroengine:gui_in timer
data remove storage macroengine:gui_in value
data remove storage macroengine:gui_in volume
data remove storage macroengine:gui_in wrap
