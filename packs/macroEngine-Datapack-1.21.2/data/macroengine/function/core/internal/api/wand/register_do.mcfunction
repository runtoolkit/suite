# macroengine:api/wand/internal/register_do [MACRO] [INTERNAL]
# Called by wand/register with storage macroengine:input {} to do the actual append.
# INPUT: $(tag), $(func), $(cmd)
$data modify storage macroengine:engine wand_binds append value {tag:"$(tag)", func:"$(func)", cmd:"$(cmd)"}
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"wand/register ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(tag)","color":"white"}]
