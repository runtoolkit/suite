# dataEngine — API/String/Normalize
# Macro args: {type: string, target: string, nbt: string}
# String veya array'i normalize eder (array ise join eder).
$function data_api:command/modify_data/string/normalize_string \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)"}
