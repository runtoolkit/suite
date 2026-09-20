# macroengine:gui :: internal/clear_tmp
# Transient storage that is NOT covered by clear_in / clear_w / clear_cond.
# NOTE: macroengine:gui/reg (menu registry) and macroengine:gui/btn defs are PERMANENT (rebuilt on load) - never touched here.
# macroengine:gui/btn cur is NOT cleared here on purpose: api/close can run from INSIDE btn_click
# (button cmd "function macroengine:gui/api/close"), which still reads `cur` afterwards.
# It is cleared at the end of btn_click and on load (see internal/clear_btn_cur).
data remove storage macroengine:gui_ctx menu
data remove storage macroengine:gui_ctx alias
data remove storage macroengine:gui_ctx ctype
data remove storage macroengine:gui_ctx cdef
data remove storage macroengine:gui_ctx uid
data remove storage macroengine:gui_ctx pad
data remove storage macroengine:gui_ctx i
data remove storage macroengine:gui_cnd items
data remove storage macroengine:gui_cnd cur
data remove storage macroengine:gui_cnd i
data remove storage macroengine:gui_p id
