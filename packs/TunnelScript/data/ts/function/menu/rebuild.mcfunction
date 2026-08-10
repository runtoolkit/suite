# Rebuild and re-open the menu (useful after changing language/labels).
function tunnelscript_core:internal/menu_build
scoreboard players set #menu_built tunnelscript.vars 1
scoreboard objectives setdisplay sidebar tunnelscript.menu_ui
