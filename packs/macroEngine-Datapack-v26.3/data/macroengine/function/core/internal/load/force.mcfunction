# macroengine:core/internal/load/force
# Force reload: applies immediately (no confirmation gate). Discards live
# engine state (global.loaded and everything load/all's "unless data"
# guards would otherwise preserve).

function macroengine:core/internal/load/force_apply
