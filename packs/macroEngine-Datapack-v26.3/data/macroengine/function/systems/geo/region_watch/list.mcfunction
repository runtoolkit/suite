# ─────────────────────────────────────────────────────────────────
# macroengine:systems/geo/region_watch/list
# Shows all registered regions to debug players.
# ─────────────────────────────────────────────────────────────────

tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━ Region Watches ━━━━━━━━━━━━━━","color":"aqua"}]
execute if data storage macroengine:engine region_watches run tellraw @a[tag=macroengine.debug] ["",{"text":" ","color":"#555555"},{"plain":true ,"storage":"macroengine:engine","nbt":"region_watches","interpret":false,"color":"yellow"}]
execute unless data storage macroengine:engine region_watches run tellraw @a[tag=macroengine.debug] ["",{"text":" (no regions registered)","color":"gray","italic":true}]
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
