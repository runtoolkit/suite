# dataEngine — API/Macro/Spawnpoint
# Macro args: {target: string, dimension: string, location: string}
# location: "x y z yaw pitch" formatında string.
# data_api:command/macro/spawnpoint tam wrapper.
$function data_api:command/macro/spawnpoint \
    {target: "$(target)", dimension: "$(dimension)", location: "$(location)"}
