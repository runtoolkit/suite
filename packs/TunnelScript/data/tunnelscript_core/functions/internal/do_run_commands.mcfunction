# Copy the list and start the shared bounded command-list iterator.
data modify storage tunnelscript_core:work clist set from storage tunnelscript:in commands
function tunnelscript_core:internal/command_list_start
