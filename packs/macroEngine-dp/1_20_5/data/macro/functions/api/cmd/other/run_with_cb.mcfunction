# Add forceload
forceload add 0 0
summon minecraft:marker 0 -64 0 {Tags:[".macrolessCommandSys"]}

# Execute command from storage using marker + command block
execute if entity @e[tag=.macrolessCommandSys,type=minecraft:marker,limit=1] at @e[tag=.macrolessCommandSys,type=minecraft:marker,limit=1] run setblock 0 -64 0 minecraft:command_block{Command:"",auto:0b,TrackOutput:0b} replace
execute if entity @e[tag=.macrolessCommandSys,type=minecraft:marker,limit=1] at @e[tag=.macrolessCommandSys,type=minecraft:marker,limit=1] run data modify block 0 -64 0 Command set from storage macro:input cmd
execute if entity @e[tag=.macrolessCommandSys,type=minecraft:marker,limit=1] at @e[tag=.macrolessCommandSys,type=minecraft:marker,limit=1] run data modify block 0 -64 0 auto set value 1b

execute if entity @e[tag=.macrolessCommandSys,type=minecraft:marker,limit=1] at @e[tag=.macrolessCommandSys,type=minecraft:marker,limit=1] run tellraw @a[tag=macro.debug,tag=macro.admin] {"block":"0 -64 0","nbt":"LastOutput","interpret":true}

kill @e[tag=.macrolessCommandSys,type=minecraft:marker]

execute unless entity @e[tag=.macrolessCommandSys,type=minecraft:marker,limit=1] at @e[tag=.macrolessCommandSys,type=minecraft:marker,limit=1] run data modify block 0 -64 0 auto set value 0b
execute unless entity @e[tag=.macrolessCommandSys,type=minecraft:marker,limit=1] at @e[tag=.macrolessCommandSys,type=minecraft:marker,limit=1] run setblock 0 -64 0 minecraft:air replace

data remove storage macro:input cmd