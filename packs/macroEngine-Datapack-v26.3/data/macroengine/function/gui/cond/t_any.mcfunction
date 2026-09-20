# macroengine:gui :: cond/t_any     storage macroengine:gui_cond {type:"any", of:[{...}, ...], [not]}
# Passes when AT LEAST ONE element passes (empty list = fails). See cond/comp_run.
scoreboard players set #cmode macroengine.gui_tmp 1
scoreboard players set #cacc macroengine.gui_tmp 0
return run function macroengine:gui/cond/comp_run
