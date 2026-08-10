data modify block 0 -66 0 auto set value 0b
setblock 0 -66 0 minecraft:air replace

forceload remove 0 0

data remove storage cmd_tunnel_sys:input temp.cmd
