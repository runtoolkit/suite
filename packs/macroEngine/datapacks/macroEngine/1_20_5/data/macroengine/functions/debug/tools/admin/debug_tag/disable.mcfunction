# macroengine:debug/tools/admin/debug_tag/disable
# Turns auto_debug_tag OFF: admins no longer get macroengine.debug
# automatically. Also strips macroengine.debug from every currently
# tagged admin so the effect is immediate, not just "stops granting
# new ones" — otherwise tags handed out by prior ticks would silently
# linger until manually removed, which defeats the point of disabling
# this.
#
# Use macroengine:debug/tools/admin/debug_tag/grant / revoke to manage
# macroengine.debug per-player once this is disabled.

data modify storage macroengine:engine security.auto_debug_tag set value 0b
tag @a[tag=macroengine.admin] remove macroengine.debug
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"auto_debug_tag ","color":"white"},{"text":"disabled","color":"yellow"},{"text":" — macroengine.debug removed from all admins. Use debug_tag/grant to assign it manually.","color":"gray"}]
