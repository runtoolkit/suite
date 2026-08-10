# Scan tagged command-block minecarts. Non-empty Command values are captured.
execute as @e[type=command_block_minecart,tag=tunnelscript_input] run function tunnelscript_core:internal/minecart_process
