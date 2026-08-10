# macro:systems/hook/internal/on_eat
# @s = yiyen oyuncu
scoreboard players add @s macro.hook_eat 1
advancement revoke @s only macro:systems/hook/eat_food
