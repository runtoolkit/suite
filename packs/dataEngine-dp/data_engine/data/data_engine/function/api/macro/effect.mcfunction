# dataEngine — API/Macro/Effect
# Macro args: {id: string, amplifier: int, duration: string|int,
#              show_particles: bool, target: string}
# data_api:command/macro/effect tam wrapper — effect give komutu üretir.
$function data_api:command/macro/effect \
    {id: "$(id)", amplifier: $(amplifier), duration: "$(duration)", \
     show_particles: $(show_particles), target: "$(target)"}
