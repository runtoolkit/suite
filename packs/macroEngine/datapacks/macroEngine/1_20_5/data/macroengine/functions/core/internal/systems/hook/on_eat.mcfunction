# macroengine:systems/hook/internal/on_eat
# @s = the eating player
scoreboard players add @s macroengine.hook_eat 1
advancement revoke @s only macroengine:systems/hook/eat_food
