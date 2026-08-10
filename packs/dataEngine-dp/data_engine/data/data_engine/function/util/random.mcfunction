# dataEngine — Util/Random
# Macro args: {min: int, max: int, mode: "range"|"chance", value: int}
# mode "range": min..max arası int → data_api:private import.from
# mode "chance": min..max <= value ise true, değilse false → import.from
$function data_api:command/modify_data/import/from_random \
    {min: $(min), max: $(max), mode: "$(mode)", value: $(value)}
