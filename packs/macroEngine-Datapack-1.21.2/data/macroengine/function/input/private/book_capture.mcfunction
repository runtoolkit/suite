# ======================================================================================
# macroengine:input/private/book_capture  [INTERNAL — do not call directly]
# ======================================================================================
#
# Runs with @s bound to a single player holding the marked written_book.
# Extracts SelectedItem.components."minecraft:writable_book_content".pages[0].raw
# into macroengine:input storage. Read-only capture, no execution.
#
# book.raw is a RAW, UNVALIDATED string — same contract as cbm.command and
# dialog.raw. If the caller needs it as a number/bool/tag-safe literal,
# run it through macroengine:input/validate/check first:
#   function macroengine:input/validate/check with storage <yourpath> {source:"book.raw", type:"int"}
# ======================================================================================

data modify storage macroengine:input book.player set from entity @s UUID
data modify storage macroengine:input book.raw set from entity @s SelectedItem.components."minecraft:writable_book_content".pages[0].raw

# Same "raw, unvalidated, unexecuted" contract as command_block_minecart capture.
data modify storage macroengine:input book.executed set value 0b
execute if data storage macroengine:input book{executed:0b} run function #macroengine:input/writable_book

# Clear the custom_data marker so the same book cannot be resubmitted every
# tick while the player keeps holding it — this is a one-shot capture.
data remove entity @s SelectedItem.components."minecraft:custom_data".macroengine.input
