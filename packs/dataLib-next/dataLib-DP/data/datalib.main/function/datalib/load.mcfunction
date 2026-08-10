#> This function will run on datapack loading

execute if data storage datalib:engine {global:{loaded:1b}} run return 0

scoreboard objectives add dl.reload trigger
function #load:_private/load
