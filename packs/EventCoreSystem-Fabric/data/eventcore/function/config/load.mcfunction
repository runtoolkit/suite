# EventCore Config Yükleyici
# Sadece eksik olan bloklara default değer yazar — var olanların üstüne yazmaz.
# Versiyon her zaman üstüne yazılır — kullanıcı tarafından değiştirilemez.
data modify storage eventcore:config version set value "2.5.0"
execute unless data storage eventcore:config debug run data modify storage eventcore:config debug set value {sound:1}
execute unless data storage eventcore:config errors run data modify storage eventcore:config errors set value {show:1}
execute unless data storage eventcore:config cmd run data modify storage eventcore:config cmd set value {security:1}
execute unless data storage eventcore:config broadcast run data modify storage eventcore:config broadcast set value {prefix:"[DUYURU]",prefix_color:"gold",msg_color:"yellow"}
execute unless data storage eventcore:config on_load run data modify storage eventcore:config on_load set value {enabled:0,ns:"eventcore",path:"version/announce"}
execute unless data storage eventcore:config locale run data modify storage eventcore:config locale set value "tr"
execute unless data storage eventcore:config max_queue_size run data modify storage eventcore:config max_queue_size set value 64
execute unless data storage eventcore:config messages run data modify storage eventcore:config messages set value {err_no_type:"Event tipi belirtilmedi!",err_version:"Sürüm uyumsuzluğu. /reload yapın.",err_empty:"args ve events boş!",err_queue_limit:"events[] limiti aşıldı!",err_prefix:"[EventCore]"}
