# dataEngine — API/Command/OnContainer
# Macro args: {type: string, target: string, start: int, stop: int, command: string}
# start..stop slot aralığındaki her slot için command çalışır.
$function data_api:command/run_command/on_container \
    {type: "$(type)", target: "$(target)", start: $(start), stop: $(stop), command: "$(command)"}
