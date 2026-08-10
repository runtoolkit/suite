# dataEngine — API/Data/Type
# Macro args: {type: string, target: string, nbt: string}
# Veri tipini tespit eder ve nbt path'e yazar.
# Sonuç: ["string"] | ["number"] | ["array"] | ["compound"] | ["boolean"] | ["unknown"]
# data_api:command/modify_data/return tam wrapper.
$function data_api:command/modify_data/return \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)"}
