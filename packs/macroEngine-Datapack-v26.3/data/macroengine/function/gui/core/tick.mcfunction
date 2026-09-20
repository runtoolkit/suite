# macroengine:gui :: tick
# Module toggle guard — skips this module when disabled via macroengine:api/toggle/gui/false
execute unless data storage macroengine:engine {modules:{gui:1b}} run return 0

execute as @a[scores={macroengine.gui_timer=1..}] at @s run function macroengine:gui/core/tick_player
kill @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{macroengine:{gui:{w:1b}}}}}}]
