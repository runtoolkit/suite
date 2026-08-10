# Event kuyruğunda eleman varsa işlemi başlatır.
# events/exec tarafından da çağrılır (mutual recursion ile sona erer).
execute if data storage eventcore:sys event_queue[0] run function eventcore:events/exec
