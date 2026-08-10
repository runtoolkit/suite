# dataEngine — API/Data/Set
# Macro args: {type: string, target: string, nbt: string, value: snbt}
# Herhangi bir storage/entity/block path'ine değer yazar.
$data modify $(type) $(target) $(nbt) set value $(value)
