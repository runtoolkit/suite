# macro: $(menu)
# Player tag "macroengine.gui_m.<alias>" lets fill/probe routers dispatch per menu.
# Tags cannot contain ':' or '/', so menus register a tag-safe `alias`.
$data modify storage macroengine:gui_ctx alias set from storage macroengine:gui_reg menus."$(menu)".alias
function macroengine:gui/internal/set_alias_tag with storage macroengine:gui_ctx
