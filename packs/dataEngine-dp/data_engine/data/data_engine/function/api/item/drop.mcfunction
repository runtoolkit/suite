# dataEngine — API/Item/Drop
# Macro args: {type: string, target: string, slot: string, pickup_delay: int}
# Slot'taki itemi düşürür ve slot'u temizler.
$function data_api:command/drop_item \
    {type: "$(type)", target: "$(target)", slot: "$(slot)", pickup_delay: $(pickup_delay)}
