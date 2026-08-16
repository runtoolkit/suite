# macroengine:debug/tools/admin/debug_tag/grant
# Manually grants macroengine.debug to a single player, regardless of the
# auto_debug_tag setting. Intended for use once auto_debug_tag is 0b —
# grants made while it's 1b have no visible effect since the tick
# system re-adds the tag to every admin anyway.
# Usage: /function macroengine:debug/tools/admin/debug_tag/grant {target:"PlayerName"}

$tag @a[name=$(target),limit=1] add macroengine.debug
$tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"$(target)","color":"white"},{"text":" granted macroengine.debug.","color":"green"}]
