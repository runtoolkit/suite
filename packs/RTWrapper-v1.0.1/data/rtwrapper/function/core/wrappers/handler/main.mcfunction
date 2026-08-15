# Entry point for wrapper processing.
# Priority: queued requests first; if queue is empty, consume rtwrapper:api request.
execute if data storage rtwrapper:runtime queue[0] run function rtwrapper:core/wrappers/handler/dequeue
execute unless data storage rtwrapper:runtime queue[0] if data storage rtwrapper:api request.cmd run function rtwrapper:core/wrappers/handler/from_request
execute unless data storage rtwrapper:runtime queue[0] unless data storage rtwrapper:api request.cmd if data storage rtwrapper:api request.type run function rtwrapper:core/wrappers/handler/from_request
