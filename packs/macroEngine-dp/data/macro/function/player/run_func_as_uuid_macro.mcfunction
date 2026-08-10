$data modify storage macro:engine _dispatch.func set value "$(func)"
$execute as @a[nbt={UUID:$(uuid)}] run function #macro:internal/dispatch