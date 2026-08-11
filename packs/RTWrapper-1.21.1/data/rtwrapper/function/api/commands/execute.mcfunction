# Direct named-parameter API for /execute.
# Parameter order: step01, step02, step03, step04, step05, step06, step07, step08, step09, step10, step11, step12, step13, step14, step15, step16, step17, step18, step19, step20, step21, step22, step23, step24, step25, step26, step27, step28, step29, step30, step31, step32
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/execute
data remove storage rtwrapper:runtime current.params
