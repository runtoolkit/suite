# macroengine:systems/chat/emit_gate [MACRO]
# Internal — called by api/chat/send. Emits a message styled to match
# the macroengine:gate_log chat_type (muted italic gray, admin-only).
#
# INPUT : $(msg) → plain text content
$tellraw @a[tag=macroengine.admin] ["",{"text":"[GATE] ","color":"gray","italic":true},{"text":"$(msg)","color":"gray","italic":true}]
