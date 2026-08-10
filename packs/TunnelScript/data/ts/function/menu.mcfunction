# Open the TunnelScript sidebar menu. No tellraw / chat spam is used; the menu
# lives in the sidebar display slot. Pick an option with:
#   /trigger tunnelScript.menu set <n>
# Close it again with: function ts:menu/close
# Build the menu UI only the first time it is opened (idempotent thereafter).
execute unless score #menu_built tunnelscript.vars matches 1 run function tunnelscript_core:internal/menu_build
execute unless score #menu_built tunnelscript.vars matches 1 run scoreboard players set #menu_built tunnelscript.vars 1
# Tag this player as "menu open" so the menu trigger is enabled for them only.
# ts:menu/close removes the tag and disables the trigger again.
tag @s add tsMenuOpen
scoreboard players enable @s tunnelScript.menu
scoreboard objectives setdisplay sidebar tunnelscript.menu_ui
