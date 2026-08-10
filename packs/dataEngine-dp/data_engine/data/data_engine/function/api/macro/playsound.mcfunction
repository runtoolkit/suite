# dataEngine — API/Macro/Playsound
# Macro args: {sound_id: string, channel: string, target: string,
#              position: string, volume: float, pitch: float}
# data_api:command/macro/playsound tam wrapper.
$function data_api:command/macro/playsound \
    {sound_id: "$(sound_id)", channel: "$(channel)", target: "$(target)", \
     position: "$(position)", volume: $(volume), pitch: $(pitch)}
