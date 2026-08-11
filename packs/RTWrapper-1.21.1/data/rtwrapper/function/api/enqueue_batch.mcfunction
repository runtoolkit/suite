# Multi-action API entry (v1.0.0, basic form — see note at bottom).
#
# Usage from a dependent pack:
#   data modify storage rtwrapper:api batch set value [{cmd:"tp",params:{...}},{cmd:"say",params:{...}}]
#   function rtwrapper:api/enqueue_batch
#
# Each element is enqueued individually, in array order, onto the normal
# rtwrapper:runtime queue — so they run through the exact same dispatch path as any other
# queued action (respects auto_tick/immediate-drain the same way a series of separate
# enqueue calls would). A shared batch_id (this tick's #processed count, before any of the
# batch's own actions increment it) is attached to every element so a dependent pack can
# correlate results afterwards via rtw.status or its own bookkeeping.
#
# Deliberately NOT included here (left for a later -pre2 pass): atomic all-or-nothing
# rollback, and short-circuiting the rest of a batch if one element's dispatch sets
# #errors. Right now a failed element just increments #errors and the batch continues.

execute unless data storage rtwrapper:api batch[0] run return 0

scoreboard players operation #batch_id rtw.status = #processed rtw.status

function rtwrapper:api/enqueue_batch_step

data remove storage rtwrapper:api batch
