# dataEngine — API/Math/Restrict
# Macro args: {type: string, target: string, nbt: string, range: string}
# range formatı: "min..max" örn. "0..100"
$function data_api:command/modify_data/number/restrict \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)", range: "$(range)"}
