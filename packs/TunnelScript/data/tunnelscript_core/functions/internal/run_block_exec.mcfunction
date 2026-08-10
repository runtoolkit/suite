# Place, arm and pulse the command block, then schedule its cleanup.
# Position 0 -64 0 is forceloaded for the brief moment it is needed.
forceload add 0 0
setblock 0 -64 0 minecraft:air replace
setblock 0 -64 0 minecraft:command_block{auto:0b,TrackOutput:0b} replace
data modify block 0 -64 0 Command set from storage tunnelscript:in cmd
data modify block 0 -64 0 auto set value 1b
schedule function tunnelscript_core:internal/run_block_cleanup 3t replace
execute if score #log_enabled tunnelscript.vars matches 1.. run function tunnelscript_core:internal/log_append
