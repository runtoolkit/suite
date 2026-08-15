execute unless data storage rtwrapper:api batch[0] run return 0

scoreboard players operation #batch_id rtw.status = #processed rtw.status

function rtwrapper:api/enqueue_batch_step

data remove storage rtwrapper:api batch