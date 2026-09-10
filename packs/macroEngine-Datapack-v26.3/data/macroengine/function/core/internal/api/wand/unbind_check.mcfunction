# macroengine:api/wand/internal/unbind_check [MACRO]
# $(tag) is the tag of the current record. Add back if it does not match _wand_filter_tag.

$execute unless data storage macroengine:engine {_wand_filter_tag:"$(tag)"} run data modify storage macroengine:engine wand_binds append from storage macroengine:engine _wand_cur
