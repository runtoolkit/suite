# macroengine:core/internal/load/main — load entry
# Initial load runs unblocked — must not stall server startup. Reload
# data-loss is only a soft warning here; force-reload
# (macroengine:core/internal/load/force) applies immediately, no confirmation
# gate (that gate system has been removed).

function macroengine:config

# Archive banner (score-controlled)
execute if score #runtoolkit.archivedpacks.macroengine macroengine.meta matches 1 run tellraw @s {"text":"[macroengine] This pack is marked archived (#runtoolkit.archivedpacks.macroengine=1).","color":"red"}

# Already loaded → data-loss prevention notice (NOT a hard gate; does not block)
execute if data storage macroengine:engine global{loaded:1b} if data storage macroengine:engine config{reload_warn:1b} run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Reload: engine already loaded. Live storage kept. To force full re-init (discards live state): ","color":"yellow"},{"text":"/function macroengine:core/internal/load/force","color":"aqua","underlined":true,"click_event":{"action":"run_command","command":"/function macroengine:core/internal/load/force"}}]

execute if data storage macroengine:engine global{loaded:1b} run return 0

schedule function macroengine:core/internal/load/all 2s
