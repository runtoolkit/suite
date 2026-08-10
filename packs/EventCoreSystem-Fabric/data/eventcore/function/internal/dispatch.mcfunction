# EventCore İç Dispatch
# eventcore:sys args üzerinden çalışır: {type:"...", data:{...}}
# Bu fonksiyon macro değil — trigger/run_core ve events/exec tarafından ortak kullanılır

# Mesaj
execute if data storage eventcore:sys args{type:"broadcast"} run function eventcore:messages/broadcast_wrapper
execute if data storage eventcore:sys args{type:"whisper"} run function eventcore:messages/whisper with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"msg"} run function eventcore:messages/msg with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"title"} run function eventcore:messages/title with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"subtitle"} run function eventcore:messages/subtitle with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"actionbar"} run function eventcore:messages/actionbar with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"title_times"} run function eventcore:messages/title_times with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"title_clear"} run function eventcore:messages/title_clear with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"title_reset"} run function eventcore:messages/title_reset with storage eventcore:sys args.data

# Ses ve Partiküller
execute if data storage eventcore:sys args{type:"playsound"} run function eventcore:sound/playsound with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"particle"} run function eventcore:sound/particle with storage eventcore:sys args.data

# Timer
execute if data storage eventcore:sys args{type:"delay"} run function eventcore:timer/delay with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"repeat"} run function eventcore:timer/repeat with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"stop"} run function eventcore:timer/stop with storage eventcore:sys args.data

# Entity
execute if data storage eventcore:sys args{type:"summon"} run function eventcore:entity/summon with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"summon"} run function eventcore:entity/summon_nbt with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"remove"} run function eventcore:entity/remove with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"data_merge"} run function eventcore:entity/data_merge with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"modify"} run function eventcore:entity/modify with storage eventcore:sys args.data

# Bossbar
execute if data storage eventcore:sys args{type:"bossbar_new"} run function eventcore:bossbar/new with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"bossbar_set"} run function eventcore:bossbar/set with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"bossbar_del"} run function eventcore:bossbar/delete with storage eventcore:sys args.data

# Oyuncu
execute if data storage eventcore:sys args{type:"tp"} run function eventcore:player/teleport with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"gamemode"} run function eventcore:player/gamemode with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"kick"} run function eventcore:player/kick with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"freeze"} run function eventcore:player/freeze with storage eventcore:sys args.data

# Waypoint
execute if data storage eventcore:sys args{type:"waypoint_create"} run function eventcore:waypoint/create with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"waypoint_tp"} run function eventcore:waypoint/teleport with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"waypoint_delete"} run function eventcore:waypoint/delete with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"waypoint_get"} run function eventcore:waypoint/get with storage eventcore:sys args.data

# Efekt
execute if data storage eventcore:sys args{type:"effect_add"} run function eventcore:effect/add with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"effect_clear"} run function eventcore:effect/clear with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"heal"} run function eventcore:effect/heal with storage eventcore:sys args.data

# XP
execute if data storage eventcore:sys args{type:"xp"} run function eventcore:xp/add with storage eventcore:sys args.data

# Eşya
execute if data storage eventcore:sys args{type:"give_raw"} run function eventcore:item/give2 with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"give"} run function eventcore:item/give with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"clear"} run function eventcore:item/clear with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"enchant"} run function eventcore:item/enchant with storage eventcore:sys args.data

# Scoreboard
execute if data storage eventcore:sys args{type:"score_set"} run function eventcore:score/set with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"score_add"} run function eventcore:score/add with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"score_remove"} run function eventcore:score/remove with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"score_reset"} run function eventcore:score/reset with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"score_obj_add"} run function eventcore:score/obj_add with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"score_obj_remove"} run function eventcore:score/obj_remove with storage eventcore:sys args.data

# Tekil Komut / Fonksiyon
# Tekil Fonksiyon — args varsa macro argümanıyla, yoksa doğrudan çağır
execute if data storage eventcore:sys args{type:"func"} if data storage eventcore:sys args.data.args run function eventcore:command/function_args with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"func"} unless data storage eventcore:sys args.data.args run function eventcore:command/function with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"cmd"} run function eventcore:command/run_secure

