# dataEngine — API/Compound/ToString
# Macro args: {type: string, target: string, nbt: string}
# Compound NBT'yi SNBT string'e serialize eder.
# data_api:command/modify_data/compound/to_string tam wrapper.
$function data_api:command/modify_data/compound/to_string \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)"}
