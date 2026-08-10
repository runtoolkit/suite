# macro:core/security/multi_type_check_macro [MACRO] [1.20.5 overlay]
# Checks if _mcmd_type_tmp exists as a key in security.multi_type_allowlist.
$execute if data storage macro:engine security.multi_type_allowlist{$(_mcmd_type_tmp):1b} run return 1
function macro:core/security/type_violation
return 0
