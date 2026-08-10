# config:{unless_flag:"name"} — flag 1b ise #ec_flag_pass sıfırlanır.
$execute if data storage eventcore:flags {$(unless_flag):1} run scoreboard players set #ec_flag_pass ec.sys 0
