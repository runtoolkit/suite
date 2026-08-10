# Execute one queued minecart input per tick through the shared command-block runner.
execute if data storage tunnelscript:minecart queue[0] run function tunnelscript_core:internal/minecart_queue_step
