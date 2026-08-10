# dataEngine — Hook/Fire
# Macro args: {id: string}
# hooks.<id> = ["ns:fn1", "ns:fn2", ...]  (string listesi)
# Geçici hook_run.functions'a kopyala, from_array ile çalıştır.
$data modify storage data_engine:private hook_run.functions \
    set from storage data_engine:private hooks.$(id)
execute if data storage data_engine:private hook_run.functions[0] \
    run function data_api:command/run_function/from_array \
        with storage data_engine:private hook_run
