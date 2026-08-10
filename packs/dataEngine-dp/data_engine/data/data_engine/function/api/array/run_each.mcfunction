# dataEngine — API/Array/RunEach
# Macro args: {type: string, target: string, nbt: string}
# nbt path'teki string listesini data_api run_function/from_array ile çalıştırır.
# Liste elemanları "namespace:function" formatında olmalı.
$data modify storage data_engine:private array_run.functions \
    set from $(type) $(target) $(nbt)
execute if data storage data_engine:private array_run.functions[0] \
    run function data_api:command/run_function/from_array \
        with storage data_engine:private array_run
