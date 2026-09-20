# macroengine:gui :: internal/cleanup_scores
# Resets the transient fake-player scores. Permanent ones (#version, #next_uid in macroengine.gui_const) are kept.
scoreboard players reset #uid macroengine.gui_tmp
scoreboard players reset #found macroengine.gui_tmp
scoreboard players reset #hit macroengine.gui_tmp
scoreboard players reset #gui macroengine.gui_tmp
scoreboard players reset #left macroengine.gui_tmp
scoreboard players reset #wcount macroengine.gui_tmp
scoreboard players reset #have macroengine.gui_tmp
scoreboard players reset #paid macroengine.gui_tmp
scoreboard players reset #cond macroengine.gui_tmp
scoreboard players reset #draw_ok macroengine.gui_tmp
scoreboard players reset #btn_close macroengine.gui_tmp
# meter widget temps (see internal/meter_hit, internal/meter_probe_loop) -- this list was never
# exhaustive to begin with (progress's own #f/#i/#d/#f2/#abs aren't reset here either, since
# every one of these is always overwritten before it's read), added for consistency with the
# other click-time scratch scores rather than because leaving them out was causing a bug.
scoreboard players reset #mw macroengine.gui_tmp
scoreboard players reset #mc macroengine.gui_tmp
scoreboard players reset #mval macroengine.gui_tmp
scoreboard players reset #mmax macroengine.gui_tmp
scoreboard players reset #mhit macroengine.gui_tmp
# added with cond/t_level and internal/cd_notify
scoreboard players reset #lvl macroengine.gui_tmp
scoreboard players reset #cdleft macroengine.gui_tmp
scoreboard players reset #pi macroengine.gui_tmp
# composite conditions (cond/comp_run, comp_step)
scoreboard players reset #cmode macroengine.gui_tmp
scoreboard players reset #cacc macroengine.gui_tmp
scoreboard players reset #cn macroengine.gui_tmp
scoreboard players reset #ci macroengine.gui_tmp
scoreboard players reset #cnot macroengine.gui_tmp
scoreboard players reset #cd20 macroengine.gui_tmp
scoreboard players set #ok macroengine.gui_const 0
