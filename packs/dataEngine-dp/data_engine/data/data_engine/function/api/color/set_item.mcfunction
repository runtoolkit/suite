# dataEngine — API/Color/SetItem
# Macro args: {type: string, target: string, slot: string, value: string|int}
# data_api:command/set_color tam wrapper.
# value: renk adı ("red"), hex ("#FF0000") veya decimal (16711680).
$function data_api:command/set_color \
    {type: "$(type)", target: "$(target)", slot: "$(slot)", value: "$(value)"}
