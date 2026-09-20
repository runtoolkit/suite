# macroengine:gui :: internal/clear_cond
# Same idea as clear_in / clear_w, for storage macroengine:gui_cond. Call it BEFORE `data merge storage macroengine:gui_cond {...}`.
# When you add a new key to a cond type, add it here too.
data remove storage macroengine:gui_cond adv
data remove storage macroengine:gui_cond item
data remove storage macroengine:gui_cond max
data remove storage macroengine:gui_cond min
data remove storage macroengine:gui_cond mode
data remove storage macroengine:gui_cond not
data remove storage macroengine:gui_cond obj
data remove storage macroengine:gui_cond of
data remove storage macroengine:gui_cond pred
data remove storage macroengine:gui_cond tag
data remove storage macroengine:gui_cond type
