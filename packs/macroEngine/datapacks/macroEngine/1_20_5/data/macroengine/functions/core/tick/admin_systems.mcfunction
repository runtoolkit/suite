# Auto-grant macroengine.debug to admins — configurable via
# macroengine:engine security.auto_debug_tag (default 1b, legacy behavior).
# Set to 0b to require explicit debug-tag management instead:
# /function macroengine:debug/tools/admin/debug_tag/enable
# /function macroengine:debug/tools/admin/debug_tag/disable
execute if data storage macroengine:engine security{auto_debug_tag:1b} run tag @a[tag=macroengine.admin] add macroengine.debug

scoreboard players enable @a[tag=macroengine.admin] macroengine_menu
scoreboard players enable @a[tag=macroengine.admin] macroengine_action
scoreboard players enable @a[tag=macroengine.admin] macroengine_run
function macroengine:core/internal/systems/geo/region_watch/tick_scan
