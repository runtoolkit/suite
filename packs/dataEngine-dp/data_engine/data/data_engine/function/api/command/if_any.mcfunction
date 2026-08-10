# dataEngine — API/Command/IfAny
# Macro args: {commands: [...], conditions: [...]}
# conditions'dan herhangi biri true ise commands çalışır.
# data_api:command/run_command/if_any tam wrapper.
$function data_api:command/run_command/if_any \
    {commands: $(commands), conditions: $(conditions)}
