# Macro: called with storage rtwrapper:runtime trigger_poll (field: index, an int, already
# incremented by poll_step). Recurses into poll_step if registry[index] exists.
$execute if data storage rtwrapper:triggers registry[$(index)] run function rtwrapper:core/trigger/poll_step with storage rtwrapper:runtime trigger_poll
