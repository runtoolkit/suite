# macro:systems/hook/on_item_use
# Reward: item_use advancement (using_item trigger)
advancement revoke @s only macro:systems/hook/item_use
scoreboard players add @s macro.hook_item_used 1
