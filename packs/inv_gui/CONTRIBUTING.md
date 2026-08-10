# Contributing Guide — inv_gui

Thank you for your interest in contributing! Follow the steps below to make the process smooth.

---

## Table of Contents

- [Bug Reports](#bug-reports)
- [Feature Requests](#feature-requests)
- [Code Contributions](#code-contributions)
- [Commit Message Guidelines](#commit-message-guidelines)
- [Style Guide](#style-guide)

---

## Bug Reports

If you find a bug, please provide:

1. **inv_gui version** (output of `/data get storage inv_gui:data Version`)
2. **Minecraft version**
3. **Steps to reproduce**
4. **Expected behavior** — what did you expect to happen?
5. **Actual behavior** — what happened instead?
6. **`/datapack list` output** — which datapacks are loaded?

---

## Feature Requests

Before opening a feature request, check existing issues for duplicates.
If none exist, open a new issue and describe:

- What problem does it solve?
- How should it work?
- How does it integrate with the existing API?

---

## Code Contributions

### 1. Fork & Clone

```bash
git clone https://github.com/YOUR_USERNAME/inv_gui.git
cd inv_gui
```

### 2. Create a Branch

```bash
git checkout -b feat/my-feature
# or
git checkout -b fix/bug-description
```

### 3. Make Changes

- Edit `.mcfunction` files under `data/inv_gui/functions/`
- Add English comments to every function
- Update `declare.mcfunction` if you add new public API

### 4. Test

```mcfunction
/reload
/data get storage inv_gui:data Version
```

### 5. Open a Pull Request

- Use the commit convention for the PR title
- Explain what you changed and why
- Link the related issue if applicable: `Closes #42`

---

## Commit Message Guidelines

We use [Conventional Commits](https://www.conventionalcommits.org):

```
<type>: <short description>

[optional body]
```

**Types:**

| Type | Description |
|---|---|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `refactor` | Neither a fix nor a feature |
| `perf` | Performance improvement |
| `chore` | Build system, dependency update |

**Examples:**

```
feat: add on_refresh event tag system
fix: chest_minecart set_menu slot offset error
docs: update api.md register section
```

---

## Style Guide

### .mcfunction Files

```mcfunction
#> inv_gui:datamodule/function
#
# English description of what this function does.
# Multiple lines are fine.
#
# @input
#   storage inv_gui:data in
#       field: type — description
#
# @within function inv_gui:dataparent_function

# -- Section heading --
    command
    command

# Clean up temporary data.
    data remove storage inv_gui:data in
```

**Rules:**
- 4-space indentation (no tabs)
- English comment before every meaningful block
- Preserve the `# Clean up temporary data.` pattern
- Separate logical blocks with blank lines
