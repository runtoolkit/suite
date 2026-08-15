# Priority enqueue: same request shapes as api/enqueue, but inserts at the FRONT
# of the queue (index 0) instead of appending. Use when a dependent pack needs its
# action to run before whatever is already queued (e.g. an urgent correction),
# without disturbing the relative order of the rest of the queue.
# Accepts either {cmd:"..."} or {type:"..."}; proc normalizes type -> cmd, same as enqueue.
execute if data storage rtwrapper:api request.cmd run data modify storage rtwrapper:runtime queue insert 0 from storage rtwrapper:api request
execute if data storage rtwrapper:api request.cmd run data remove storage rtwrapper:api request
execute unless data storage rtwrapper:api request.cmd if data storage rtwrapper:api request.type run data modify storage rtwrapper:runtime queue insert 0 from storage rtwrapper:api request
execute if data storage rtwrapper:api request.type run data remove storage rtwrapper:api request
