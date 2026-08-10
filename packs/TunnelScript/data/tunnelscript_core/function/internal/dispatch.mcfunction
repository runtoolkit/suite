# Routes one action element to handlers/<type>, forwarding the element as args.
# Adding a new action type is as simple as adding a new handler file.
$function tunnelscript_core:handlers/$(type) with storage tunnelscript_core:work current
