# macroengine:gui :: widget/goto_page   as player   storage macroengine:gui_in {page:N}
execute store result score @s macroengine.gui_page run data get storage macroengine:gui_in page
scoreboard players set @s macroengine.gui_dirty 1
