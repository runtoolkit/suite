# dataEngine — API/Item/Hopper/Insert
# @s olarak (blok konumunda) çalıştırılmalı.
# Macro args: {pos: string, slot: int, hopper_slot: int}
# pos konumundaki hopper'ın hopper_slot'undan, blok container.slot'una item taşır.
$function data_api:command/return_item_from_hopper/insert_with_item \
    {pos: "$(pos)", slot: $(slot), hopper_slot: $(hopper_slot)}
