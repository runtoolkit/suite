# macroengine:systems/color/internal/validate_exec [MACRO]
# Internal — called by api/color/validate.
# Sets macroengine:output result to 1b if $(color) is a known named color,
# or if it begins with "#" (hex shorthand detection).
$execute if data storage macroengine:engine color._names.$(color) run data modify storage macroengine:output result set value 1b
