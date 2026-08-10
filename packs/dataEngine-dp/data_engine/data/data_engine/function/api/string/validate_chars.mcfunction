# dataEngine — API/String/ValidateChars
# Macro args: {type: string, target: string, nbt: string, chars: [...]}
# Yalnızca izin verilen karakterleri içerip içermediğini doğrular.
# data_api:private validate_chars.pass → true/false
$function data_api:command/modify_data/string/validate_chars \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)", chars: $(chars)}
