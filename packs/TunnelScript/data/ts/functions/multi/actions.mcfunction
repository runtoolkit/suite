# Run many limited typed actions. Only cmd/command action types are handled
# on 1.19.2 because dynamic dispatch needs macros.
# Input: storage tunnelscript:in { actions:[{type:"cmd",value:"say hi"}] }
function ts:run
