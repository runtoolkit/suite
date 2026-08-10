# dataEngine — API/String/Unpack
# Macro args: {type: string, target: string, nbt: string}
# Bir string içindeki escape edilmiş SNBT'yi compound'a dönüştürür.
# data_api:command/modify_data/string/unpack tam wrapper.
$function data_api:command/modify_data/string/unpack \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)"}
