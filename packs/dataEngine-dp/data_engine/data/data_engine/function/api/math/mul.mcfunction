# dataEngine — API/Math/Mul
# Macro args: {type: string, target: string, nbt: string, value: float}
# data_api multiply: execute store ile scale yapar (int output).
$function data_api:command/modify_data/number/multiply \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)", value: $(value)}
