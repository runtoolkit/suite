# macroengine:core/internal/cmd/data_remove_storage_apply
# The actual storage-removal logic, run either directly (gates off) or
# after gate confirmation (gates on, the default).
$data remove storage $(storage) $(path)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/data_remove_storage ","color":"aqua"},{"text":"$(storage) → $(path)","color":"#555555"}]
