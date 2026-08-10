#> inv_gui:core/migration/2.0.2/_
# @within function inv_gui:core/load

# Version setup
    data modify storage inv_gui:data Version set value "2.0.2"

# Fix issue where arguments of inv_gui:util/map/delete are not cleared (#8)
    data remove storage inv_gui:util in
