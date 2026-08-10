#> inv_gui:core/api/fill_checker/_
#
# @within function inv_gui:api/fill_checker

data modify storage inv_gui:temp FillChecker set from storage inv_gui:data in
data remove storage inv_gui:data in.key_a
data remove storage inv_gui:data in.key_b

# Row 0: a b a b a b a b a
function inv_gui:core/api/fill_checker/row_ab with storage inv_gui:temp FillChecker

# Row 1: b a b a b a b a b
function inv_gui:core/api/fill_checker/row_ba with storage inv_gui:temp FillChecker

# Row 2: a b a b a b a b a
function inv_gui:core/api/fill_checker/row_ab with storage inv_gui:temp FillChecker

data remove storage inv_gui:temp FillChecker
