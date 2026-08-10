# Tick hook. Public trigger + minecart input scanner + queue processor.
# No replay of user action lists; the queue only runs captured minecart input.
scoreboard players enable @a tunnelScript.use
execute as @a[scores={tunnelScript.use=1..}] run function tunnelscript_core:internal/trigger_dispatch
execute unless score #input_paused tunnelscript.vars matches 1.. run function tunnelscript_core:internal/minecart_scan
execute unless score #input_paused tunnelscript.vars matches 1.. run function tunnelscript_core:internal/minecart_queue_process
function tunnelscript_core:internal/link/init
function tunnelscript_core:internal/gate/timeout_check
kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:minecart",tag:{display:{Name:'{"text":"@"}'}}}}]
