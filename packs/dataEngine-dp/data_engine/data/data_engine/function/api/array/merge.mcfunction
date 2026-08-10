# dataEngine — API/Array/Merge
# Macro args: {type: string, target: string, nbt: string,
#              value: [...], action: "append"|"prepend"}
# value listesini mevcut listeye birleştirir.
$function data_api:command/modify_data/array/merge \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)", value: $(value), action: "$(action)"}
