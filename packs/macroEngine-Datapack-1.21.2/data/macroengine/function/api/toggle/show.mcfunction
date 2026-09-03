# macroengine:api/toggle/show
# Prints a clickable module enable/disable menu.
#
# Usage:  function macroengine:api/toggle/show
# Caller: macroengine.admin tag required
#
# Each button runs:
#   /function macroengine:api/toggle/<Module>/<State>
#   where <State> is "true" (enable) or "false" (disable).
#
# Supported modules: hook, interaction, perm, wand, geo, cb
#
# BACKPORT NOTE (1.21.2): the original (26.x) opened this as a native
# `dialog show` screen with a free-text "Module Name" field and a boolean
# toggle, submitted via minecraft:dynamic/run_command templating. The
# dialog system does not exist in 1.21.2 (added in 1.21.6, pack format 80),
# and free-text input has no chat-command equivalent. Reimplemented as a
# fixed clickable menu — one Enable/Disable button pair per known module —
# which is functionally equivalent since the module list is fixed anyway.

execute unless entity @s[tag=macroengine.admin] run return 0

tellraw @s ["",{"text":"═══════ ","color":"dark_gray"},{"text":"macroEngine — Module Toggles","color":"aqua","bold":true},{"text":" ═══════","color":"dark_gray"}]
tellraw @s ["",{"text":"hook       ","color":"white"},{"text":"[ON] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/hook/true"}},{"text":"[OFF]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/hook/false"}}]
tellraw @s ["",{"text":"interaction","color":"white"},{"text":"[ON] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/interaction/true"}},{"text":"[OFF]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/interaction/false"}}]
tellraw @s ["",{"text":"perm       ","color":"white"},{"text":"[ON] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/perm/true"}},{"text":"[OFF]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/perm/false"}}]
tellraw @s ["",{"text":"wand       ","color":"white"},{"text":"[ON] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/wand/true"}},{"text":"[OFF]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/wand/false"}}]
tellraw @s ["",{"text":"geo        ","color":"white"},{"text":"[ON] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/geo/true"}},{"text":"[OFF]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/geo/false"}}]
tellraw @s ["",{"text":"cb         ","color":"white"},{"text":"[ON] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/cb/true"}},{"text":"[OFF]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/cb/false"}}]
tellraw @s ["",{"text":"› experimental flags","color":"yellow","italic":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/show"},"hoverEvent":{"action":"show_text","value":"Open the experimental feature-flag menu"}}]
