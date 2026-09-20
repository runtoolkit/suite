# macroengine:gui/core/load — gui module init (called from macroengine:core/internal/load/loader/other)
scoreboard objectives add macroengine.gui_timer dummy
scoreboard objectives add macroengine.gui_tmax dummy
scoreboard objectives add macroengine.gui_click dummy
scoreboard objectives add macroengine.gui_page dummy
scoreboard objectives add macroengine.gui_tmp dummy
scoreboard objectives add macroengine.gui_rand dummy
scoreboard objectives add macroengine.gui_cd dummy
scoreboard objectives add macroengine.gui_dirty dummy
scoreboard objectives add macroengine.gui_uid dummy
scoreboard objectives add macroengine.gui_const dummy
scoreboard objectives add macroengine.gui_slots dummy
scoreboard objectives add macroengine.gui_drop minecraft.custom:minecraft.drop

scoreboard players set #version macroengine.gui_const 2
# uid counter is only initialised once so uids stay unique across reloads
execute unless score #next_uid macroengine.gui_const matches 0.. run scoreboard players set #next_uid macroengine.gui_const 1

# transient scratch storage / scores are dropped on every reload (stale state from a previous run)
function macroengine:gui/internal/clear_in
function macroengine:gui/internal/clear_w
function macroengine:gui/internal/clear_cond
function macroengine:gui/internal/clear_tmp
function macroengine:gui/internal/clear_btn_cur
function macroengine:gui/internal/clear_mtr
function macroengine:gui/internal/cleanup_scores

# carts that lost their owner across a reload / relog are removed
function macroengine:gui/internal/sweep_orphans

# registry is rebuilt on every reload by the #macroengine:gui/register listeners
data modify storage macroengine:gui_reg menus set value {}
function macroengine:gui/internal/containers_builtin
data modify storage macroengine:gui_cont bound set value {}
data modify storage macroengine:gui_btn defs set value {}
function #macroengine:gui/register
