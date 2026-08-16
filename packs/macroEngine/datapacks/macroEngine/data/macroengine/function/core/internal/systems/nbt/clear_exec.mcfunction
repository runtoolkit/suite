# macroengine:systems/nbt/internal/clear_exec [MACRO]
# INPUT: $(storage), $(path)

$data remove storage $(storage) $(path)

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"nbt/clear ","color":"aqua"},{"text":"$(storage):$(path)","color":"white"}]
