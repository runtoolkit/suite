# dataEngine — API/Data/Get
# Macro args: {type: string, target: string, nbt: string}
# Sonuç: data_api:private import.from
$data modify storage data_api:private import.from set from $(type) $(target) $(nbt)
