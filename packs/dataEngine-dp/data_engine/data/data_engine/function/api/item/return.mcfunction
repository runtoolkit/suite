# dataEngine — API/Item/Return
# Macro args: {type: string, target: string, path: string, slot: string}
# Slot'taki itemi 6 blok içindeki en yakın oyuncuya item entity olarak atar.
# data_api:command/return_item tam wrapper.
$function data_api:command/return_item \
    {type: "$(type)", target: "$(target)", path: "$(path)", slot: "$(slot)"}
