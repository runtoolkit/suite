# GUI Maker Fabric (1.21.1)

Java-only Fabric conversion of the original GUI Maker datapack:
- Target: Minecraft 1.21.1 + Fabric
- No internal `mcfunction` usage
- Multiplayer-safe persistent server state

## What is implemented

- Persistent GUI profiles/pages in Java (`PersistentState`)
- Virtual chest-style GUIs opened directly from Fabric code
- Multiplayer-safe per-player caching for:
  - Item Holders
  - Toggle Buttons
- GUI export/import as a custom barrel item
- Datapack-like slot metadata parsing from item `custom_data.gui`
- Server commands for creating, editing, deleting, exporting, importing and opening GUIs
- Java callback registry for button functions
- Java item-modifier registry for dynamic item rendering

## Core commands

### Create/list/delete
- `/guimaker profile create`
- `/guimaker profile list`
- `/guimaker profile delete <guiId>`

### Capture pages from a container block below the player
- `/guimaker page capture <guiId>`
- `/guimaker page capture <guiId> <name...>`
- `/guimaker page list <guiId>`
- `/guimaker page rename <guiId> <page> <name...>`
- `/guimaker page delete <guiId> <page>`

### Open GUI for players
- `/guimaker open <targets> <guiId>`
- `/guimaker open <targets> <guiId> <page>`

### Special items
- `/guimaker items`

This gives:
- Item Holder [UNCACHED]
- Item Holder [CACHED]
- Toggle Button [UNCACHED]
- Toggle Button [CACHED]
- Data Driven Item Button
- Data Driven Page Creator

### Edit slot config
- `/guimaker slot icon <guiId> <page> <slot>` (copies mainhand item)
- `/guimaker slot type <guiId> <page> <slot> <simple|holder|toggle|data_button|data_page_creator>`
- `/guimaker slot cached <guiId> <page> <slot> <true|false>`
- `/guimaker slot togglelist <guiId> <page> <slot>` (captures states from container below player)
- `/guimaker slot clear <guiId> <page> <slot>`

### Edit slot actions
- `/guimaker slot action clear <guiId> <page> <slot>`
- `/guimaker slot action command <guiId> <page> <slot> <command...>`
- `/guimaker slot action function <guiId> <page> <slot> <namespace:id>`
- `/guimaker slot action itemmodifier <guiId> <page> <slot> <namespace:id>`
- `/guimaker slot action sound <guiId> <page> <slot> <namespace:id>`
- `/guimaker slot action changemenu <guiId> <page> <slot> <targetGuiId> <targetPage>`

### Import / export
- `/guimaker export <guiId>`
- `/guimaker export <guiId> <targets>`
- `/guimaker import`

Hold the exported barrel in your main hand and run `/guimaker import`.

## Java extension points

### Button callback registry
Register callbacks through `GuiMakerApi.registerButtonCallback(...)`.

Built-ins:
- `guimaker:close`
- `guimaker:refresh`
- `guimaker:message`

### Item modifier registry
Register item modifiers through `GuiMakerApi.registerItemModifier(...)`.

Built-in:
- `guimaker:noop`

## Notes

- This mod intentionally replaces the datapack's command-function backend with Java logic.
- The chest GUI is virtual; it is not implemented through marker entities + tick polling.
- `data_driven_button` and `data_driven_page_creator` are recognized and preserved, but their advanced datapack behavior is left as extension points for future Java-side expansion.
- The workspace environment used to generate this project does not include Java 21, so the project was prepared but not built inside the sandbox.

## Build

Use Java 21.

```bash
./gradlew build
```
