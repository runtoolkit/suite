# dataEngine — Dispatch/Tick (internal loop)
# queue[0]'ı "dispatch.current" key'ine kopyala
data modify storage data_engine:private dispatch.command \
    set from storage data_engine:private dispatch.queue[0]
data remove storage data_engine:private dispatch.queue[0]

# data_api:command/macro/_ imzası: storage {command: string}
# dispatch.command = string, macro/_ {command: "$(command)"} ile çağır
function data_api:command/macro/_ with storage data_engine:private dispatch

# Sıradakini işle
execute if data storage data_engine:private dispatch.queue[0] \
    run function data_engine:dispatch/tick
