# 🔒 OP ENGELLERİ
execute if data storage eventcore:sys args.data{command:"op @s"} run return fail
execute if data storage eventcore:sys args.data{command:"op @p"} run return fail
execute if data storage eventcore:sys args.data{command:"op @a"} run return fail
execute if data storage eventcore:sys args.data{command:"op @e"} run return fail
execute if data storage eventcore:sys args.data{command:"op @n"} run return fail
execute if data storage eventcore:sys args.data{command:"op @e[type=player]"} run return fail
execute if data storage eventcore:sys args.data{command:"op @e[type=minecraft:player]"} run return fail
execute if data storage eventcore:sys args.data{command:"op @n[type=player]"} run return fail
execute if data storage eventcore:sys args.data{command:"op @n[type=minecraft:player]"} run return fail

# 🔒 DEOP ENGELLERİ
execute if data storage eventcore:sys args.data{command:"deop @s"} run return fail
execute if data storage eventcore:sys args.data{command:"deop @p"} run return fail
execute if data storage eventcore:sys args.data{command:"deop @a"} run return fail
execute if data storage eventcore:sys args.data{command:"deop @e"} run return fail
execute if data storage eventcore:sys args.data{command:"deop @n"} run return fail
execute if data storage eventcore:sys args.data{command:"deop @e[type=player]"} run return fail
execute if data storage eventcore:sys args.data{command:"deop @e[type=minecraft:player]"} run return fail
execute if data storage eventcore:sys args.data{command:"deop @n[type=player]"} run return fail
execute if data storage eventcore:sys args.data{command:"deop @n[type=minecraft:player]"} run return fail

# 🔨 BAN ENGELLERİ
execute if data storage eventcore:sys args.data{command:"ban @s"} run return fail
execute if data storage eventcore:sys args.data{command:"ban @p"} run return fail
execute if data storage eventcore:sys args.data{command:"ban @a"} run return fail
execute if data storage eventcore:sys args.data{command:"ban @e"} run return fail
execute if data storage eventcore:sys args.data{command:"ban @n"} run return fail
execute if data storage eventcore:sys args.data{command:"ban @e[type=player]"} run return fail
execute if data storage eventcore:sys args.data{command:"ban @e[type=minecraft:player]"} run return fail
execute if data storage eventcore:sys args.data{command:"ban @n[type=player]"} run return fail
execute if data storage eventcore:sys args.data{command:"ban @n[type=minecraft:player]"} run return fail

# 👢 KICK ENGELLERİ
execute if data storage eventcore:sys args.data{command:"kick @s"} run return fail
execute if data storage eventcore:sys args.data{command:"kick @p"} run return fail
execute if data storage eventcore:sys args.data{command:"kick @a"} run return fail
execute if data storage eventcore:sys args.data{command:"kick @e"} run return fail
execute if data storage eventcore:sys args.data{command:"kick @n"} run return fail
execute if data storage eventcore:sys args.data{command:"kick @e[type=player]"} run return fail
execute if data storage eventcore:sys args.data{command:"kick @e[type=minecraft:player]"} run return fail
execute if data storage eventcore:sys args.data{command:"kick @n[type=player]"} run return fail
execute if data storage eventcore:sys args.data{command:"kick @n[type=minecraft:player]"} run return fail

# 📛 WHITELIST ENGELLERİ
execute if data storage eventcore:sys args.data{command:"whitelist on"} run return fail
execute if data storage eventcore:sys args.data{command:"whitelist off"} run return fail
execute if data storage eventcore:sys args.data{command:"whitelist add"} run return fail
execute if data storage eventcore:sys args.data{command:"whitelist remove"} run return fail
execute if data storage eventcore:sys args.data{command:"whitelist reload"} run return fail

# ⛔ STOP ENGELİ
execute if data storage eventcore:sys args.data{command:"stop"} run return fail

# RELOAD ENGELİ
execute if data storage eventcore:sys args.data{command:"reload"} run return fail

# Yürüt
$$(command)
