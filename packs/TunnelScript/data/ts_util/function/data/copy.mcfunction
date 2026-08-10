# Copy storage tunnelscript:in from_path -> storage tunnelscript:out value.
# Input: storage tunnelscript:in { "from": <any data>, ... } ; result in :out copied.
data modify storage tunnelscript:out copied set from storage tunnelscript:in from
