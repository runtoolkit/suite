# Deferred one-shot: move the queued actions into the live input and run once.
data modify storage tunnelscript:in actions set from storage tunnelscript_core:later actions
function ts:run
