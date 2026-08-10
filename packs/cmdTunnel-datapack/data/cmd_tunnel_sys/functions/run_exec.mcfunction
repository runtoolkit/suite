# Add forceload
forceload add 0 0

# Execute command from storage using marker + command block
setblock 0 -66 0 minecraft:command_block{Command:"",auto:0b,TrackOutput:0b} replace
data modify block 0 -66 0 Command set from storage cmd_tunnel_sys:input temp.cmd
data modify block 0 -66 0 auto set value 1b

schedule function cmd_tunnel_sys:reset 2t replace
