# ============================================================
# macroengine:systems/uuid/internal/match_check [MACRO FUNCTION]
# Dynamically compares the current UUID string with _match_target
#
# Call: function macroengine:core/internal/systems/uuid/match_check with storage macroengine:input
# $(value) = current UUID string written by from_entity
# ============================================================
$execute if data storage macroengine:uuid {_match_target:"$(value)"} run function macroengine:core/internal/systems/uuid/match_fire with storage macroengine:input
