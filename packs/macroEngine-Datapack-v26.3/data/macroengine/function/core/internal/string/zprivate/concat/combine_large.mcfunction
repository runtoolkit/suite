# Combine up to 100 strings at once (Size=100 adds 100 to the current result, so it's 101 afterwards)
$function macroengine:core/internal/string/zprivate/concat/s/$(Size)

# Next loop
execute if score #StringLib.ConcatsLeft StringLib matches 1 run return 0
scoreboard players remove #StringLib.ConcatsLeft StringLib 1
execute if score #StringLib.ConcatsLeft StringLib matches 1 store result storage macroengine:core/internal/string/temp data.Size byte 1 run scoreboard players get #StringLib.StringsTotal StringLib
execute if score #StringLib.ConcatsLeft StringLib matches 2.. run data modify storage macroengine:core/internal/string/temp data.Size set value 100b
function macroengine:core/internal/string/zprivate/concat/combine_large with storage macroengine:core/internal/string/temp data
