# dataEngine — API/Command/RunFnOnInventory
# @s olarak (oyuncu olarak) çalıştırılmalı.
# Macro args: {function: string, context: string}
# Oyuncu envanter slotlarında (0-35 + armor + offhand) function'ı {number,path,slot} ile çağırır.
# data_api:command/run_function/on_inventory tam wrapper.
$function data_api:command/run_function/on_inventory \
    {function: "$(function)", context: "$(context)"}
