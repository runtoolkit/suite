# Process exactly one queued/direct action, then return. Queue takes priority
# over a direct rtwrapper:api request (see core/wrappers/handler/main). Called
# by core/tick.mcfunction under autotick, and once per action by run_actions.
function rtwrapper:core/wrappers/handler/main
