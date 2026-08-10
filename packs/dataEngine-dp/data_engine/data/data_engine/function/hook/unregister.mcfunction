# dataEngine — Hook/Unregister
# Macro args: {id: string, function: string}
# hooks.<id> listesinden belirtilen fonksiyonu siler.
$data remove storage data_engine:private hooks.$(id)[{id: "$(function)"}]
