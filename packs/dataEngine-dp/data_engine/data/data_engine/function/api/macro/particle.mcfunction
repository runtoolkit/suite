# dataEngine — API/Macro/Particle
# Macro args: {particle: string, count: int, delta: string,
#              speed: float, position: string, target: string}
# data_api:command/macro/particle tam wrapper.
$function data_api:command/macro/particle \
    {particle: "$(particle)", count: $(count), delta: "$(delta)", \
     speed: $(speed), position: "$(position)", target: "$(target)"}
