# dataEngine — API/Block/RaycastBoth
# @s olarak çalıştırılmalı.
# Macro args: {command: string, distance: string, entity: string}
# Bakılan blok veya entity üzerinde komut çalıştırır (hangisi önce gelirse).
# data_api:command/raycast/on_block_and_entity tam wrapper.
$function data_api:command/raycast/on_block_and_entity \
    {command: "$(command)", distance: "$(distance)", entity: "$(entity)"}
