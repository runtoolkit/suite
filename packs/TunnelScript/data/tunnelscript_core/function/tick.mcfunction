# Tick hook. The ONLY per-tick work is event detection for the public triggers:
# tunnelScript.use and tunnelScript.menu. This never re-runs queued actions on
# its own, it only reacts to a player explicitly pulling a trigger. There is no
# looping/repeating of action lists anywhere.
scoreboard players enable @a tunnelScript.use
# The menu trigger is only usable while the menu is open (tag tsMenuOpen).
# Players without the tag have it disabled, so "tag yes -> on, tag no -> off".
scoreboard players enable @a[tag=tsMenuOpen] tunnelScript.menu
scoreboard players reset @a[tag=!tsMenuOpen] tunnelScript.menu
execute as @a[scores={tunnelScript.use=1..}] run function tunnelscript_core:internal/trigger_dispatch
execute as @a[tag=tsMenuOpen,scores={tunnelScript.menu=1..}] run function tunnelscript_core:internal/menu_dispatch
