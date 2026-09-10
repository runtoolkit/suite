# ─────────────────────────────────────────────
# macroengine:version
# ─────────────────────────────────────────────

# Pre-release version (pre >= 1)
# # execute if score #macroengine.pre macroengine.pre_version matches 1.. run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"v","color":"#ffaa00"},{"score":{"name":"#macroengine.major","objective":"macroengine.pre_version"},"color":"#ffaa00","bold":true},{"text":".","color":"#ffaa00"},{"score":{"name":"#macroengine.minor","objective":"macroengine.pre_version"},"color":"#ffaa00","bold":true},{"text":".","color":"#ffaa00"},{"score":{"name":"#macroengine.patch","objective":"macroengine.pre_version"},"color":"#ffaa00","bold":true},{"text":"-pre","color":"#ff8800"},{"score":{"name":"#macroengine.pre","objective":"macroengine.pre_version"},"color":"#ff8800","bold":true}]

# Full release version (pre <= 0)
# # execute if score #macroengine.pre macroengine.pre_version matches ..0 run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"v","color":"#ffaa00"},{"score":{"name":"#macroengine.major","objective":"macroengine.pre_version"},"color":"#ffaa00","bold":true},{"text":".","color":"#ffaa00"},{"score":{"name":"#macroengine.minor","objective":"macroengine.pre_version"},"color":"#ffaa00","bold":true},{"text":".","color":"#ffaa00"},{"score":{"name":"#macroengine.patch","objective":"macroengine.pre_version"},"color":"#ffaa00","bold":true}]
