
execute if score @s player_action.fly matches 1.. run tag @s add player_action.flying
execute if score @s player_action.walk matches 1.. run tag @s add player_action.walking
execute if score @s player_action.fall matches 1.. run tag @s add player_action.falling
execute if score @s player_action.climb matches 1.. run tag @s add player_action.climbing
execute if score @s player_action.aviate matches 1.. run tag @s add player_action.elyra_flying

execute if predicate macroengine:core/internal/player/swimming run tag @s add player_action.swimming
execute if predicate macroengine:core/internal/player/sneaking run tag @s add player_action.sneaking
execute if predicate macroengine:core/internal/player/sprinting run tag @s add player_action.sprinting
execute if predicate macroengine:core/internal/player/riding_pig run tag @s add player_action.riding_pig
execute if predicate macroengine:core/internal/player/riding_boat run tag @s add player_action.riding_boat
execute if predicate macroengine:core/internal/player/riding_mule run tag @s add player_action.riding_mule
execute if predicate macroengine:core/internal/player/riding_llama run tag @s add player_action.riding_llama
execute if predicate macroengine:core/internal/player/riding_horse run tag @s add player_action.riding_horse
execute if predicate macroengine:core/internal/player/riding_donkey run tag @s add player_action.riding_donkey
execute if predicate macroengine:core/internal/player/riding_strider run tag @s add player_action.riding_strider
execute if predicate macroengine:core/internal/player/riding_minecart run tag @s add player_action.riding_minecart

execute if score @s player_action.death matches 1.. run function #macroengine:core/internal/player/died
execute if score @s player_action.enchant matches 1.. run function #macroengine:core/internal/player/enchanted
execute if score @s player_action.jump matches 1.. run function #macroengine:core/internal/player/jumped
execute if score @s player_action.use_coas matches 1.. run function #macroengine:core/internal/player/right_click
execute if score @s player_action.use_wfoas matches 1.. run function #macroengine:core/internal/player/right_click

execute if score @s player_action.join matches 1.. run function #macroengine:core/internal/player/joined
execute unless score @s player_action.join matches 0.. run function #macroengine:core/internal/player/joined
execute unless score @s player_action.join matches 0.. run scoreboard players add @s player_action.join 0
