# dataEngine — API/Array/RunCommands
# Macro args: {type: string, target: string, nbt: string}
# nbt path'teki komut string listesini data_api run_command/from_array ile çalıştırır.
$data modify storage data_engine:private cmd_run.commands \
    set from $(type) $(target) $(nbt)
execute if data storage data_engine:private cmd_run.commands[0] \
    run function data_api:command/run_command/from_array \
        with storage data_engine:private cmd_run
