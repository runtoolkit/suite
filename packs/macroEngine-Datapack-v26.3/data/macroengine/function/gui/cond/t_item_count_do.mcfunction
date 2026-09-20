# macro: $(item) $(min)
# `clear ... 0` only counts. The clicked GUI widget sits in the player's inventory while a handler
# runs, so widget items of the same type are subtracted (otherwise a diamond button would count as
# one diamond owned).
$execute store result score #have macroengine.gui_tmp run clear @s $(item) 0
$execute store result score #gui macroengine.gui_tmp run clear @s $(item)[custom_data~{macroengine:{gui:{w:1b}}}] 0
scoreboard players operation #have macroengine.gui_tmp -= #gui macroengine.gui_tmp
$execute if score #have macroengine.gui_tmp matches $(min).. run scoreboard players set #cond macroengine.gui_tmp 1
