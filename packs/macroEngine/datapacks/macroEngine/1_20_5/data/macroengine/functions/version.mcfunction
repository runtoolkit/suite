# ─────────────────────────────────────────────
# macroengine:version
# Shows macroengine version info to the calling player.
# Usage: /function macroengine:version
# ─────────────────────────────────────────────
execute unless score #macroengine.ver_set macroengine.pre_version matches 1 run return run tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"Status ","color":"gray"},{"text":"✖ not initialized","color":"red"}]

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━ Version Info ","color":"aqua"},{"text":"━━━━━━━━━━━━━━","color":"#555555"}]

tellraw @s ["",{"text":" ◈ ","color":"#00AAAA"},{"text":"macroengine","color":"white","bold":true}]

execute if score #macroengine.pre macroengine.pre_version matches 1.. run tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"Version ","color":"gray"},{"text":"v","color":"#ffaa00"},{"score":{"name":"#macroengine.major","objective":"macroengine.pre_version"},"color":"#ffaa00","bold":true},{"text":".","color":"#ffaa00"},{"score":{"name":"#macroengine.minor","objective":"macroengine.pre_version"},"color":"#ffaa00","bold":true},{"text":".","color":"#ffaa00"},{"score":{"name":"#macroengine.patch","objective":"macroengine.pre_version"},"color":"#ffaa00","bold":true},{"text":"-pre","color":"#ff8800"},{"score":{"name":"#macroengine.pre","objective":"macroengine.pre_version"},"color":"#ff8800","bold":true}]
execute if score #macroengine.pre macroengine.pre_version matches ..0 run tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"Version ","color":"gray"},{"text":"v","color":"#ffaa00"},{"score":{"name":"#macroengine.major","objective":"macroengine.pre_version"},"color":"#ffaa00","bold":true},{"text":".","color":"#ffaa00"},{"score":{"name":"#macroengine.minor","objective":"macroengine.pre_version"},"color":"#ffaa00","bold":true},{"text":".","color":"#ffaa00"},{"score":{"name":"#macroengine.patch","objective":"macroengine.pre_version"},"color":"#ffaa00","bold":true}]

tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"MC ","color":"gray"},{"text":"26.2","color":"#e3ff57"},{"text":" (pack_format 107)","color":"#555555"}]
tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"Author ","color":"gray"},{"text":"Legends11","color":"#00ff33","clickEvent":{"action":"open_url","value":"https://github.com/tickwarden"}},{"text":" / ","color":"#555555"},{"text":"runtoolkit","color":"aqua","underlined":true,"clickEvent":{"action":"open_url","value":"https://github.com/runtoolkit"}}]

tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"Source ","color":"gray"},{"text":"github.com/runtoolkit/macroEngine","color":"#5555ff","underlined":true,"click_event":{"action":"open_url","url":"https://github.com/runtoolkit/macroengine-dp"}}]
# Check if loaded
execute if score #macroengine.ver_set macroengine.pre_version matches 1 run tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"Status ","color":"gray"},{"text":"● loaded","color":"green"}]
execute unless score #macroengine.ver_set macroengine.pre_version matches 1 run tellraw @s ["",{"text":" ┃ ","color":"#555555"},{"text":"Status ","color":"gray"},{"text":"✖ not initialized","color":"red"}]

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
