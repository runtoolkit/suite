# config:{repeat:N} — args:{} eventini N kez çalıştırır.
# Yalnızca args:{type:"..."} ile çalışır; events:[] bu modda göz ardı edilir.
$scoreboard players set #ec_repeat ec.sys $(repeat)
function eventcore:trigger/repeat_loop
scoreboard players reset #ec_repeat ec.sys
