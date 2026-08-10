# dataEngine — API/Math/Add
# Macro args: {type: string, target: string, nbt: string, value: int}
# data_api number/add: storage/entity/block path'teki sayıya value ekler.
$function data_api:command/modify_data/number/add \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)", value: $(value)}
