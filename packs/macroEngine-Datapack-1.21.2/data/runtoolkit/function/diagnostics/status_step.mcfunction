# runtoolkit:diagnostics/status_step
# Internal recursive walker for diagnostics/status. For each registered
# subsystem, reads its live "#runtoolkit.packs.<name>.version" score
# (0 = disabled/not loaded, matches core/internal/disable/apply.mcfunction's
# convention) and prints one status line. Reads runtoolkit:tmp _walk[0]
# and pops it.
#
# NOTE: deliberately does not depend on macroengine_string (StringLib) —
# runtoolkit sits above individual subsystems and should not require any
# one subsystem's internal libraries to function. The scoreboard holder
# name is built directly via macro substitution instead of string concat.

execute unless data storage runtoolkit:tmp _walk[0] run return 0

data modify storage runtoolkit:tmp _diag_call set from storage runtoolkit:tmp _walk[0]
function runtoolkit:diagnostics/status_line with storage runtoolkit:tmp _diag_call

data remove storage runtoolkit:tmp _walk[0]
function runtoolkit:diagnostics/status_step
