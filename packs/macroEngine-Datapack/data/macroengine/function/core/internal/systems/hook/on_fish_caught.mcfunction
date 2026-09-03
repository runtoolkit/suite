# macroengine:systems/hook/internal/on_fish_caught
# @s = the fishing player
scoreboard players add @s macroengine.hook_fish 1
advancement revoke @s only macroengine:systems/hook/fish_caught
