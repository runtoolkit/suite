# dataEngine — API/Item/DropAll
# Macro args: {type: string, target: string, nbt: string}
# nbt path'teki item listesinin tamamını düşürür, listeyi temizler.
# data_api:command/drop_items tam wrapper.
$function data_api:command/drop_items \
    {type: "$(type)", target: "$(target)", nbt: "$(nbt)"}
