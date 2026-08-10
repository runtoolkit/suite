# Reverse stringlib:output split for negative-n direction splits.
# Forward splits (n >= 0) are already in correct order — no-op.
execute if score #StringLib.FindAmount StringLib matches 0.. run return 0

# reversed/main appended segments right-to-left; reverse the list back.
data modify storage stringlib:temp setup_buf set value []
function stringlib:zprivate/split/setup_step
data modify storage stringlib:output split set from storage stringlib:temp setup_buf
data remove storage stringlib:temp setup_buf
