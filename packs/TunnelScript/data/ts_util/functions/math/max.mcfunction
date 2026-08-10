# #out = max(#a, #b) on tunnelscript.vars.
scoreboard players operation #out tunnelscript.vars = #a tunnelscript.vars
execute if score #b tunnelscript.vars > #out tunnelscript.vars run scoreboard players operation #out tunnelscript.vars = #b tunnelscript.vars
