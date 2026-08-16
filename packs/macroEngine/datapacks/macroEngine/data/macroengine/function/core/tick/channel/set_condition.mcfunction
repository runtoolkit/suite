# macroengine:core/tick/channel/set_condition — Set or clear condition predicate
# Usage: function macroengine:core/tick/channel/set_condition {id:"channel_id",condition:"ns:pred"}
# function macroengine:core/tick/channel/set_condition {id:"channel_id",condition:""} ← always-run
$data modify storage macroengine:engine tick.channels[{id:"$(id)"}] merge value {condition:"$(condition)"}