# macroengine:gui :: tick_player      as player with an open menu, at player
scoreboard players remove @s macroengine.gui_timer 1
execute if score @s macroengine.gui_timer matches ..0 run return run function macroengine:gui/api/close

# cooldown
execute if score @s macroengine.gui_cd matches 1.. run scoreboard players remove @s macroengine.gui_cd 1

# own cart follows own player ; none found -> close
scoreboard players operation #uid macroengine.gui_tmp = @s macroengine.gui_uid
scoreboard players set #found macroengine.gui_tmp 0
execute as @e[type=#macroengine:gui/container,tag=macroengine.gui_cart] if score @s macroengine.gui_uid = #uid macroengine.gui_tmp run function macroengine:gui/internal/follow
execute if score #found macroengine.gui_tmp matches 0 run return run function macroengine:gui/api/close

# click detection: a GUI item in the inventory == the player left-clicked it.
# `clear ... 0` only COUNTS. Everything below is gated on that count, so a tick with no
# GUI item in the inventory never reaches a destructive clear.
scoreboard players set @s macroengine.gui_click 0
execute store result score @s macroengine.gui_click run clear @s *[custom_data~{macroengine:{gui:{w:1b}}}] 0
execute if score @s macroengine.gui_click matches 1.. run function macroengine:gui/internal/click_handle

# drop detection: a GUI item in the inventory == the player dropped it.
# same counting trick as click. Kept in its own branch so click_handle can tell
# which event fired (macroengine.gui_click vs macroengine.gui_drop), instead of both landing here
# indistinguishably.
execute if score @s macroengine.gui_drop matches 1.. run function macroengine:gui/internal/click_handle
execute if score @s macroengine.gui_drop matches 1.. run scoreboard players set @s macroengine.gui_drop 0

# redraw when a click happened or a handler asked for it
execute if score @s macroengine.gui_dirty matches 1 run function macroengine:gui/core/redraw
execute if score @s macroengine.gui_dirty matches 1 run scoreboard players set @s macroengine.gui_dirty 0
scoreboard players reset @s macroengine.gui_click
