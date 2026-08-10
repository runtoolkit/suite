# dataEngine — API/Color/Convert/GetValue
# Macro args: {type: string, target: string, nbt: string}
# Renk compound'undan (dec/hex/rgb/id) ham değeri çeker → data_api:private import.from
$function data_api:command/modify_data/color/get_color_value \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)"}
