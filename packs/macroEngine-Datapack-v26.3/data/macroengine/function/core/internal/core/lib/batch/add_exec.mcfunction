# macroengine:core/lib/batch/internal/add_exec [MACRO]
# INPUT: $(id)
# func or cmd field existence is checked outside the macro,
# then the relevant append_func / append_cmd is called — prevents undefined $(func/cmd).

$execute unless data storage macroengine:engine batches.$(id) run return 0

execute if data storage macroengine:input func run function macroengine:core/internal/core/lib/batch/add_func with storage macroengine:input
execute if data storage macroengine:input cmd run function macroengine:core/internal/core/lib/batch/add_cmd with storage macroengine:input
