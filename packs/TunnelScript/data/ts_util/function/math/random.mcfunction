# #out = a random integer in [#min, #max] on tunnelscript.vars.
execute store result score #out tunnelscript.vars run random value 0..2147483646
scoreboard players operation #span tunnelscript.vars = #max tunnelscript.vars
scoreboard players operation #span tunnelscript.vars -= #min tunnelscript.vars
scoreboard players add #span tunnelscript.vars 1
scoreboard players operation #out tunnelscript.vars %= #span tunnelscript.vars
scoreboard players operation #out tunnelscript.vars += #min tunnelscript.vars
