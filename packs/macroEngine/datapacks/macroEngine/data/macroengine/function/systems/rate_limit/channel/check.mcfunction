# macroengine:systems/rate_limit/channel/check — Per-channel rate guard [MACRO]
#
# Prevents a tick channel's function from running too frequently even if
# the channel itself fires every tick. Place at the TOP of the channel function.
#
# Usage (inside your channel function):
# function macroengine:systems/rate_limit/channel/check {id:"my_channel"}
# execute if data storage macroengine:output {result:0b} run return 0
# # ... rest of channel logic
#
# Rule must be registered via:
# function macroengine:systems/rate_limit/channel/config {id:"my_channel",limit:5,window:20}
#
# Output → macroengine:output result 1b=ALLOWED 0b=DENIED

$function macroengine:systems/rate_limit/check {key:"channel:$(id)"}
