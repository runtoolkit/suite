# macroengine:systems/log/testblock/place_at [MACRO]
# Input: $(x), $(y), $(z) — from debug_log_pos
$setblock $(x) $(y) $(z) minecraft:test_block[mode=log]{message:"[macroengine] (idle)",mode:"log",powered:0b} replace
