# Clean up leftover intermediate keys from the split process (KeepEmpty/Segment/Min/Max are re-derived each run, so nothing here is needed after this point)
data remove storage macroengine_string:temp data.Segment
data remove storage macroengine_string:temp data.Min
data remove storage macroengine_string:temp data.Max
