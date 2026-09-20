# macroengine:gui :: internal/cleanup_player   as player (called from api/close)
# Wipes per-session scratch storage so nothing from this menu leaks into the next one.
#
# macroengine:gui/in is deliberately NOT cleared here: api/open calls api/close in the middle of its own
# run (to close a previous menu) and still needs macroengine:gui/in {menu,page,timer} afterwards.
# The caller owns macroengine:gui/in (see internal/clear_in, called before every `data merge storage macroengine:gui_in`).
function macroengine:gui/internal/clear_w
function macroengine:gui/internal/clear_cond
function macroengine:gui/internal/clear_tmp
function macroengine:gui/internal/clear_mtr
