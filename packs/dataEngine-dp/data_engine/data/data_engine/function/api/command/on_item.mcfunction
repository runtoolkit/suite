# dataEngine — API/Command/OnItem
# Macro args: {type: string, target: string, slot: string, command: string}
# data_api:command/run_command/on_item tam wrapper.
$function data_api:command/run_command/on_item \
    {type: "$(type)", target: "$(target)", slot: "$(slot)", command: "$(command)"}
