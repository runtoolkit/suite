# dataEngine — API/Color/Convert/NormalizeRgb
# Macro args: {type: string, target: string, nbt: string}
# {r,g,b} değerlerini 0-255 aralığına normalize eder.
$function data_api:command/modify_data/color/normalize_rgb \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)"}
