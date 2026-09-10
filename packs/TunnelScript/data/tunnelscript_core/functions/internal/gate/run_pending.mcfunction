# Executes whichever action is recorded in the pending gate, then clears it.
# Called only from ts:gate/yes after the requester match has been verified.
execute if data storage tunnelscript:gate pending{action:"run_command"} run data modify storage tunnelscript:in command set from storage tunnelscript:gate pending.commands.command
execute if data storage tunnelscript:gate pending{action:"run_command"} run function tunnelscript_core:internal/do_run_command
execute if data storage tunnelscript:gate pending{action:"run_commands"} run data modify storage tunnelscript:in commands set from storage tunnelscript:gate pending.commands.commands
execute if data storage tunnelscript:gate pending{action:"run_commands"} run function tunnelscript_core:internal/do_run_commands
execute if data storage tunnelscript:gate pending{action:"batch_run"} run data modify storage tunnelscript:in slot set from storage tunnelscript:gate pending.commands.slot
execute if data storage tunnelscript:gate pending{action:"batch_run"} run function tunnelscript_core:internal/gate/exec_batch_run
execute if data storage tunnelscript:gate pending{action:"batch_delete"} run data modify storage tunnelscript:in slot set from storage tunnelscript:gate pending.commands.slot
execute if data storage tunnelscript:gate pending{action:"batch_delete"} run function tunnelscript_core:internal/gate/exec_batch_delete
execute if data storage tunnelscript:gate pending{action:"input_clear_history"} run data modify storage tunnelscript:minecart log set value []
execute if data storage tunnelscript:gate pending{action:"input_clear_history"} run tellraw @s [{"text":"[TunnelScript] Input history cleared.","color":"green"}]
execute if data storage tunnelscript:gate pending{action:"input_clear_queue"} run data modify storage tunnelscript:minecart queue set value []
execute if data storage tunnelscript:gate pending{action:"input_clear_queue"} run tellraw @s [{"text":"[TunnelScript] Input queue cleared","color":"green"}]
execute if data storage tunnelscript:gate pending{action:"input_reset_stats"} run scoreboard players set #input_captured tunnelscript.vars 0
execute if data storage tunnelscript:gate pending{action:"input_reset_stats"} run scoreboard players set #input_executed tunnelscript.vars 0
execute if data storage tunnelscript:gate pending{action:"input_reset_stats"} run tellraw @s [{"text":"[TunnelScript] Input stats reset.","color":"green"}]
execute if data storage tunnelscript:gate pending{action:"input_minecart_remove"} run kill @e[type=command_block_minecart,tag=tunnelscript_input]
execute if data storage tunnelscript:gate pending{action:"input_minecart_remove"} run tellraw @s [{"text":"[TunnelScript] All input minecarts removed.","color":"aqua"}]
execute if data storage tunnelscript:gate pending{action:"log_clear"} run data modify storage tunnelscript:log entries set value []
# # execute if data storage tunnelscript:gate pending{action:"log_clear"} run tellraw @s {"text":"[TunnelScript] command log cleared","color":"green"}
execute if data storage tunnelscript:gate pending{action:"dryrun_reset_count"} run scoreboard players set #dryrun_count tunnelscript.vars 0
execute if data storage tunnelscript:gate pending{action:"dryrun_reset_count"} run tellraw @s {"text":"[TunnelScript] dry-run counter reset","color":"green"}
data remove storage tunnelscript:gate pending
tag @a remove tunnelscript_gate_owner
