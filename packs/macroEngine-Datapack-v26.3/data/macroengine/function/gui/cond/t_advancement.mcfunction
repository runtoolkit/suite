# macro: $(adv)
$execute if entity @s[advancements={$(adv)=true}] run scoreboard players set #cond macroengine.gui_tmp 1
