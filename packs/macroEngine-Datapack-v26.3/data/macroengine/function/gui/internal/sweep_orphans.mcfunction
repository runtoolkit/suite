# macroengine:gui :: internal/sweep_orphans      (run on load; also safe to run manually)
# A cart whose owner logged off / died / lost its uid would live forever. Mark every cart,
# unmark the ones that still have an owner with the same uid, dispose the rest.
tag @e[type=#macroengine:gui/container,tag=macroengine.gui_cart] add macroengine.gui_orphan
execute as @a[scores={macroengine.gui_uid=1..}] run function macroengine:gui/internal/sweep_keep
execute as @e[type=#macroengine:gui/container,tag=macroengine.gui_cart,tag=macroengine.gui_orphan] run function macroengine:gui/internal/dispose_cart
