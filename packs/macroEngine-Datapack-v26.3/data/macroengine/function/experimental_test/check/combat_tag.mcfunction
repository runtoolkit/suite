# macroengine:experimental_test/check/combat_tag [INTERNAL]
# Verifies the combat_tag tick logic applies the tag + timer when the
# exp_dmg_dealt stat looks like it just incremented, without needing
# an actual PvP hit.

data modify storage macroengine:engine flags.experimental.combat_tag set value 1b
tag @s remove macroengine.experimental.combat_tagged
scoreboard players set @s macroengine.exp_dmg_dealt 1

function macroengine:experimental/combat_tag/tick
execute unless entity @s[tag=macroengine.experimental.combat_tagged] run function macroengine:experimental_test/signal {result:"fail"}
execute unless score @s macroengine.exp_combat_timer matches 300 run function macroengine:experimental_test/signal {result:"fail"}
execute if entity @s[tag=macroengine.experimental.combat_tagged] if score @s macroengine.exp_combat_timer matches 300 run function macroengine:experimental_test/signal {result:"accept"}

tag @s remove macroengine.experimental.combat_tagged
tag @s remove macroengine.experimental._combat_notified
scoreboard players set @s macroengine.exp_combat_timer 0
data modify storage macroengine:engine flags.experimental.combat_tag set value 0b
