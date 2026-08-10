# dataEngine — API/Command/OnInventory
# @s olarak (oyuncu olarak) çalıştırılmalı.
# Macro args: {command: string}
# Oyuncu envanterinin tüm slotlarında (0-35 + armor + offhand) komut çalıştırır.
# data_api:command/run_command/on_inventory tam wrapper.
$function data_api:command/run_command/on_inventory {command: "$(command)"}
