# AME Tick Channel Defaults
# ─────────────────────────────────────────────────────────────────────────────
# This file is the "JSON config" for the tick engine.
# It is executed ONCE on first world load (and on macro:core/tick/reset_channels).
# Modify here to change the default channel layout that all new worlds receive.
#
# Channel fields
# ──────────────
# id (string) unique name — used by all API functions
# enabled (1b|0b) 1b = runs each applicable tick, 0b = dormant
# rate (int) fire every N ticks [1=every tick, 20=1/s, 200=10/s]
# offset (int) phase offset 0..(rate-1)
# use different offsets per channel to spread CPU load
# fn (string) function resource location to call
# condition (string) predicate path; "" means "always fire"
# e.g. "macro:is_daytime" — only runs during daylight
#
# API (available after load)
# ──────────────────────────
# function macro:core/tick/channel/enable {id:"..."}
# function macro:core/tick/channel/disable {id:"..."}
# function macro:core/tick/channel/set_rate {id:"...",rate:N}
# function macro:core/tick/channel/set_offset {id:"...",offset:N}
# function macro:core/tick/channel/set_condition {id:"...",condition:"ns:pred"}
# function macro:core/tick/channel/register {id:"...",rate:N,offset:N,fn:"ns:path",enabled:1,condition:""}
# function macro:core/tick/channel/unregister {id:"..."}
# function macro:core/tick/channel/list
# function macro:core/tick/pause
# function macro:core/tick/resume
# function macro:core/tick/status
# function macro:core/tick/reset_channels
# ─────────────────────────────────────────────────────────────────────────────

data modify storage macro:engine tick.channels set value []

# time_systems — epoch counter; must stay at rate:1 offset:0
data modify storage macro:engine tick.channels append value {id:"time_systems",enabled:1b,rate:1,offset:0,fn:"macro:core/tick/time_systems",condition:""}

# player_systems — per-player state polling; every tick
data modify storage macro:engine tick.channels append value {id:"player_systems",enabled:1b,rate:1,offset:0,fn:"macro:core/tick/player_systems",condition:""}

# queue_systems — scheduled task queue; every tick
data modify storage macro:engine tick.channels append value {id:"queue_systems",enabled:1b,rate:1,offset:0,fn:"macro:core/tick/queue_systems",condition:""}

# hud_systems — HUD refresh; every 2 ticks, offset 1 (fires on odd ticks, avoiding collision with rate-1 channels)
data modify storage macro:engine tick.channels append value {id:"hud_systems",enabled:1b,rate:2,offset:1,fn:"macro:core/tick/hud_systems",condition:""}

# admin_systems — admin tooling; every 4 ticks, offset 2
data modify storage macro:engine tick.channels append value {id:"admin_systems",enabled:1b,rate:4,offset:2,fn:"macro:core/tick/admin_systems",condition:"macro:is_creative"}