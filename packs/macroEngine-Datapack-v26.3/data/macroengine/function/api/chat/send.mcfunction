# ─────────────────────────────────────────────────────────────────
# macroengine:api/chat/send
# Sends a message to @a styled like one of the registered chat_type
# entries. Routes through systems/rate_limit so channel spam is
# throttled the same way other macroEngine output is.
#
# INPUT : $(channel) → "admin_broadcast" | "gate_log" | "rate_limit_notice"
#         $(message) → plain text content
#
# Example:
# function macroengine:api/chat/send {channel:"gate_log",message:"perm/exec denied for #Player"}
# ─────────────────────────────────────────────────────────────────

data modify storage macroengine:input key set value "global:chat_send"
function macroengine:systems/rate_limit/check with storage macroengine:input
execute unless data storage macroengine:output {result:1b} run return 0

$data modify storage macroengine:temp chan set value "$(channel)"
$data modify storage macroengine:temp msg set value "$(message)"

execute if data storage macroengine:temp {chan:"admin_broadcast"} run function macroengine:systems/chat/emit_admin with storage macroengine:temp
execute if data storage macroengine:temp {chan:"gate_log"} run function macroengine:systems/chat/emit_gate with storage macroengine:temp
execute if data storage macroengine:temp {chan:"rate_limit_notice"} run function macroengine:systems/chat/emit_limit with storage macroengine:temp
