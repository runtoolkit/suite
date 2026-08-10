# Dil değiştirir ve hata mesajlarını günceller. Kullanım: {locale:"tr"} veya {locale:"en"}
$data modify storage eventcore:config locale set value "$(locale)"
execute if data storage eventcore:config {locale:"tr"} run data modify storage eventcore:config messages set value {err_no_type:"Event tipi belirtilmedi!",err_version:"Sürüm uyumsuzluğu. /reload yapın.",err_empty:"args ve events boş!",err_queue_limit:"events[] limiti aşıldı!",err_prefix:"[EventCore]"}
execute if data storage eventcore:config {locale:"en"} run data modify storage eventcore:config messages set value {err_no_type:"Event type not specified!",err_version:"Version mismatch. Run /reload.",err_empty:"args and events are empty!",err_queue_limit:"events[] limit exceeded!",err_prefix:"[EventCore]"}
