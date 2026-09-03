# ─────────────────────────────────────────────────────────────────
# macroengine:debug/dump_cooldowns
# Dumps all active cooldown records to screen.
# Usage: /function macroengine:debug/dump_cooldowns
# ─────────────────────────────────────────────────────────────────

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━ Cooldown Dump ","color":"aqua"},{"text":"━━━━━━━━━━━━━━━━━━","color":"#555555"}]
tellraw @s ["",{"text":" ","color":"#555555"},{"text":"engine.cooldowns","color":"white"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:engine","nbt":"cooldowns","color":"yellow","italic":false}]
tellraw @s ["",{"text":" ","color":"#555555"},{"text":"epoch now: ","color":"gray"},{"score":{"name":"$epoch","objective":"macroengine.time"},"color":"aqua"}]
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]