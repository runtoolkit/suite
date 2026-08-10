# condition:{flag:"name"} — flag 0b/yok ise bu eventi atla.
$execute unless data storage eventcore:flags {$(flag):1} run scoreboard players set #ec_cond_skip ec.sys 1
