# Detect click by checking if the item exists in that slot
$execute unless data entity @e[type=chest_minecart,tag=$(id),limit=1,sort=nearest,distance=..3] Items[{Slot:$(slot)b,id:"$(item)",tag:$(data)}] run $(invoke)

# Optional: Restore the item in the slot after click (prevents item disappearing)
$item replace entity @e[type=chest_minecart,tag=$(id),limit=1,sort=nearest] container.$(slot) with $(item)$(data) $(count)

# Clear the item from player's cursor (important for 1.20.3)
$clear @s $(item)$(data) $(count)
