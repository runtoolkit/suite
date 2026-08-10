# dataEngine — API/Macro/Experience
# Macro args: {action: "add"|"set", amount: int, type: "levels"|"points", target: string}
# data_api:command/macro/experience tam wrapper.
$function data_api:command/macro/experience \
    {action: "$(action)", amount: $(amount), type: "$(type)", target: "$(target)"}
