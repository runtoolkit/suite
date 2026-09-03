data remove storage macroengine:core/internal/string/temp data.StringList[-1]
data modify storage macroengine:core/internal/string/temp data.S2 set from storage macroengine:core/internal/string/temp data.StringList[-1]
data remove storage macroengine:core/internal/string/temp data.StringList[-1]
data modify storage macroengine:core/internal/string/temp data.S3 set from storage macroengine:core/internal/string/temp data.StringList[-1]
function macroengine:core/internal/string/zprivate/concat/s/2c with storage macroengine:core/internal/string/temp data
