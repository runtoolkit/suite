# Enqueue rtwrapper:api request for later processing.
# Accepts either {cmd:"..."} or {type:"..."}; proc normalizes type -> cmd.
execute if data storage rtwrapper:api request.cmd run data modify storage rtwrapper:runtime queue append from storage rtwrapper:api request
execute if data storage rtwrapper:api request.cmd run data remove storage rtwrapper:api request
execute unless data storage rtwrapper:api request.cmd if data storage rtwrapper:api request.type run data modify storage rtwrapper:runtime queue append from storage rtwrapper:api request
execute if data storage rtwrapper:api request.type run data remove storage rtwrapper:api request
