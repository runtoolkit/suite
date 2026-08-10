# Çoklu Fonksiyon Giriş Noktası
# func_queue doluysa multi_func_run'ı başlatır, bitince kuyruğu temizler.
# internal/dispatch tarafından func_queue doldurulduktan sonra çağrılır.
execute if data storage eventcore:sys func_queue[0] run function eventcore:command/multi_func_run
data remove storage eventcore:sys func_queue
