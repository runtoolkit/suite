#> inv_gui:core/api/page_controls/_
#
# @within function inv_gui:api/page_controls

#>
# @private
#declare score_holder $PageCtrl.Prev
#declare score_holder $PageCtrl.Next

# Load has_prev and has_next into scores
execute store result score $PageCtrl.Prev inv_gui run data get storage inv_gui:data in.has_prev
execute store result score $PageCtrl.Next inv_gui run data get storage inv_gui:data in.has_next

# Copy full input into temp so macro can read filler_key alongside resolved keys
data modify storage inv_gui:temp PageCtrl set from storage inv_gui:data in

# Resolve actual_prev: filler if has_prev is false, otherwise prev_key
execute if score $PageCtrl.Prev inv_gui matches 0 run data modify storage inv_gui:temp PageCtrl.actual_prev set from storage inv_gui:data in.filler_key
execute if score $PageCtrl.Prev inv_gui matches 1 run data modify storage inv_gui:temp PageCtrl.actual_prev set from storage inv_gui:data in.prev_key

# Resolve actual_next: filler if has_next is false, otherwise next_key
execute if score $PageCtrl.Next inv_gui matches 0 run data modify storage inv_gui:temp PageCtrl.actual_next set from storage inv_gui:data in.filler_key
execute if score $PageCtrl.Next inv_gui matches 1 run data modify storage inv_gui:temp PageCtrl.actual_next set from storage inv_gui:data in.next_key

# Append navigation row via macro
function inv_gui:core/api/page_controls/row with storage inv_gui:temp PageCtrl

# Reset
scoreboard players reset $PageCtrl.Prev inv_gui
scoreboard players reset $PageCtrl.Next inv_gui
data remove storage inv_gui:temp PageCtrl
data remove storage inv_gui:data in.prev_key
data remove storage inv_gui:data in.next_key
data remove storage inv_gui:data in.filler_key
data remove storage inv_gui:data in.has_prev
data remove storage inv_gui:data in.has_next
