# dataEngine — Dispatch/Call
# Macro args: {command: string}
# Komutu bir sonraki tick'e kuyruğa ekler.
$data modify storage data_engine:private dispatch.queue append value "$(command)"
