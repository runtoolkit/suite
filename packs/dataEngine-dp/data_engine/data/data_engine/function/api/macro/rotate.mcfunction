# dataEngine — API/Macro/Rotate
# Macro args: {target: string, location: string}
# location: "yaw pitch" formatında string.
# data_api:command/macro/rotate tam wrapper.
$function data_api:command/macro/rotate \
    {target: "$(target)", location: "$(location)"}
