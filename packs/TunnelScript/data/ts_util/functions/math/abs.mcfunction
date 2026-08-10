# #out = |#in| on tunnelscript.vars.
scoreboard players operation #out tunnelscript.vars = #in tunnelscript.vars
execute if score #out tunnelscript.vars matches ..-1 run scoreboard players operation #out tunnelscript.vars *= #neg_one tunnelscript.vars
