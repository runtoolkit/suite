# ─────────────────────────────────────────────────────────────────
# macroengine:debug/dump_events
# Lists all registered event handlers.
# Usage: /function macroengine:debug/dump_events
# ─────────────────────────────────────────────────────────────────

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━ Event Registry ","color":"aqua"},{"text":"━━━━━━━━━━━━━━━━","color":"#555555"}]
tellraw @s ["",{"text":" ","color":"#555555"},{"text":"engine.events","color":"white"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:engine","nbt":"events","color":"light_purple","italic":false}]
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]