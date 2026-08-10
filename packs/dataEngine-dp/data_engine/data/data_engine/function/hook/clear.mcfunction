# dataEngine — Hook/Clear
# Macro args: {id: string}
# hooks.<id> listesinin tamamını temizler.
$data remove storage data_engine:private hooks.$(id)
