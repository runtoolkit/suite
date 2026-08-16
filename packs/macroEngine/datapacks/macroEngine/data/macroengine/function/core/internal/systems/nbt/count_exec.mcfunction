# macroengine:systems/nbt/internal/count_exec [MACRO]
# INPUT: $(storage), $(path)

scoreboard players set $nbt_count macroengine.tmp 0
$execute store result score $nbt_count macroengine.tmp run data get storage $(storage) $(path)

execute store result storage macroengine:output result int 1 run scoreboard players get $nbt_count macroengine.tmp

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"nbt/count ","color":"aqua"},{"text":"$(storage):$(path)","color":"white"},{"text":" → ","color":"#555555"},{"score":{"name":"$nbt_count","objective":"macroengine.tmp"},"color":"green"}]
