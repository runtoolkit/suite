# macroengine:systems/hook/on_break_block
# Reward: break_block advancement (item_durability_changed, delta max -1)
# Feeds both break_block and using_item hooks.
advancement revoke @s only macroengine:systems/hook/break_block
scoreboard players add @s macroengine.hook_tool_used 1
scoreboard players add @s macroengine.hook_using_item 1
