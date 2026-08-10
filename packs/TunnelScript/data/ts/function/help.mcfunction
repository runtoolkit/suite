# Print a short overview of the public API.
tellraw @s {"text":"TunnelScript - public API","color":"aqua","bold":true}
tellraw @s {"text":"ts:run            -> process { actions:[...] } from storage tunnelscript:in","color":"gray"}
tellraw @s {"text":"ts:run_command    -> { command|cmd|func }","color":"gray"}
tellraw @s {"text":"ts:run_commands   -> { commands:[...] }","color":"gray"}
tellraw @s {"text":"ts:run_function   -> { func, type, val }","color":"gray"}
tellraw @s {"text":"ts:run_functions  -> { functions:[...] }","color":"gray"}
tellraw @s {"text":"ts:multi/<command>-> { values:[...] }","color":"gray"}
tellraw @s {"text":"ts:run_if         -> { if, actions:[...] }   (1.0.4)","color":"gray"}
tellraw @s {"text":"ts:run_as         -> { selector, actions:[...] } (1.0.4)","color":"gray"}
tellraw @s {"text":"ts:run_after      -> { delay, actions:[...] }  (1.0.4)","color":"gray"}
tellraw @s {"text":"ts:config/*       -> set_cooldown, set_max_actions, get, reset","color":"gray"}
tellraw @s {"text":"ts:menu           -> open sidebar menu  (ts:menu/close to hide)","color":"gray"}
tellraw @s {"text":"ts:hologram/*     -> spawn, remove, set_name (in-world marker label)","color":"gray"}
tellraw @s {"text":"ts_util:*         -> math, entity, text, data, time helpers (1.0.4)","color":"gray"}
tellraw @s {"text":"/trigger tunnelScript.use set <n>  -> run option directly","color":"gray"}
tellraw @s {"text":"/trigger tunnelScript.menu set <n> -> run option from the open menu","color":"gray"}
tellraw @s {"text":"   1 version, 2 help, 3 run, 4 run_command, 5 run_commands,","color":"gray"}
tellraw @s {"text":"   6 run_function, 7 run_functions, 8 config/get, 9 config/reset","color":"gray"}
