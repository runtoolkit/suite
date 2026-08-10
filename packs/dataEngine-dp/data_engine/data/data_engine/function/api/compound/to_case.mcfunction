# dataEngine — API/Compound/ToCase
# Macro args: {type: string, target: string, nbt: string, case: "upper"|"lower"}
# Compound'daki string değerleri belirtilen case'e çevirir.
# data_api:command/modify_data/compound/to_case tam wrapper.
$function data_api:command/modify_data/compound/to_case \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)", case: "$(case)"}
