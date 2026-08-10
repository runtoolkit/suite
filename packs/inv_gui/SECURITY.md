# Security Policy — inv_gui

## Supported Versions

| Version | Support Status |
|---|---|
| 1.0.x (current) | ✅ Receives security updates |
| < 1.0.0 | ❌ No support |

---

## Reporting a Vulnerability

**Do not report security vulnerabilities as public issues.**

If you discover a security vulnerability, use GitHub's **[Private Security Advisories](https://github.com/runtoolkit/inv_gui/security/advisories/new)**.

Please include:
- Type and impact of the vulnerability
- Steps to reproduce
- Which version(s) of inv_gui are affected

We aim to respond within **72 hours**.

---

## Datapack Security Notes

### Important Warnings

`inv_gui` is a server-side datapack. Keep the following in mind:

- **`inv_gui:api/setup` should only be run by operators.**
  It contains `forceload` and `setblock` commands; do not expose it to players.

- **Listener functions must not cross trust boundaries.**
  Callbacks run in the `@s` context. Be careful before adding commands targeting `@a` or `@e`.

- **Storage data is server-side only.**
  Do not write untrusted input directly into `inv_gui:data` storage.

- **`Lock:"InvGui"` containers must not be player-accessible.**
  Block player access to coordinates `10000 0-2 10000`.

### Architectural Limitations

Intent-based error detection (i.e. making security decisions based on whether a command succeeded or failed) is not reliable in datapack architecture. `inv_gui` makes security decisions at configuration time and does not rely on runtime error detection.
