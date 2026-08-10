# Clamp #in into [#min, #max] (objective tunnelscript.vars); result in #out.
scoreboard players operation #out tunnelscript.vars = #in tunnelscript.vars
execute if score #out tunnelscript.vars < #min tunnelscript.vars run scoreboard players operation #out tunnelscript.vars = #min tunnelscript.vars
execute if score #out tunnelscript.vars > #max tunnelscript.vars run scoreboard players operation #out tunnelscript.vars = #max tunnelscript.vars
