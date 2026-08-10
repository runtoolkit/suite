# dataEngine — Load
# Bağımlılık: data_api 1.10.3
# https://modrinth.com/datapack/data_api/version/1.10.3

scoreboard objectives add data_engine dummy

execute unless score *de_update data_engine matches 1 \
    run function data_engine:load/main {version: 1, update: 1}
execute if score *de_update data_engine matches 1 \
    run tellraw @a[tag=data_engine.admin] \
        {"color":"green","text":"[dataEngine] v1 loaded"}
