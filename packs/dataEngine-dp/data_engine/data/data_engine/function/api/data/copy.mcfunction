# dataEngine — API/Data/Copy
# Macro args: {type: string, target: string, nbt: string,
#              dst_type: string, dst_target: string, dst_nbt: string}
$data modify $(dst_type) $(dst_target) $(dst_nbt) set from $(type) $(target) $(nbt)
