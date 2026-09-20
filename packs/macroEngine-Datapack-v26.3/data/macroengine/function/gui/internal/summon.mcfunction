# macro: $(menu)     as player, at player     (called by api/open)
# 1. container name comes from the registered menu, default chest_minecart
$data modify storage macroengine:gui_ctx ctype set from storage macroengine:gui_reg menus."$(menu)".container
execute unless data storage macroengine:gui_ctx ctype run data modify storage macroengine:gui_ctx ctype set value "chest_minecart"

# 2. resolve its definition: registry entry (macroengine:gui/reg containers.<name>, see containers_builtin),
#    otherwise the name is taken as a raw entity id like before (27 slots, gray pad)
data remove storage macroengine:gui_ctx cdef
function macroengine:gui/internal/summon_resolve with storage macroengine:gui_ctx
execute unless data storage macroengine:gui_ctx cdef run function macroengine:gui/internal/summon_legacy with storage macroengine:gui_ctx
execute unless data storage macroengine:gui_ctx cdef.entity run data modify storage macroengine:gui_ctx cdef.entity set from storage macroengine:gui_ctx ctype
execute unless data storage macroengine:gui_ctx cdef.slots run data modify storage macroengine:gui_ctx cdef.slots set value 27
execute unless data storage macroengine:gui_ctx cdef.pad run data modify storage macroengine:gui_ctx cdef.pad set value "minecraft:gray_stained_glass_pane"

# 3. summon (a title becomes the CustomName)
execute if data storage macroengine:gui_ctx cdef.title run function macroengine:gui/internal/summon_titled with storage macroengine:gui_ctx cdef
execute unless data storage macroengine:gui_ctx cdef.title run function macroengine:gui/internal/summon_type with storage macroengine:gui_ctx cdef

# 4. slot count on cart and owner; the definition is kept per owner uid for widget/pad
execute store result score @s macroengine.gui_slots run data get storage macroengine:gui_ctx cdef.slots
scoreboard players operation @e[type=#macroengine:gui/container,tag=macroengine.gui_new,distance=..1,limit=1] macroengine.gui_slots = @s macroengine.gui_slots
execute store result storage macroengine:gui_ctx uid int 1 run scoreboard players get @s macroengine.gui_uid
function macroengine:gui/internal/cont_bind with storage macroengine:gui_ctx
# a cart that looks different from the plain 27-slot gray one takes the registry-driven pad path
execute unless data storage macroengine:gui_ctx cdef{slots:27,pad:"minecraft:gray_stained_glass_pane"} run tag @e[type=#macroengine:gui/container,tag=macroengine.gui_new,distance=..1,limit=1] add macroengine.gui_styled

data remove storage macroengine:gui_ctx ctype
data remove storage macroengine:gui_ctx cdef
data remove storage macroengine:gui_ctx uid
