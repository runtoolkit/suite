# dataEngine — API/Data/NormalizeRange
# Macro args: {type: string, target: string, nbt: string}
# nbt path'teki ["min","max"] veya {min,max} veya "min..max" formatındaki
# aralık değerini standart {min: int, max: int} compound'a normalize eder.
$function data_api:command/modify_data/number/normalize_range \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)"}
