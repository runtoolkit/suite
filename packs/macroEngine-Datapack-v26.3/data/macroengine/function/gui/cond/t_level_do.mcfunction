# macro: $(min) $(max)
# `experience query` returns the level count; store it in a temp score, then compare with two
# open-ended ranges (never a closed A..B).
execute store result score #lvl macroengine.gui_tmp run experience query @s levels
scoreboard players set #cond macroengine.gui_tmp 1
$execute unless score #lvl macroengine.gui_tmp matches $(min).. run scoreboard players set #cond macroengine.gui_tmp 0
$execute unless score #lvl macroengine.gui_tmp matches ..$(max) run scoreboard players set #cond macroengine.gui_tmp 0
