# Direct named-parameter API for /particle.
# Parameter order: particle, pos, delta, speed, count, mode, viewers
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/particle
data remove storage rtwrapper:runtime current.params
