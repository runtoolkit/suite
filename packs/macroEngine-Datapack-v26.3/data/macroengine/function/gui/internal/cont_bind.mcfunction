# macro: $(uid)     as player
# Keeps the resolved container definition for this owner while the menu is open (widget/pad reads it).
$data modify storage macroengine:gui_cont bound.u$(uid) set from storage macroengine:gui_ctx cdef
