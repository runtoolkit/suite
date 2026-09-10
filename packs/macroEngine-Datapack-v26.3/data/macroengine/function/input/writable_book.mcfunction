# ======================================================================================
# macroengine:input/writable_book
# ======================================================================================
#
# TRIGGERED BY: #macroengine:input/writable_book function tag
# (also listed in #macroengine:loop so it is scanned every tick)
#
# PURPOSE:
#   Detect a player holding a writable_book marked with
#   custom_data={macroengine:{input:1b}} (given via
#   macroengine:input/give_writable_book),
#   and extract the raw text of page[0] from
#   SelectedItem.components."minecraft:writable_book_content".pages[0].raw
#   into macroengine:input storage. Input capture ONLY — no execution here.
#
# BOOK IS KEPT:
#   Capture does not clear/delete the book. One-shot per hold-session uses
#   tag macroengine.book_captured; the tag is removed when the player is no
#   longer holding the marked book so a later re-select can submit again.
#
# WHY THIS ONLY CHECKS THE MAINHAND SELECTED ITEM:
#   'SelectedItem' reflects the player's currently held mainhand item at
#   entity-data-read time. If the marked book is not currently selected,
#   this tick simply finds nothing — this is intentional, not a bug.
# ======================================================================================

# Release debounce for anyone no longer holding the marked input book
execute as @a[tag=macroengine.book_captured] unless entity @s[nbt={SelectedItem:{components:{"minecraft:custom_data":{macroengine:{input:1b}}}}}] run tag @s remove macroengine.book_captured

# Fast exit — skip entirely if no player is holding the marked book
execute unless entity @a[nbt={SelectedItem:{components:{"minecraft:custom_data":{macroengine:{input:1b}}}}}] run return 0

execute as @a[nbt={SelectedItem:{components:{"minecraft:custom_data":{macroengine:{input:1b}}}}}] run function macroengine:input/private/book_capture
