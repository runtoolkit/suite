> **⚠️ ARCHIVED / MOVED**
>
> This repository (`runtoolkit/suite`) is **archived** and no longer maintained.
>
> All further development continues at:
> **https://github.com/vortacraftmc/core**
>
> Please open issues, PRs, and use the latest releases from the new repository.
> This repo is kept only as a historical snapshot.

# Datapack Blocker

A Fabric mod (1.21.1) that locks a world's `datapacks/` folder instead of
leaving it open to arbitrary drop-in changes.

## What it does

On server start:

1. **First run on a world** - every top-level entry currently in
   `datapacks/` (a folder or a `.zip`) is recorded as the allowlist for
   that world. Nothing is blocked yet; this just establishes a baseline.
2. **Every run after that** - the folder is compared against the
   allowlist:
   - Anything **not** on the allowlist is moved out into
     `<world>/datapack_blocker/quarantine/<timestamp>/` instead of being
     left for the server to load. It is not deleted.
   - Everything that **is** on the allowlist has its write permission
     stripped recursively, so it can't be edited or deleted in place.

## Commands

All under `/datapackblocker`, op-only (permission level 4):

| Command | What it does |
|---|---|
| `status` | Lists what's currently sitting in quarantine. |
| `approve <name>` | Moves a quarantined pack back into `datapacks/`, adds it to the allowlist, and locks it. Run `/reload` afterward to actually load it. |
| `unlock` | Temporarily restores write access to every allowlisted pack, for maintenance. |
| `lock` | Re-locks everything after a maintenance window. |

## Scope and limitations

This is a tripwire for the common case - someone drops a new pack in the
folder and the server restarts - not a hard security boundary:

- Enforcement runs at **server start**. A pack added mid-session and
  picked up by a live `/reload` is not caught until the next restart.
- "Read-only" is best-effort via `File#setWritable`. On POSIX filesystems
  this also strips the directory's write bit (blocking adds/removes
  inside it); on Windows it maps to the read-only file attribute, which
  behaves differently. It does nothing against anyone with direct
  filesystem/shell access to the host - that's outside what a Fabric mod
  can enforce from inside the game.
- Comparison is by file/folder **name** only, not content hashing. A pack
  that was already edited before this mod's first run on that world gets
  allowlisted as-is.

## Why this exists

This complements the `packs/` maintenance-mode policy described in the
repo root README: for servers that want to keep running existing
datapacks but stop accepting new ones without review, this mod enforces
that boundary automatically instead of relying on an operator remembering
to check the folder by hand.
