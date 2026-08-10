# dataEngine — API/Block/RaycastEntity
# @s olarak çalıştırılmalı.
# Macro args: {command: string, distance: string, entity: string}
# Bakılan entity üzerinde komut çalıştırır.
$function data_api:command/raycast/on_entity \
    {command: "$(command)", distance: "$(distance)", entity: "$(entity)"}
