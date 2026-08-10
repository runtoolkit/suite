# macro:core/fallback/clear
# Clears the fallback state from macro:output.
# Call this before an action chain to get a clean fallback check afterwards.
# Usage: function macro:core/fallback/clear
data remove storage macro:output fallback
