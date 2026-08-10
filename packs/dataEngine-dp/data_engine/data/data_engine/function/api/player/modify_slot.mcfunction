# dataEngine — API/Player/ModifySlot
# @s olarak çalıştırılmalı.
# Macro args: {path: string, slot: string}
# data_api:private player_data.store.<path> = yeni item compound olmalı.
$function data_api:command/modify_data/player/modify_slot \
    {path: "$(path)", slot: "$(slot)"}