# Çoklu Komut — data:{commands:["cmd1","cmd2",...]}
execute if data storage eventcore:sys args{type:"cmds"} run data modify storage eventcore:sys cmd_queue set from storage eventcore:sys args.data.commands
execute if data storage eventcore:sys args{type:"cmds"} run function eventcore:command/multi_cmd_loop

# Çoklu Fonksiyon — data:{functions:[{ns:"namespace",path:"funcpath"},...]
execute if data storage eventcore:sys args{type:"funcs"} run data modify storage eventcore:sys func_queue set from storage eventcore:sys args.data.functions
execute if data storage eventcore:sys args{type:"funcs"} run function eventcore:command/multi_func_loop

# Config
execute if data storage eventcore:sys args{type:"config_set"} run function eventcore:config/set with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"config_set_str"} run function eventcore:config/set_str with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"config_get"} run function eventcore:config/get with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"config_reset"} run function eventcore:config/reset
execute if data storage eventcore:sys args{type:"config_list"} run function eventcore:config/list

# Tag
execute if data storage eventcore:sys args{type:"tag_add"} run function eventcore:entity/tag_add with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"tag_remove"} run function eventcore:entity/tag_remove with storage eventcore:sys args.data

# Dünya
execute if data storage eventcore:sys args{type:"fill"} run function eventcore:world/fill with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"fill"} run function eventcore:world/fill_replace with storage eventcore:sys args.data

# Dialog
execute if data storage eventcore:sys args{type:"dialog_show"} run function eventcore:dialog/show with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"dialog_clear"} run function eventcore:dialog/clear with storage eventcore:sys args.data

# Cooldown
execute if data storage eventcore:sys args{type:"cooldown_set"} run function eventcore:cooldown/set with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"cooldown_check"} run function eventcore:cooldown/check with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"cooldown_clear"} run function eventcore:cooldown/clear with storage eventcore:sys args.data

# Flag
execute if data storage eventcore:sys args{type:"flag_set"} run function eventcore:flag/set with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"flag_unset"} run function eventcore:flag/unset with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"flag_check"} run function eventcore:flag/check with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"flag_toggle"} run function eventcore:flag/toggle with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"flag_clear"} run function eventcore:flag/clear with storage eventcore:sys args.data

# Queue
execute if data storage eventcore:sys args{type:"queue_push"} run function eventcore:queue/push with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"queue_run"} run function eventcore:queue/run with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"queue_clear"} run function eventcore:queue/clear with storage eventcore:sys args.data

# Locale
execute if data storage eventcore:sys args{type:"locale_set"} run function eventcore:config/set_locale with storage eventcore:sys args.data

# Label
execute if data storage eventcore:sys args{type:"label_save"} run function eventcore:label/save with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"label_run"} run function eventcore:label/run with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"label_delete"} run function eventcore:label/delete with storage eventcore:sys args.data

# Math
execute if data storage eventcore:sys args{type:"math_op"} run function eventcore:math/op with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"math_set"} run function eventcore:math/set with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"math_get"} run function eventcore:math/get with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"math_copy"} run function eventcore:math/copy with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"math_compare"} run function eventcore:math/compare with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"math_add_const"} run function eventcore:math/add_const with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"math_sub_const"} run function eventcore:math/sub_const with storage eventcore:sys args.data

# Data Store
execute if data storage eventcore:sys args{type:"data_set"} run function eventcore:data/set with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"data_get"} run function eventcore:data/get with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"data_del"} run function eventcore:data/del with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"data_copy"} run function eventcore:data/copy with storage eventcore:sys args.data

# Region
execute if data storage eventcore:sys args{type:"region_check"} run function eventcore:region/check with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"region_count"} run function eventcore:region/count with storage eventcore:sys args.data

# Genişletilmiş Oyuncu & Ses
execute if data storage eventcore:sys args{type:"title_full"} run function eventcore:player/title_full with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"inv_clear"} run function eventcore:player/inv_clear with storage eventcore:sys args.data
execute if data storage eventcore:sys args{type:"sound_stop"} run function eventcore:sound/stop with storage eventcore:sys args.data
