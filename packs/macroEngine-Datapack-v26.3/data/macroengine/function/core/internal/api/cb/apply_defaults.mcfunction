# macroengine:api/cb/internal/apply_defaults
# Fills in missing x/y/z fields before the macro call.
execute unless data storage macroengine:input cb.x run data modify storage macroengine:input cb.x set value 0
execute unless data storage macroengine:input cb.y run data modify storage macroengine:input cb.y set value -64
execute unless data storage macroengine:input cb.z run data modify storage macroengine:input cb.z set value 0
