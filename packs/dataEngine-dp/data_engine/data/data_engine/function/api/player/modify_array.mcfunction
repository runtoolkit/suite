# dataEngine — API/Player/ModifyArray
# @s olarak çalıştırılmalı.
# data_engine:private player_modify_args storage'a koy:
#   {path: string,       ← player NBT path (e.g. "active_effects")
#    context0: string,   ← ekleme komutu template
#    context1: string,   ← silme komutu template
#    give: string,       ← ekleme makro komutu
#    remove: string}     ← silme makro komutu
# data_api:command/modify_data/player/modify_array tam wrapper.
function data_api:command/modify_data/player/modify_array \
    with storage data_engine:private player_modify_args
