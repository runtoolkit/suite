# ─────────────────────────────────────────────────────────────────
# macroengine:systems/string/tag_badge
# Sends a styled [TAG] badge with optional hover text.
# Input : $(target) → selector
# $(tag) → badge label (e.g. "ADMIN", "VIP")
# $(color) → badge color (e.g. "red", "gold")
# $(hover) → hover tooltip text
#
# Example:
# data modify storage macroengine:input target set value "@s"
# data modify storage macroengine:input tag set value "ADMIN"
# data modify storage macroengine:input color set value "red"
# data modify storage macroengine:input hover set value "Server Administrator"
# function macroengine:systems/string/tag_badge with storage macroengine:input {}
# ─────────────────────────────────────────────────────────────────

$tellraw $(target) ["",{"text":"[","color":"#555555","bold":false},{"text":"$(tag)","color":"$(color)","bold":true,"hoverEvent":{"action":"show_text","value":{"text":"$(hover)","color":"gray","italic":true}}},{"text":"]","color":"#555555","bold":false}]
