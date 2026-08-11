# Consume rtwrapper:api request, then drain the queue.
execute if data storage rtwrapper:api request.cmd run function rtwrapper:api/enqueue
execute unless data storage rtwrapper:api request.cmd if data storage rtwrapper:api request.type run function rtwrapper:api/enqueue
function rtwrapper:core/run/run_actions
