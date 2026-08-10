#> inv_gui:core/api/register_chest_minecart/encode_bit
# @macro
# @within function inv_gui:core/api/register_chest_minecart/encode_loop
#
# Determine bit value by sign (positive/negative) of $TempIndex,
# Set inv_gui.Filter.$(_rbit)-{0|1} tag

$execute if score $TempIndex inv_gui matches 0.. run tag @s add inv_gui.Filter.$(_rbit)-0
$execute if score $TempIndex inv_gui matches ..-1 run tag @s add inv_gui.Filter.$(_rbit)-1
