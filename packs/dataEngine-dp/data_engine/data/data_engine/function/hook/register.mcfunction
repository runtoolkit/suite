# dataEngine — Hook/Register
# Macro args: {id: string, function: string}
# hooks.<id> listesine fonksiyon ekler.
$data modify storage data_engine:private hooks.$(id) append value "$(function)"
