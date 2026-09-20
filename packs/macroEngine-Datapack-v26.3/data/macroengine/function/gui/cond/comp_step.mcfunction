# macroengine:gui :: cond/comp_step     as player     one element per call, recurses until the list is done or the result is decided
execute unless score #ci macroengine.gui_tmp < #cn macroengine.gui_tmp run return 0
execute store result storage macroengine:gui_cnd i int 1 run scoreboard players get #ci macroengine.gui_tmp
function macroengine:gui/cond/comp_pick with storage macroengine:gui_cnd
function macroengine:gui/internal/clear_cond
function macroengine:gui/cond/load_cur
scoreboard players set #cond macroengine.gui_tmp 0
execute unless data storage macroengine:gui_cond {type:"all"} unless data storage macroengine:gui_cond {type:"any"} run function macroengine:gui/cond/check
execute if score #cmode macroengine.gui_tmp matches 0 if score #cond macroengine.gui_tmp matches 0 run scoreboard players set #cacc macroengine.gui_tmp 0
execute if score #cmode macroengine.gui_tmp matches 1 if score #cond macroengine.gui_tmp matches 1 run scoreboard players set #cacc macroengine.gui_tmp 1
scoreboard players add #ci macroengine.gui_tmp 1
# decided already: all stops at the first failure, any at the first pass
execute if score #cmode macroengine.gui_tmp matches 0 if score #cacc macroengine.gui_tmp matches 0 run return 0
execute if score #cmode macroengine.gui_tmp matches 1 if score #cacc macroengine.gui_tmp matches 1 run return 0
function macroengine:gui/cond/comp_step
