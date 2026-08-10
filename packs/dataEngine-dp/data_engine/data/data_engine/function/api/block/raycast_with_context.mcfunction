# dataEngine — API/Block/RaycastWithContext
# @s olarak çalıştırılmalı.
# Macro args: {command: string, distance: string, context: string}
# context: entity tag string (e.g. "#mypack:raycast")
# data_api:command/raycast/on_block_with_context tam wrapper.
$function data_api:command/raycast/on_block_with_context \
    {command: "$(command)", distance: "$(distance)", context: "$(context)"}
