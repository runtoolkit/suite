# dataEngine — API/Player/GetPos
# @s olarak çalıştırılmalı. Pozisyon bilgisini data_api:private player_data.store.Pos'a yazar.
# Ardından player/pos fn'i tp ile uygular.
data modify storage data_api:private player_data.store.Pos set value [0.0d, 0.0d, 0.0d]
execute store result storage data_api:private player_data.store.Pos[0] double 1 run data get entity @s Pos[0]
execute store result storage data_api:private player_data.store.Pos[1] double 1 run data get entity @s Pos[1]
execute store result storage data_api:private player_data.store.Pos[2] double 1 run data get entity @s Pos[2]
