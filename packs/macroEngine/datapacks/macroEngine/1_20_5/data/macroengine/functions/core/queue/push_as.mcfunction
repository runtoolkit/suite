# macroengine:core/queue/push_as
# Appends a function to the work queue, tagged to execute AS a specific player.
# The player must be online when the item is processed; if offline, it is skipped.
#
# Input (macroengine:input queue):
# fn — function path e.g. "mypack:process_player"
# player — player name or UUID e.g. "<player name>"
#
# Usage:
# data modify storage macroengine:input queue set value {fn:"mypack:process_player",player:"<player name>"}
# function macroengine:core/queue/push_as with storage macroengine:input queue

$data modify storage macroengine:engine work_queue append value {fn:"$(fn)",player:"$(player)"}
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"queue/push_as ","color":"aqua"},{"text":"→ ","color":"#555555"},{"text":"$(fn)","color":"white"},{"text":" as ","color":"#555555"},{"text":"$(player)","color":"#FFAA00"}]
