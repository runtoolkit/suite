# Normalise request shape, then prepare dispatch.
# Supported request shapes:
#   {cmd:"tp", params:{target:"@s", x:"0", y:"80", z:"0"}}
#   {type:"tp", params:{target:"@s", x:"0", y:"80", z:"0"}}  # type is accepted as an alias.
# Parameter rule: provide contiguous named parameters in the documented command order.
execute unless data storage rtwrapper:runtime current.cmd if data storage rtwrapper:runtime current.type run data modify storage rtwrapper:runtime current.cmd set from storage rtwrapper:runtime current.type
execute unless data storage rtwrapper:runtime current.params if data storage rtwrapper:runtime current.args run data modify storage rtwrapper:runtime current.params set from storage rtwrapper:runtime current.args
execute unless data storage rtwrapper:runtime current.params run data modify storage rtwrapper:runtime current.params set value {}

execute if data storage rtwrapper:runtime current.cmd run function rtwrapper:core/wrappers/handler/dispatch
execute unless data storage rtwrapper:runtime current.cmd run function rtwrapper:core/wrappers/handler/error_missing_cmd

data remove storage rtwrapper:runtime current
