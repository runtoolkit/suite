# repeat_run tarafından başlatılır. Her iterasyonda dispatch çalıştırır.
execute if data storage eventcore:sys args.type run function eventcore:internal/dispatch
scoreboard players remove #ec_repeat ec.sys 1
execute if score #ec_repeat ec.sys matches 1.. run function eventcore:trigger/repeat_loop
