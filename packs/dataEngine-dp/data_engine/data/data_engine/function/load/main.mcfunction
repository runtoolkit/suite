# dataEngine — Load/Main
# Macro args: {version: int, update: int}

# Storages
data remove storage data_engine:private hooks
data remove storage data_engine:private dispatch.queue
data modify storage data_engine:private dispatch.queue set value []
data modify storage data_engine:public engine set value {ready: 1b}

# Objectives
scoreboard objectives add de_flags dummy
scoreboard objectives add de_tick dummy

# Version
$scoreboard players set *de_version data_engine $(version)
$scoreboard players set *de_update data_engine $(update)
