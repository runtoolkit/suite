# macroengine:systems/hook/on_entity_kill
# Reward: entity_kill advancement (player_killed_entity trigger)
advancement revoke @s only macroengine:systems/hook/entity_kill
scoreboard players add @s macroengine.hook_entity_killed 1
