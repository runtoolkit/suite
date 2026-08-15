# Processes exactly one action: queued request first, otherwise one direct api request.
execute if score #debug rtw.config matches 1.. if score #silent rtw.config matches 0 run tellraw @a[tag=rtwrapper.debug] [{"text":"[RTWrapper] run_next","color":"gold"}]
function rtwrapper:core/wrappers/handler/main
