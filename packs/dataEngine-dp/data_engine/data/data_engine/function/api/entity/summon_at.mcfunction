# dataEngine — API/Entity/SummonAt
# Macro args: {type: string, position: string, nbt: compound, init_function: string}
# Belirtilen konuma entity spawn eder.
# global:private summon storage'ına yazar, sonra data_api summon/main çağırır.
$data modify storage global:private summon.output set value \
    {type: "$(type)", position: "$(position)", nbt: {}, Tags: ["private.de.init"]}
$data modify storage global:private summon.output.nbt merge value $(nbt)
$data modify storage global:private summon.output.init set value "$(init_function)"
scoreboard players set *count private.global.summon 1
scoreboard players set *summoned private.global.summon 0
function data_api:command/summon/main
