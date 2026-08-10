# dataEngine — API/Command/RunWith
# Macro args: {function: string, inputs: [...]}
# inputs listesindeki her compound ile function'ı çağırır.
# data_api:command/run_function/with_array tam wrapper.
$function data_api:command/run_function/with_array \
    {function: "$(function)", inputs: $(inputs)}
