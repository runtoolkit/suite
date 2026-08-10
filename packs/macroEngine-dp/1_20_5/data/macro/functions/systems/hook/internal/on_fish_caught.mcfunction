# macro:systems/hook/internal/on_fish_caught
# @s = the fishing player
scoreboard players add @s macro.hook_fish 1
advancement revoke @s only macro:systems/hook/fish_caught
