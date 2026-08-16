$execute unless data storage macroengine:engine players.$(player) run data modify storage macroengine:engine players.$(player) set value {}
$execute unless data storage macroengine:engine players.$(player).coins run data modify storage macroengine:engine players.$(player).coins set value 0
$execute unless data storage macroengine:engine players.$(player).level run data modify storage macroengine:engine players.$(player).level set value 1
$execute unless data storage macroengine:engine players.$(player).xp run data modify storage macroengine:engine players.$(player).xp set value 0
$data modify storage macroengine:engine players.$(player).online set value 1b
$execute unless data storage macroengine:engine players.$(player).first_join_tick run execute store result storage macroengine:engine players.$(player).first_join_tick int 1 run scoreboard players get $epoch macroengine.time
$execute store result storage macroengine:engine players.$(player).last_join_tick int 1 run scoreboard players get $epoch macroengine.time
$execute unless data storage macroengine:engine player_pids.$(player) run function macroengine:core/internal/player/assign_pid with storage macroengine:engine _pid_init_tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"player/init ","color":"aqua"},{"text":"$(player)","color":"white"}]