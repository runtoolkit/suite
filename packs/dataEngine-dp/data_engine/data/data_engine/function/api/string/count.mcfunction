# dataEngine — API/String/Count
# Macro args: {type: string, target: string, nbt: string, chars: string}
# nbt path'teki string içinde chars'ın kaç kez geçtiğini sayar → nbt'ye yazar.
$function data_api:command/modify_data/string/count \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)", chars: "$(chars)"}
