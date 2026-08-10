# RunLoad — reload dispatcher
# Called only when #runload load.init is already 1 (i.e. this is a /reload, not first load).
# Runs #load:reload so packs can register cleanup or re-init logic exclusive to manual reloads.
function #load:reload
