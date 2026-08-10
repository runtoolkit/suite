# Internal macro: schedule the deferred runner after the given delay.
# This uses /schedule for a single future run; it never reschedules itself.
$schedule function tunnelscript_core:internal/run_deferred $(delay)
