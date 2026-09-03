
$execute as @a[name=$(player),limit=1] at @s run effect clear @s $(effect)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/effect_clear_one ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(effect)","color":"aqua"}]
