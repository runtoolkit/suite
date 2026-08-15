# RTWrapper generated named-parameter dispatcher for /stop.
# Provide contiguous parameters in this order:
# (none)
scoreboard players set #pc rtw.status 0
execute if score #pc rtw.status matches 0 run function rtwrapper:core/wrappers/internal/variants/stop_0
