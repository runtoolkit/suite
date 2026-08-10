tellraw @s [{"text":"[DL]","color":"#ffe600","extra":[" "]},{"text":"Reloading..."}]

#> Reload
reload
function dl_load:load/all

#>Feedback
tag @s remove datalib.loadFail
tellraw @s [{"text":"[DL]","color":"#ffe600","extra":[" "]},{"text":"Engine reloaded successfully.","color":"green"}]
