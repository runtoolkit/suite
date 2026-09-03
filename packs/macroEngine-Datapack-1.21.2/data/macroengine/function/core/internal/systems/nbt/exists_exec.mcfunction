# macroengine:systems/nbt/internal/exists_exec [MACRO]
# INPUT: $(storage), $(path)

data modify storage macroengine:output result set value 0b
$execute if data storage $(storage) $(path) run data modify storage macroengine:output result set value 1b

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"nbt/exists ","color":"aqua"},{"text":"$(storage):$(path)","color":"white"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
