# TunnelScript 1.0.4 - bootstrap
# Runs once on (re)load. Registers the shared objective and seeds the default
# configuration only when a value has never been set, so user changes survive
# reloads.
scoreboard objectives add tunnelscript.vars dummy
# Public trigger objectives. Players bind actions with:
#   /trigger tunnelScript.use  set <n>   -> run a ts: function directly
#   /trigger tunnelScript.menu set <n>   -> run option <n> from the sidebar menu
scoreboard objectives add tunnelScript.use trigger
scoreboard objectives add tunnelScript.menu trigger
execute unless score #max_actions tunnelscript.vars = #max_actions tunnelscript.vars run scoreboard players set #max_actions tunnelscript.vars 256
execute unless score #cooldown_max tunnelscript.vars = #cooldown_max tunnelscript.vars run scoreboard players set #cooldown_max tunnelscript.vars 0
execute unless score #last_run tunnelscript.vars = #last_run tunnelscript.vars run scoreboard players set #last_run tunnelscript.vars -2000000000
scoreboard players set #neg_one tunnelscript.vars -1
# The sidebar menu is built lazily on first "function ts:menu" -- nothing is
# created or displayed on load, so reloads stay silent.
# Publish version + config to storage so other packs can read it.
data modify storage tunnelscript:meta version set value "1.0.4"
data modify storage tunnelscript:meta target set value "Minecraft 1.21.1"
