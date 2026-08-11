# Direct named-parameter API for /weather.
# Parameter order: weather, duration
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/weather
data remove storage rtwrapper:runtime current.params
