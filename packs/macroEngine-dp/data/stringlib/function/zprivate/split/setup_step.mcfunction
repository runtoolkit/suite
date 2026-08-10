execute unless data storage stringlib:output split[] run return 0
data modify storage stringlib:temp setup_buf prepend from storage stringlib:output split[0]
data remove storage stringlib:output split[0]
function stringlib:zprivate/split/setup_step
