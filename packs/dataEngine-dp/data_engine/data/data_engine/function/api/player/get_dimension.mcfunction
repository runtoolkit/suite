# dataEngine — API/Player/GetDimension
# @s olarak çalıştırılmalı.
# Sonuç: data_api:private player_data.store.Dimension (e.g. "minecraft:overworld")
execute store result storage data_api:private player_data.store.Dimension int 1 run data get entity @s Dimension
