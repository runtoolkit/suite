# dataEngine — API/Item/Hopper/ReturnSidesOnly
# @s olarak (blok konumunda) çalıştırılmalı.
# Macro args: {slot: int}
# Yan yönlerdeki hopper'lara döndürür (üst hariç).
$function data_api:command/return_item_from_hopper/without_top {slot: $(slot)}
