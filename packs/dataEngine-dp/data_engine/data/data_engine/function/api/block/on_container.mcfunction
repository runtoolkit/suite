# dataEngine — API/Block/OnContainer
# Macro args: {target: string, start: int, stop: int, command: string}
# Blok container slotları üzerinde döngü.
$function data_api:command/run_command/on_container \
    {type: "block", target: "$(target)", start: $(start), stop: $(stop), command: "$(command)"}
