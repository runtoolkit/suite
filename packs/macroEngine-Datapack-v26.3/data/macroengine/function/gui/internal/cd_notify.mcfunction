# macroengine:gui :: internal/cd_notify     as player
# Tells the player how long the cooldown still runs. Call it when widget/cooldown_start
# returned 0 (before this, a refused click gave the player no feedback at all).
#
#   execute unless function macroengine:gui/widget/cooldown_start run function macroengine:gui/internal/cd_notify
#
# Do NOT call cooldown_start first and then test `macroengine.gui_cd matches 1..`: on success it has just
# SET the cooldown, so that test is true then too and the player would be told to wait after a
# click that worked. `unless function` only runs cd_notify when cooldown_start returned 0.
#
# macroengine.gui_cd counts ticks; 20 ticks = 1 second. Shown rounded UP so the player never sees "0s"
# while a cooldown is still running.
scoreboard players operation #cdleft macroengine.gui_tmp = @s macroengine.gui_cd
scoreboard players add #cdleft macroengine.gui_tmp 19
scoreboard players set #cd20 macroengine.gui_tmp 20
scoreboard players operation #cdleft macroengine.gui_tmp /= #cd20 macroengine.gui_tmp
tellraw @s [{"text":"[GUI] ","color":"gray"},{"text":"Wait ","color":"red","italic":false},{"score":{"name":"#cdleft","objective":"macroengine.gui_tmp"},"color":"red","italic":false},{"text":"s.","color":"red","italic":false}]
