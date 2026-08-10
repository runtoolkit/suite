# Changelog — inv_gui

## [1.0.0] — Initial Release

### Added
- Full Sketch-based inventory GUI system under the `inv_gui` namespace
- English documentation (`README.md`, `docs/`)
- Detailed English comments across all `.mcfunction` files
- `pack.mcmeta` version range: 1.20.2–1.20.4 (`pack_format 22–26`)

### Changed
- Namespace: `sketch` → `inv_gui`
- Scoreboards: `Sketch` / `Sketch.Id` / `Sketch.Drop` → `InvGui` / `InvGui.Id` / `InvGui.Drop`
- Entity tags: `Sketch.*` → `InvGui.*`
- Storage: `sketch:` → `inv_gui:data` (main I/O), `inv_gui:core`, `inv_gui:temp`, `inv_gui:util`
- Container lock: `Lock:"Sketch"` → `Lock:"InvGui"`
- Internal dirs: `sketch_player/` → `gui_player/`, `sketch_target/` → `gui_target/`
- Migration system removed (fresh v1.0.0 start)

### Upcoming
- `[ ]` 1.21+ overlay support (`pack_format 48+`)
- `[ ]` Replace external dependencies (OhMyDat, CloseDetector, PlayerItemTuner) with internal implementations
