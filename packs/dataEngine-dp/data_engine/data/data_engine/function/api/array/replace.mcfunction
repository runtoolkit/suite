# dataEngine — API/Array/Replace
# Macro args: {type: string, target: string, nbt: string,
#              index: int, value: snbt}
$function data_api:command/modify_data/array/replace \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)", index: $(index), value: "$(value)"}
