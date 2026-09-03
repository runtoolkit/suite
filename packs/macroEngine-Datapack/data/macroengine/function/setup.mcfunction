# macroengine:setup
# ============================================================================
# Manual (re)initialization entry point.
#
# This function replaces the automatic load flow that used to depend on
# the LanternMC "load" datapack's tag chain
# (#load:_private/load -> #load:pre_load / #load:load / #load:post_load).
# macroEngine no longer needs any 3rd-party "load" dependency: an admin
# runs this function BY HAND ("/function macroengine:setup"), the engine
# initializes itself and its embedded subsystems (StringLib port,
# PlayerAction port), then opens a management screen (dialog).
#
# Why manual: minecraft:load / #load:* tags are REQUIRED to fire on every
# datapack reload, and a broken function added to that tag by a pack
# outside macroEngine could affect macroEngine's own startup too (tag
# "required" behavior, as opposed to silent skip). A manual
# /function macroengine:setup call reduces this external-dependency
# surface to zero: only this pack's own files run.
# ============================================================================

# 1) Start the core engine (scoreboard/storage/config/backport chain).
#    This shortcuts the old chain that reached macroengine.main:macroengine/load
#    (which then called macroengine:core/internal/load/main) indirectly via
#    #load:load, and calls it directly instead.
function macroengine:core/internal/load/main

# 2) Start the embedded StringLib port (macroengine:core/internal/string/*).
#    Note: the split / to_lowercase / to_uppercase internal helper functions
#    are broken because they were already missing in the upstream source —
#    see the WARNING comments in the relevant files. This preserves existing
#    (upstream) behavior.
function macroengine:core/internal/string/zprivate/load

# 3) Start the embedded PlayerAction port (macroengine:core/internal/player/*).
function macroengine:core/internal/player/enumerate
function macroengine:core/internal/player/resolve
function macroengine:core/internal/player/init

# 4) Announce this pack to runtoolkit's registry/list and diagnostics/status
#    tools (METADATA ONLY — this call is not wired to minecraft:load/tick,
#    it's purely informational).
data modify storage runtoolkit:tmp _reg set value {name:"macroengine",version:610,load_fn:"macroengine:setup",tick_fn:"macroengine.main:macroengine/tick",disable_fn:"macroengine:disable"}
function runtoolkit:registry/register with storage runtoolkit:tmp _reg
data remove storage runtoolkit:tmp _reg

# 5) Open the setup/management screen — NOT just a "loaded" message, but
#    an interactive dialog with admin add/remove (macroengine.admin set/unset)
#    and status info. The admin-add button is guarded by an op
#    (permission_level 2+) check, see setup/admin/add_self.
execute if entity @s run function macroengine:setup/open_screen
