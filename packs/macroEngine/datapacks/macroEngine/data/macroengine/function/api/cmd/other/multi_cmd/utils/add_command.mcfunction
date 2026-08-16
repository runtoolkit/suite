# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/other/multi_cmd/utils/add_command
# Add a command to queue at runtime
#
# INPUT (storage macroengine:input):
# cmd or func → command/function to add
# ─────────────────────────────────────────────────────────────────

execute if data storage macroengine:input cmd run data modify storage macroengine:engine _mcmd_queue append value {}
execute if data storage macroengine:input cmd run data modify storage macroengine:engine _mcmd_queue[-1].cmd set from storage macroengine:input cmd

execute if data storage macroengine:input func run data modify storage macroengine:engine _mcmd_queue append value {}
execute if data storage macroengine:input func run data modify storage macroengine:engine _mcmd_queue[-1].func set from storage macroengine:input func

tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/utils/add ","color":"aqua"},{"text":"✔ added to queue","color":"green"}]
