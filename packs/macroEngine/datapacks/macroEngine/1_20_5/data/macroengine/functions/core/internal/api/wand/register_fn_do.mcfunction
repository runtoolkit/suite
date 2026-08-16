# macroengine:api/wand/internal/register_fn_do [MACRO] [INTERNAL]
# Called by wand/register_fn with storage macroengine:input {} to do the actual append.
# INPUT: $(tag), $(func)
$data modify storage macroengine:engine wand_binds append value {tag:"$(tag)", func:"$(func)"}
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"wand/register_fn ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(tag)","color":"white"},{"text":" → func","color":"#555555"}]
