# ======================================================================================
# macroengine:input/private/lectern_capture  [INTERNAL]
# MC 26.3-pre: Book.components writable/written_book_content pages as {raw}|{text}|string
# ======================================================================================

data modify storage macroengine:input lectern.raw set value ""

data modify storage macroengine:input lectern.raw set from block ~ ~ ~ Book.components."minecraft:writable_book_content".pages[0].raw
execute if data storage macroengine:input {lectern:{raw:""}} run data modify storage macroengine:input lectern.raw set from block ~ ~ ~ Book.components."minecraft:writable_book_content".pages[0].text
execute if data storage macroengine:input {lectern:{raw:""}} run data modify storage macroengine:input lectern.raw set from block ~ ~ ~ Book.components."minecraft:writable_book_content".pages[0]

execute if data storage macroengine:input {lectern:{raw:""}} run data modify storage macroengine:input lectern.raw set from block ~ ~ ~ Book.components."minecraft:written_book_content".pages[0].raw
execute if data storage macroengine:input {lectern:{raw:""}} run data modify storage macroengine:input lectern.raw set from block ~ ~ ~ Book.components."minecraft:written_book_content".pages[0].text
execute if data storage macroengine:input {lectern:{raw:""}} run data modify storage macroengine:input lectern.raw set from block ~ ~ ~ Book.components."minecraft:written_book_content".pages[0]

data modify storage macroengine:input lectern.player set from entity @s UUID
data modify storage macroengine:input lectern.pos set from entity @s Pos
data modify storage macroengine:input lectern.executed set value 0b
execute if data storage macroengine:input lectern{executed:0b} run function #macroengine:input/lectern
