# dataEngine — API/Math/Calculate
# data_api:command/calculate tam wrapper.
# args.operation: add | subtract | multiply | divide | mean | median | mode | range | square | square_root
# args.inputs: [{nbt,target,type}, ...] veya sayı listesi
# args.output: {nbt, target, type}
# Tüm argümanları data_engine:private math_args'a koy, sonra with ile çağır.
function data_api:command/calculate with storage data_engine:private math_args
