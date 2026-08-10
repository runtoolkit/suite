# Hide the sidebar menu (clears the sidebar display slot) and disable the menu
# trigger for this player (tag removed -> trigger off, per the tick gate).
tag @s remove tsMenuOpen
scoreboard players reset @s tunnelScript.menu
scoreboard objectives setdisplay sidebar
