# config:{if_flag:"name"} — flag 0b/yok ise #ec_flag_pass sıfırlanır.
$execute unless data storage eventcore:flags {$(if_flag):1} run scoreboard players set #ec_flag_pass ec.sys 0
