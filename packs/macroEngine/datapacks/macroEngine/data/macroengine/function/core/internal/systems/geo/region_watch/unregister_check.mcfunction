# macroengine:systems/geo/region_watch/internal/unregister_check [MACRO]
# INPUT: $(id) — _rw_cur'dan beslenir
# If id does not match, add to _rw_new (keep).

$execute unless data storage macroengine:engine {_rw_unbind_id:"$(id)"} run data modify storage macroengine:engine _rw_new append from storage macroengine:engine _rw_cur
