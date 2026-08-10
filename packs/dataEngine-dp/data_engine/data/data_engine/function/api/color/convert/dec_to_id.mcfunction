# dataEngine — API/Color/Convert/DecToId
# Macro args: {type: string, target: string, nbt: string}
# Decimal renk değerini Minecraft renk id'sine dönüştürür ("red", "blue" vb.).
$function data_api:command/modify_data/color/dec_to_id \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)"}
