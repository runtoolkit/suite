#> inv_gui:core/handler/on_select/get_changed_slot/loop
# @within function inv_gui:core/handler/on_select/get_changed_slot
# @within function inv_gui:core/handler/on_select/get_changed_slot/loop

# Write current slot number to storage (for macro)
execute store result storage inv_gui:temp _gcs_slot int 1 run scoreboard players get $_gcs inv_gui

# Check slot (macro)
function inv_gui:core/handler/on_select/get_changed_slot/check with storage inv_gui:temp
data remove storage inv_gui:temp _gcs_slot

# Item not found & slots remaining -> Move to next slot
scoreboard players add $_gcs inv_gui 1
execute unless data storage inv_gui:temp Item if score $_gcs inv_gui matches 0..26 run function inv_gui:core/handler/on_select/get_changed_slot/loop
