# macro: $(entity)     (storage macroengine:gui_ctx cdef)
# Enabled:0b keeps a hopper_minecart from sucking in dropped items / moving items; other entity types ignore the key.
$summon minecraft:$(entity) ~ ~ ~ {Invulnerable:1b,NoGravity:1b,Silent:1b,Enabled:0b,Tags:["macroengine.gui_cart","macroengine.gui_new"]}
