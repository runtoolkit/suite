$data modify storage macroengine:engine schedules.$(key).func set value "$(func)"
$data modify storage macroengine:engine schedules.$(key).interval set value $(interval)
$data modify storage macroengine:engine schedules.$(key).player set value "$(player)"
$data modify storage macroengine:engine queue append value {func:"$(func)", delay:$(interval), player:"$(player)"}
