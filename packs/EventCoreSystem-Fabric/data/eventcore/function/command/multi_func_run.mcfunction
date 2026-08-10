# func_queue[0]'ı alır, çalıştırır, kaldırır; kuyrukta eleman kaldıysa tekrar çağırır.
# Desteklenen formatlar:
#   {ns:"namespace",path:"fonksiyon/yolu"}
#   {ns:"namespace",path:"fonksiyon/yolu",args:{key:value,...}}
data modify storage eventcore:sys current_func set from storage eventcore:sys func_queue[0]
data remove storage eventcore:sys func_queue[0]
execute if data storage eventcore:sys current_func.args run function eventcore:command/function_args with storage eventcore:sys current_func
execute unless data storage eventcore:sys current_func.args run function eventcore:command/function with storage eventcore:sys current_func
data remove storage eventcore:sys current_func
execute if data storage eventcore:sys func_queue[0] run function eventcore:command/multi_func_run
