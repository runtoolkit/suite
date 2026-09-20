# macro: $(ctype)
# Not a registered container: treat the name as a vanilla entity id (chest_minecart,
# hopper_minecart, oak_chest_boat, ...). It still must be in #macroengine:gui/container to actually
# work -- open_fail catches anything that isn't (see that file's comment).
$data modify storage macroengine:gui_ctx cdef set value {entity:"$(ctype)", slots:27, pad:"minecraft:gray_stained_glass_pane"}
