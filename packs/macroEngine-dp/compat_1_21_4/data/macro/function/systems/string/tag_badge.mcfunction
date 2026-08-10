# ─────────────────────────────────────────────────────────────────
# macro:systems/string/tag_badge [compat_1_21_4]
# Sends a styled [TAG] badge with optional hover text.
#  Input : $(target)     → selector
#          $(tag)        → badge label (e.g. "ADMIN", "VIP")
#          $(color)      → badge color (e.g. "red", "gold")
#          $(hover)      → hover tooltip text
#
# compat_1_21_4: uses hoverEvent (camelCase) instead of hover_event
# ─────────────────────────────────────────────────────────────────

$tellraw $(target) ["",{"text":"[","color":"#555555","bold":false},{"text":"$(tag)","color":"$(color)","bold":true,"hoverEvent":{"action":"show_text","value":{"text":"$(hover)","color":"gray","italic":true}}},{"text":"]","color":"#555555","bold":false}]
