# dataEngine — API/Player/GetRotation
# @s olarak çalıştırılmalı.
execute store result storage data_api:private player_data.store.Rotation[0] float 1 run data get entity @s Rotation[0]
execute store result storage data_api:private player_data.store.Rotation[1] float 1 run data get entity @s Rotation[1]
