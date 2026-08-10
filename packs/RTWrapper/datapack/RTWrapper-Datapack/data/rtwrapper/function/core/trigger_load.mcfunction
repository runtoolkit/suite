# RTWrapper trigger-module bootstrap. Idempotent - safe to call every /reload.
scoreboard objectives add rtw.status dummy
execute unless data storage rtwrapper:triggers registry run data modify storage rtwrapper:triggers registry set value []
