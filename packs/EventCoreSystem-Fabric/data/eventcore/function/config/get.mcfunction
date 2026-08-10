# Tek bir config anahtarının değerini gösterir.
# Kullanım: function eventcore:trigger {args:{type:"config_get",data:{key:"broadcast.prefix"}}}
$tellraw @s [{"text":"[Config] ","color":"aqua","bold":true},{"text":"$(key)","color":"white"},{"text":" = ","color":"gray"},{"storage":"eventcore:config","nbt":"$(key)","color":"yellow"}]
