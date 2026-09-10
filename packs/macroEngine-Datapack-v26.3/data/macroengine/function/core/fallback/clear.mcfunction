# macroengine:core/fallback/clear
# Clears the fallback state from macroengine:output.
# Call this before an action chain to get a clean fallback check afterwards.
# Usage: function macroengine:core/fallback/clear
data remove storage macroengine:output fallback
