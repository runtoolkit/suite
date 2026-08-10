# Contributing to TunnelScript

Thanks for your interest in improving TunnelScript.

## Ground rules

- **English only.** README, code, comments, and documentation are written in
  English so the project stays accessible to a global audience.
- **Versioning.** Keep the strict `MAJOR.MINOR.PATCH` scheme (two dots, three
  numbers, e.g. `1.0.0`).
- **No secrets.** Never commit credentials, access tokens, or any other
  secrets. They must not be embedded in code, configuration, or history.
- **No malicious code.** No hidden payloads, telemetry, data collection, or
  anything resembling malware.
- **No auto-repeat.** Looping/repeating execution is intentionally excluded for
  safety and will not be accepted.

## Project structure

- `data/tunnelscript_core` — internal macros, handlers, iterators, config.
- `data/ts` — the public API surface other packs may call.
- `data/minecraft` — load/tick tags only.
- `tools/build_versions.py` — generates the build for a given game version.

## Building a version

Each game version lives on its own branch. To regenerate the files for a
target:

```bash
python3 tools/build_versions.py 1.21.1   # or 1.21.4, or 1.20.4
```

The generator is deterministic, so output is reproducible across branches.

## Pull requests

1. Keep changes focused and documented.
2. Update `CHANGELOG.md`.
3. Make sure the secret-scan workflow passes.
4. Fill in the pull request template.
