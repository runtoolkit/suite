# dataEngine — API/Item/Damage
# Macro args: {type: string, target: string, slot: string, damage: int|compound}
# damage compound: {value: int, break: bool}
$function data_api:command/damage_item \
    {type: "$(type)", target: "$(target)", slot: "$(slot)", damage: $(damage)}
