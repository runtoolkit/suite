# dataEngine — API/Command/RunFnOnContainer
# Macro args: {type,target,start,stop,function,path,context}
# Container slotlarında her slot için function'ı {number,path,slot} args ile çağırır.
# data_api:command/run_function/on_container tam wrapper.
$function data_api:command/run_function/on_container \
    {type: "$(type)", target: "$(target)", start: $(start), stop: $(stop), \
     function: "$(function)", path: "$(path)", context: "$(context)"}
