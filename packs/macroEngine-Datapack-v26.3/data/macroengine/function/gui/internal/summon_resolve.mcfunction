# macro: $(ctype)
# Leaves storage macroengine:gui_ctx cdef unset when the name is not in the registry.
$data modify storage macroengine:gui_ctx cdef set from storage macroengine:gui_reg containers."$(ctype)"
