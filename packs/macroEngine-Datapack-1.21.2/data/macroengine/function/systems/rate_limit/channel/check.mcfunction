# macroengine:systems/rate_limit/channel/check — Per-tick-system rate guard [MACRO]
#
# Prevents a tick system's function (e.g. core/tick/admin_systems) from
# running too frequently even if the dispatcher calls it every tick.
# Place at the TOP of the target function.
#
# Usage (inside your tick system function):
# function macroengine:systems/rate_limit/channel/check {id:"my_system"}
# execute if data storage macroengine:output {result:0b} run return 0
# # ... rest of the system's logic
#
# Rule must be registered via:
# function macroengine:systems/rate_limit/config {key:"channel:my_system",limit:5,window:20}
#
# Output → macroengine:output result 1b=ALLOWED 0b=DENIED

$function macroengine:systems/rate_limit/check {key:"channel:$(id)"}
