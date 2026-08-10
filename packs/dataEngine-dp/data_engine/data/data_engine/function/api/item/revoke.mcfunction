# dataEngine — API/Item/Revoke
# @s olarak çalıştırılmalı.
# Macro args: {item: string, return: [...], sound: string, text: json}
# @s'den item'ı alır, return listesi ile belirtilen konuma geri spawn eder.
# data_api:command/revoke_item tam wrapper.
$function data_api:command/revoke_item \
    {item: "$(item)", return: $(return), sound: "$(sound)", text: $(text)}
