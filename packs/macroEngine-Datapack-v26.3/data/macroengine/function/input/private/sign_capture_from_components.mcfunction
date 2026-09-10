# 26.3 component path
data modify storage macroengine:input _t set value ""
data modify storage macroengine:input _t set from block ~ ~ ~ components."minecraft:sign_text_front".messages[0].text
execute if data storage macroengine:input {_t:""} run data modify storage macroengine:input _t set from block ~ ~ ~ components."minecraft:sign_text_front".messages[0]
data modify storage macroengine:input sign.lines[0] set from storage macroengine:input _t

data modify storage macroengine:input _t set value ""
data modify storage macroengine:input _t set from block ~ ~ ~ components."minecraft:sign_text_front".messages[1].text
execute if data storage macroengine:input {_t:""} run data modify storage macroengine:input _t set from block ~ ~ ~ components."minecraft:sign_text_front".messages[1]
data modify storage macroengine:input sign.lines[1] set from storage macroengine:input _t

data modify storage macroengine:input _t set value ""
data modify storage macroengine:input _t set from block ~ ~ ~ components."minecraft:sign_text_front".messages[2].text
execute if data storage macroengine:input {_t:""} run data modify storage macroengine:input _t set from block ~ ~ ~ components."minecraft:sign_text_front".messages[2]
data modify storage macroengine:input sign.lines[2] set from storage macroengine:input _t

data modify storage macroengine:input _t set value ""
data modify storage macroengine:input _t set from block ~ ~ ~ components."minecraft:sign_text_front".messages[3].text
execute if data storage macroengine:input {_t:""} run data modify storage macroengine:input _t set from block ~ ~ ~ components."minecraft:sign_text_front".messages[3]
data modify storage macroengine:input sign.lines[3] set from storage macroengine:input _t
