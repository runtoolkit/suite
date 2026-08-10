# Record the command that was just pulsed, then trim the log to #log_max.
data modify storage tunnelscript:log entries append from storage tunnelscript:in cmd
data modify storage tunnelscript:log last set from storage tunnelscript:in cmd
execute store result score #log_len tunnelscript.vars run data get storage tunnelscript:log entries
execute if score #log_len tunnelscript.vars > #log_max tunnelscript.vars run data remove storage tunnelscript:log entries[0]
