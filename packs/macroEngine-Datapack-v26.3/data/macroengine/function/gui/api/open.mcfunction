# macroengine:gui :: api/open        as <player> at <player>
# Input  (storage macroengine:gui_in): {menu:"<ns>:<id>", page:0, timer:900}
# Result: #ok macroengine.gui_const = 1 opened, 0 failed
#
#   function macroengine:gui/internal/clear_in
#   data merge storage macroengine:gui_in {menu:"ns:id"}
#   function macroengine:gui/api/open

scoreboard players set #ok macroengine.gui_const 0

# validate BEFORE touching any state
function macroengine:gui/internal/open_check with storage macroengine:gui_in
execute unless score #ok macroengine.gui_const matches 1 run return 0

# close this player's previous menu
execute if score @s macroengine.gui_uid matches 1.. run function macroengine:gui/api/close

# defaults
execute unless data storage macroengine:gui_in page run data modify storage macroengine:gui_in page set value 0
execute unless data storage macroengine:gui_in timer run data modify storage macroengine:gui_in timer set value 900

# owner uid
scoreboard players operation @s macroengine.gui_uid = #next_uid macroengine.gui_const
scoreboard players add #next_uid macroengine.gui_const 1

# summon + bind cart to owner
function macroengine:gui/internal/summon with storage macroengine:gui_in
execute unless entity @e[type=#macroengine:gui/container,tag=macroengine.gui_new,distance=..1] run return run function macroengine:gui/internal/open_fail
scoreboard players operation @e[type=#macroengine:gui/container,tag=macroengine.gui_new,distance=..1,limit=1] macroengine.gui_uid = @s macroengine.gui_uid
tag @e[type=#macroengine:gui/container,tag=macroengine.gui_new,distance=..1] remove macroengine.gui_new

# state
# macroengine.gui_drop is the vanilla drop statistic: it also counts drops made while no menu was open, so start clean
scoreboard players set @s macroengine.gui_drop 0
execute store result score @s macroengine.gui_page run data get storage macroengine:gui_in page
execute store result score @s macroengine.gui_timer run data get storage macroengine:gui_in timer
# remembered for internal/reset_cd (advancement macroengine:gui/interact_cart)
scoreboard players operation @s macroengine.gui_tmax = @s macroengine.gui_timer
data modify storage macroengine:gui_ctx menu set from storage macroengine:gui_in menu
function macroengine:gui/internal/set_menu_tag with storage macroengine:gui_ctx

scoreboard players set @s macroengine.gui_dirty 1
function macroengine:gui/core/redraw

data remove storage macroengine:gui_in page
data remove storage macroengine:gui_in timer
data remove storage macroengine:gui_ctx menu
data remove storage macroengine:gui_ctx alias
scoreboard players set #ok macroengine.gui_const 1
return 1
