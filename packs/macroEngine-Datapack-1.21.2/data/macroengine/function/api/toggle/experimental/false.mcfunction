# macroengine:api/toggle/experimental/false [MACRO] — Disable one experimental flag
# Called by the experimental flags menu, or directly:
#   function macroengine:api/toggle/experimental/false {flag:"hologram"}
# Caller: macroengine.admin tag required

execute unless entity @s[tag=macroengine.admin] run return 0

$function macroengine:systems/flag/experimental/set {flag:"$(flag)",value:"0b"}

$tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"experimental/","color":"gray"},{"text":"$(flag)","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"disabled","color":"red"}]
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"toggle/experimental ","color":"aqua"},{"text":"$(flag)","color":"white"},{"text":" → ","color":"#555555"},{"text":"false","color":"red"}]
