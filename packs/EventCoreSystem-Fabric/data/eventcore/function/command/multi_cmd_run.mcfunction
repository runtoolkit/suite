# cmd_queue[0]'ı alır, çalıştırır, kaldırır; kuyrukta eleman kaldıysa tekrar çağırır.
# current_cmd storage key'i her iterasyonda temizlenir — iç içe çakışma olmaz.
data modify storage eventcore:sys current_cmd.cmd set from storage eventcore:sys cmd_queue[0]
data remove storage eventcore:sys cmd_queue[0]
function eventcore:command/run_one with storage eventcore:sys current_cmd
data remove storage eventcore:sys current_cmd
execute if data storage eventcore:sys cmd_queue[0] run function eventcore:command/multi_cmd_run
