# macroEngine — API Reference Docs

Official documentation site for **macroEngine (AME)**, part of the [Runtoolkit](https://github.com/runtoolkit) organization.

[![pack_format](https://img.shields.io/badge/pack__format-94-4ade80?style=flat-square&labelColor=1e2b1f)](https://github.com/runtoolkit/macroEngine-dp)
[![Minecraft](https://img.shields.io/badge/Minecraft-1.21.11-4ade80?style=flat-square&labelColor=1e2b1f)](https://github.com/runtoolkit/macroEngine-dp)
[![License: MIT](https://img.shields.io/badge/License-MIT-4ade80?style=flat-square&labelColor=1e2b1f)](./LICENSE)

---

## Overview

This repository hosts the static HTML documentation for `macroEngine-dp` — a Minecraft Java Edition datapack that provides a fiber-scheduled macro/hook/event engine under the `macro` namespace.

Documentation is structured as a self-contained static site with no build step required.

```
macroEngine-docs/
├── index.html                 # Project hub — lists all documented packages
└── macroEngine-api-docs.html  # Full API reference for macroEngine (AME)
```

---

## Modules

### Core / Runtime

| Module | Description |
|---|---|
| `core/lib — Scheduler` | Tick-based deferred execution and repeating schedules |
| `core/lib — Fiber` | Cooperative coroutine-style multi-step execution |
| `core/queue` | FIFO task queuing across ticks |
| `core/cooldown` | Per-entity and global cooldown tracking |
| `core/lib — IO` | Storage read/write helpers (`macro:input` / `macro:output`) |

### Systems

| Module | Description |
|---|---|
| `systems/flag` | Boolean flag storage per-entity or global |
| `systems/nbt` | NBT manipulation utilities |
| `systems/math` | Integer and float arithmetic helpers |
| `systems/geo` | Coordinate and geometry operations |
| `systems/sound` | Sound playback wrappers |
| `systems/uuid` | UUID generation and parsing |
| `systems/hook` | Named hook registration and dispatch |
| `systems/log` | Debug and structured logging |

### API Layer

| Module | Description |
|---|---|
| `events` | Event bus — publish / subscribe across functions |
| `api/interaction` | Player interaction detection and binding |
| `api/wand` | Item-wand right/left-click binding |
| `api/cmd` | Custom command registration helpers |
| `world` | World-level query utilities |

---

## Storage Convention

macroEngine uses three canonical storage namespaces:

| Namespace | Purpose |
|---|---|
| `macro:input` | Write call arguments before invoking a function |
| `macro:output` | Read return values immediately after a call (ephemeral) |
| `macro:engine` | Internal runtime state — **read-only** for user code |

Never write directly to `macro:engine`.

---

## Usage

Open `macroEngine-docs/index.html` in any modern browser, or serve the directory with any static file server:

```sh
# Python
python3 -m http.server 8080 --directory macroEngine-docs

# Node.js (npx)
npx serve macroEngine-docs
```

Then navigate to `http://localhost:8080`.

---

## Related Repositories

| Repo | Description |
|---|---|
| [runtoolkit/macroEngine-dp](https://github.com/runtoolkit/macroEngine-dp) | The datapack itself (Minecraft Java Edition) |
| [runtoolkit/macro-engine](https://github.com/runtoolkit/macro-engine) | Node.js library port |

---

## License

[MIT](./LICENSE) © 2026 Legends11
