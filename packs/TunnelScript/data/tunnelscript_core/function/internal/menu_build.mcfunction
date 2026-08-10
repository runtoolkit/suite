# (Re)build the sidebar menu objective and its lines. This is internal and
# is only invoked on demand by ts:menu / ts:menu/rebuild -- it never runs on
# load, so reloads stay silent. Removing and re-adding the objective clears
# any stale lines from a previous version. This does NOT display the menu.
scoreboard objectives remove tunnelscript.menu_ui
scoreboard objectives add tunnelscript.menu_ui dummy {"text":"TunnelScript","color":"aqua","bold":true}
scoreboard objectives modify tunnelscript.menu_ui numberformat blank
scoreboard players set ts.l1 tunnelscript.menu_ui 15
scoreboard players display name ts.l1 tunnelscript.menu_ui [{"text":"[1] ","color":"yellow"},{"text":"version","color":"white"}]
scoreboard players set ts.l2 tunnelscript.menu_ui 14
scoreboard players display name ts.l2 tunnelscript.menu_ui [{"text":"[2] ","color":"yellow"},{"text":"help","color":"white"}]
scoreboard players set ts.l3 tunnelscript.menu_ui 13
scoreboard players display name ts.l3 tunnelscript.menu_ui [{"text":"[3] ","color":"yellow"},{"text":"run (actions)","color":"white"}]
scoreboard players set ts.l4 tunnelscript.menu_ui 12
scoreboard players display name ts.l4 tunnelscript.menu_ui [{"text":"[4] ","color":"yellow"},{"text":"run_command","color":"white"}]
scoreboard players set ts.l5 tunnelscript.menu_ui 11
scoreboard players display name ts.l5 tunnelscript.menu_ui [{"text":"[5] ","color":"yellow"},{"text":"run_commands","color":"white"}]
scoreboard players set ts.l6 tunnelscript.menu_ui 10
scoreboard players display name ts.l6 tunnelscript.menu_ui [{"text":"[6] ","color":"yellow"},{"text":"run_function","color":"white"}]
scoreboard players set ts.l7 tunnelscript.menu_ui 9
scoreboard players display name ts.l7 tunnelscript.menu_ui [{"text":"[7] ","color":"yellow"},{"text":"run_functions","color":"white"}]
scoreboard players set ts.l8 tunnelscript.menu_ui 8
scoreboard players display name ts.l8 tunnelscript.menu_ui [{"text":"[8] ","color":"yellow"},{"text":"config: show","color":"white"}]
scoreboard players set ts.l9 tunnelscript.menu_ui 7
scoreboard players display name ts.l9 tunnelscript.menu_ui [{"text":"[9] ","color":"yellow"},{"text":"config: reset","color":"white"}]
scoreboard players set ts.l10 tunnelscript.menu_ui 6
scoreboard players display name ts.l10 tunnelscript.menu_ui [{"text":"[10] ","color":"yellow"},{"text":"run_if","color":"white"}]
scoreboard players set ts.l11 tunnelscript.menu_ui 5
scoreboard players display name ts.l11 tunnelscript.menu_ui [{"text":"[11] ","color":"yellow"},{"text":"run_as","color":"white"}]
scoreboard players set ts.l12 tunnelscript.menu_ui 4
scoreboard players display name ts.l12 tunnelscript.menu_ui [{"text":"[12] ","color":"yellow"},{"text":"run_after","color":"white"}]
scoreboard players set ts.l13 tunnelscript.menu_ui 3
scoreboard players display name ts.l13 tunnelscript.menu_ui {"text":"--------------------","color":"dark_gray","strikethrough":true}
scoreboard players set ts.l14 tunnelscript.menu_ui 2
scoreboard players display name ts.l14 tunnelscript.menu_ui {"text":"select: /trigger tunnelScript.menu set N","color":"gray"}
scoreboard players set ts.l15 tunnelscript.menu_ui 1
scoreboard players display name ts.l15 tunnelscript.menu_ui {"text":"close: function ts:menu/close","color":"gray"}
