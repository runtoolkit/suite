# LeftClickDetection

A datapack for detecting left-clicks

## Supported Version

* 1.20.3+

## Enable Detection

Enables left-click detection for the executing player.

### Usage

```mcfunction
function left_click_detection:api/enable
```

### Example

```mcfunction
# Enable left-click detection if the executor is sneaking
execute if predicate example:is_sneaking run function left_click_detection:api/enable
```

---

## Disable Detection

Disables left-click detection for the executing player.

### Usage

```mcfunction
function left_click_detection:api/disable
```

### Example

```mcfunction
# Disable left-click detection if the executor is not sneaking
execute unless predicate example:is_sneaking run function left_click_detection:api/disable
```

---

## Set Left-Click Behaviour

1. Add the function(s) to be called on left-click in:
   `data/left_click_detection/tags/functions/callback.json`

```json
{
    "values": [
        "example:on_left_click"
    ]
}
```

2. Define the behaviour inside the added function file:

```mcfunction
#> example:on_left_click

# Display a message
tellraw @s "You just left-clicked!"
```

---

## Notes

* This datapack detects left-clicks by using entity attacks.
  Because of this, players with detection enabled will be unable to perform certain actions (e.g. opening chests).

---

## Known Issues

* Left-clicks targeting entities across chunk boundaries may not be detected.
