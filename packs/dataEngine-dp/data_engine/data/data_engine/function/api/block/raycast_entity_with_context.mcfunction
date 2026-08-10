# dataEngine — API/Block/RaycastEntityWithContext
# @s olarak çalıştırılmalı.
# Macro args: {command: string, distance: string, entity: string, context: string}
# data_api:command/raycast/on_entity_with_context tam wrapper.
$function data_api:command/raycast/on_entity_with_context \
    {command: "$(command)", distance: "$(distance)", \
     entity: "$(entity)", context: "$(context)"}
