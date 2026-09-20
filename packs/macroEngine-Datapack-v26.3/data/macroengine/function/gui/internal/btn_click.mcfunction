# macro: $(id)     as player, at player      (called by widget/button_probe)
# Definition keys (storage macroengine:gui_btn defs."<id>"):
#   cmd:"..."        command run `as @s at @s`. Use `function ns:name` for several commands.
#   url:"https://.." prints a clickable link in chat instead (use close:1b so the player can see chat)
#   cond:{...}       any macroengine:gui/cond type, see cond/check. Fails -> `deny` message, nothing runs
#   deny:"..."       message when cond fails (no double quotes). Default "Not available."
#   cost:{...}       {obj:"coins", amount:5} or {item:"minecraft:diamond", [count:3]}; charged after cond passes,
#                    before cmd/url. Not enough -> `poor` message, nothing runs, nothing is taken
#   poor:"..."       message when the cost cannot be paid (no double quotes). Default "You can't afford that."
#   close:1b         close the menu after the command
#   locked_item:"minecraft:barrier"   look when cond fails or the cost is not affordable (widget/button)
data remove storage macroengine:gui_btn cur
$data modify storage macroengine:gui_btn cur set from storage macroengine:gui_btn defs."$(id)"
execute unless data storage macroengine:gui_btn cur run return 0

function macroengine:gui/internal/btn_cond
execute if score #cond macroengine.gui_tmp matches 0 run return run function macroengine:gui/internal/btn_deny

# cost: charged only now (cond passed), before the command runs
scoreboard players set #paid macroengine.gui_tmp 1
execute if data storage macroengine:gui_btn cur.cost run function macroengine:gui/internal/btn_pay
execute if score #paid macroengine.gui_tmp matches 0 run return run function macroengine:gui/internal/btn_poor

# decide now: the command may overwrite macroengine:gui/btn cur (e.g. by running another button)
execute store success score #btn_close macroengine.gui_tmp if data storage macroengine:gui_btn cur{close:1b}
execute if data storage macroengine:gui_btn cur.cmd run function macroengine:gui/internal/btn_cmd with storage macroengine:gui_btn cur
execute if data storage macroengine:gui_btn cur.url run function macroengine:gui/internal/btn_url with storage macroengine:gui_btn cur
execute if score #btn_close macroengine.gui_tmp matches 1 if score @s macroengine.gui_uid matches 1.. run function macroengine:gui/api/close

# transient: nothing may leak into the next click
function macroengine:gui/internal/clear_btn_cur
