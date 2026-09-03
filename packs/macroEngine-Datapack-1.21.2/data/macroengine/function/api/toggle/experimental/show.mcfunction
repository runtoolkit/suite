# macroengine:api/toggle/experimental/show
# Prints a clickable experimental-flag enable/disable menu.
#
# Usage:  function macroengine:api/toggle/experimental/show
# Caller: macroengine.admin tag required
#
# Each button runs:
#   /function macroengine:api/toggle/experimental/<true|false> {flag:"<name>"}
#
# Flags:
#   strict_gating   — enables core/internal/security/check_all enforcement
#                      (cmd_min_level / sandbox_cmd_min_level / admin_min_level).
#                      Turn this OFF immediately if permission checks start
#                      blocking things that should work — every threshold
#                      defaults to 0 (everyone passes) so it's safe to leave
#                      on, but it's the flag that previously caused problems
#                      and got removed, so it ships OFF by default.
#   hologram        — experimental/hologram/* (floating text display entities)
#   particle_trail  — experimental/particle_trail/* (player movement trails)
#   crafting_ui     — experimental/crafting_ui/* (custom crafting menu)
#   waypoint        — experimental/waypoint/* (set/track/compass waypoints)
#   combat_tag      — experimental/combat_tag/* (temporary PvP-tag on hit)
#   scoreboard_hud  — experimental/scoreboard_hud/* (sidebar HUD toggle)
#
# BACKPORT NOTE (1.21.2): same constraint as api/toggle/show.mcfunction —
# no `dialog show` (added 1.21.6 / pack format 80) available here, so this
# is a fixed clickable tellraw menu, not a native dialog screen.

execute unless entity @s[tag=macroengine.admin] run return 0

tellraw @s ["",{"text":"═══════ ","color":"dark_gray"},{"text":"macroEngine — Experimental Flags","color":"aqua","bold":true},{"text":" ═══════","color":"dark_gray"}]
tellraw @s ["",{"text":"strict_gating  ","color":"white"},{"text":"[ON] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/true {flag:\"strict_gating\"}"}},{"text":"[OFF]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/false {flag:\"strict_gating\"}"}}]
tellraw @s ["",{"text":"hologram       ","color":"white"},{"text":"[ON] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/true {flag:\"hologram\"}"}},{"text":"[OFF]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/false {flag:\"hologram\"}"}}]
tellraw @s ["",{"text":"particle_trail ","color":"white"},{"text":"[ON] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/true {flag:\"particle_trail\"}"}},{"text":"[OFF]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/false {flag:\"particle_trail\"}"}}]
tellraw @s ["",{"text":"crafting_ui    ","color":"white"},{"text":"[ON] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/true {flag:\"crafting_ui\"}"}},{"text":"[OFF]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/false {flag:\"crafting_ui\"}"}}]
tellraw @s ["",{"text":"waypoint       ","color":"white"},{"text":"[ON] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/true {flag:\"waypoint\"}"}},{"text":"[OFF]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/false {flag:\"waypoint\"}"}}]
tellraw @s ["",{"text":"combat_tag     ","color":"white"},{"text":"[ON] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/true {flag:\"combat_tag\"}"}},{"text":"[OFF]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/false {flag:\"combat_tag\"}"}}]
tellraw @s ["",{"text":"scoreboard_hud ","color":"white"},{"text":"[ON] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/true {flag:\"scoreboard_hud\"}"}},{"text":"[OFF]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:api/toggle/experimental/false {flag:\"scoreboard_hud\"}"}}]
tellraw @s ["",{"text":"═════════════════════════════════════════","color":"dark_gray"}]
