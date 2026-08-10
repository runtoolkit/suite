# dataEngine — API/String/Split
# Macro args: {type: string, target: string, nbt: string, chars: string}
# Sonuç: nbt path'ine string listesi olarak yazılır.
$function data_api:command/modify_data/string/split \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)", chars: "$(chars)"}
