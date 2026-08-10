# dataEngine — Dispatch/Delay
# Macro args: {command: string, delay: string}
# data_api:public delay.commands listesine ekler (data_api delay engine kullanır).
$data modify storage data_api:public delay.commands append value "$(command)"
$schedule function data_api:delay $(delay) append
