# macroengine:gui :: cond/t_all     storage macroengine:gui_cond {type:"all", of:[{...}, ...], [not]}
# Passes when EVERY element passes (empty list = passes). See cond/comp_run.
scoreboard players set #cmode macroengine.gui_tmp 0
scoreboard players set #cacc macroengine.gui_tmp 1
return run function macroengine:gui/cond/comp_run
