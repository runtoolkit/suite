# dataEngine — API/Command/Ternary
# Macro args: {condition: string, if: [...], unless: [...]}
# condition true ise if listesi, değilse unless listesi çalışır.
$function data_api:command/run_command/as_ternary \
    {condition: "$(condition)", if: $(if), unless: $(unless)}
