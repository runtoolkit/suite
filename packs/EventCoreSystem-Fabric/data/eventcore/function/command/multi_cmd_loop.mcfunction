# Çoklu Komut Giriş Noktası
# cmd_queue doluysa multi_cmd_run'ı başlatır, bitince kuyruğu temizler.
# internal/dispatch tarafından cmd_queue doldurulduktan sonra çağrılır.
execute if data storage eventcore:sys cmd_queue[0] run function eventcore:command/multi_cmd_run
data remove storage eventcore:sys cmd_queue
