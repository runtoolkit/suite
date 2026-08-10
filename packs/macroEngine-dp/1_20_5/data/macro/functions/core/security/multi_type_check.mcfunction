# macro:core/security/multi_type_check [1.20.5 overlay]
# Validates macro:engine multiCommands.type against security.multi_type_allowlist.
# Returns 1 → type is valid. Returns 0 → type violation fired (log + kick).
data modify storage macro:engine _mcmd_type_tmp set from storage macro:engine multiCommands.type
function macro:core/security/multi_type_check_macro with storage macro:engine {}
data remove storage macro:engine _mcmd_type_tmp
