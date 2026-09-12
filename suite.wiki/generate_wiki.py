#!/usr/bin/env python3
"""
generate_wiki.py

Scans the runtoolkit/suite monorepo and generates GitHub Wiki pages for
every sub-project under mods/, packs/, scripts/, examples/, archived/,
other/.

Unlike a plain README-copy approach, this version builds each page from
several sources, in priority order, and merges what it finds instead of
stopping at the first hit:

  1. README.md (title + first summary paragraph)
  2. Structured metadata files:
       - fabric.mod.json / mods.toml           (Fabric/Forge mods)
       - pack.mcmeta                            (datapacks / resource packs)
       - package.json                           (Node.js tools)
  3. Source code scan (for a "Modules" section and, when no README/metadata
     description exists at all, as the last-resort summary source):
       - Java:  package/class tree + the first class-level Javadoc block
         found in each subproject
       - Python: module docstrings
       - JavaScript/TypeScript: leading block comments

This means a sub-project with NO README (e.g. one that only ships a
fabric.mod.json and Java sources) still gets a real, non-empty wiki page.

Usage:
    python generate_wiki.py <path-to-suite-repo> <path-to-suite.wiki-repo>

Example:
    python generate_wiki.py ./suite ./suite.wiki

Output: Markdown files are written into <path-to-suite.wiki-repo>, including
a generated Home.md index. This script does NOT run any git commands
(no commit, no push) — see KURULUM_KULLANIM.md / SETUP_GUIDE.md for that step.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from dataclasses import dataclass, field
from pathlib import Path

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

CATEGORIES: dict[str, str] = {
    "mods": "Fabric Mods",
    "packs": "Datapacks / Resource Packs",
    "scripts": "Scripts & Tools",
    "examples": "Examples & Templates",
    "archived": "Archived",
    "other": "Other",
}

# Directories we never want to walk into when scanning source code
# (build output, VCS metadata, dependency caches).
SKIP_DIR_NAMES = {
    ".git", ".gradle", ".idea", ".vscode", "build", "node_modules",
    "out", "target", "dist", ".github",
}

MAX_JAVA_FILES_LISTED = 40
MAX_SCRIPT_FILES_LISTED = 40

_SLUG_RE = re.compile(r"[^A-Za-z0-9._-]+")


def slugify(name: str) -> str:
    """Turns a sub-project name into a safe GitHub wiki page filename."""
    cleaned = _SLUG_RE.sub("-", name.strip())
    return cleaned.strip("-") or "unnamed"


def iter_files(root: Path, suffix: str) -> list[Path]:
    """Recursively collects files with the given suffix, skipping build/VCS dirs."""
    results: list[Path] = []
    for path in root.rglob(f"*{suffix}"):
        if any(part in SKIP_DIR_NAMES for part in path.parts):
            continue
        if path.is_file():
            results.append(path)
    return sorted(results)


# ---------------------------------------------------------------------------
# README parsing
# ---------------------------------------------------------------------------

def find_readme(project_dir: Path) -> Path | None:
    for candidate in ("README.md", "readme.md", "Readme.md"):
        p = project_dir / candidate
        if p.is_file():
            return p
    return None


def extract_title_and_summary(readme_text: str, fallback_name: str) -> tuple[str, str]:
    """Extracts the title (first '# ...' line) and the first non-empty
    paragraph that follows it."""
    lines = readme_text.splitlines()
    title = fallback_name
    summary_lines: list[str] = []
    title_found = False

    i = 0
    while i < len(lines):
        line = lines[i].strip()
        if line.startswith("# "):
            title = line[2:].strip()
            title_found = True
            i += 1
            break
        i += 1

    if not title_found:
        i = 0

    while i < len(lines) and lines[i].strip() == "":
        i += 1
    while i < len(lines) and lines[i].strip() != "":
        stripped = lines[i].strip()
        if stripped.startswith("#"):
            break
        summary_lines.append(stripped)
        i += 1

    return title, " ".join(summary_lines).strip()


# ---------------------------------------------------------------------------
# Structured metadata parsing (fabric.mod.json / pack.mcmeta / package.json)
# ---------------------------------------------------------------------------

@dataclass
class MetadataResult:
    source_file: str
    display_name: str | None = None
    description: str | None = None
    extra_lines: list[str] = field(default_factory=list)


def read_fabric_mod_json(project_dir: Path) -> MetadataResult | None:
    matches = list(project_dir.rglob("fabric.mod.json"))
    matches = [m for m in matches if not any(p in SKIP_DIR_NAMES for p in m.parts)]
    if not matches:
        return None
    path = matches[0]
    try:
        data = json.loads(path.read_text(encoding="utf-8", errors="replace"))
    except (json.JSONDecodeError, OSError):
        return None

    name = data.get("name")
    description = data.get("description")
    extra = []
    depends = data.get("depends", {})
    if isinstance(depends, dict) and depends:
        dep_str = ", ".join(f"`{k}: {v}`" for k, v in depends.items())
        extra.append(f"**Declared dependencies:** {dep_str}")
    license_ = data.get("license")
    if license_:
        extra.append(f"**License (from fabric.mod.json):** {license_}")

    return MetadataResult(
        source_file=str(path.relative_to(project_dir)),
        display_name=name,
        description=description if description and "example description" not in description.lower() else None,
        extra_lines=extra,
    )


def read_pack_mcmeta(project_dir: Path) -> MetadataResult | None:
    matches = list(project_dir.rglob("pack.mcmeta"))
    matches = [m for m in matches if not any(p in SKIP_DIR_NAMES for p in m.parts)]
    if not matches:
        return None
    path = matches[0]
    try:
        data = json.loads(path.read_text(encoding="utf-8", errors="replace"))
    except (json.JSONDecodeError, OSError):
        return None

    pack = data.get("pack", {})
    description = pack.get("description")
    extra = []
    pack_format = pack.get("pack_format")
    if pack_format is not None:
        extra.append(f"**Pack format:** {pack_format}")
    features = data.get("features", {}).get("enabled")
    if features:
        extra.append(f"**Enabled features:** {', '.join(features)}")

    return MetadataResult(
        source_file=str(path.relative_to(project_dir)),
        display_name=None,
        description=description if isinstance(description, str) else None,
        extra_lines=extra,
    )


def read_package_json(project_dir: Path) -> MetadataResult | None:
    path = project_dir / "package.json"
    if not path.is_file():
        return None
    try:
        data = json.loads(path.read_text(encoding="utf-8", errors="replace"))
    except (json.JSONDecodeError, OSError):
        return None

    name = data.get("name")
    description = data.get("description") or None
    extra = []
    deps = data.get("dependencies", {})
    if deps:
        extra.append(f"**Dependencies:** {', '.join(sorted(deps.keys()))}")
    license_ = data.get("license")
    if license_:
        extra.append(f"**License (from package.json):** {license_}")

    return MetadataResult(
        source_file="package.json",
        display_name=name,
        description=description,
        extra_lines=extra,
    )


def gather_metadata(project_dir: Path) -> list[MetadataResult]:
    results = []
    for reader in (read_fabric_mod_json, read_pack_mcmeta, read_package_json):
        result = reader(project_dir)
        if result is not None:
            results.append(result)
    return results


# ---------------------------------------------------------------------------
# Source code scanning (Java / Python / JS-TS)
# ---------------------------------------------------------------------------

_JAVA_PACKAGE_RE = re.compile(r"^\s*package\s+([\w.]+)\s*;", re.MULTILINE)
_JAVA_CLASS_RE = re.compile(r"^\s*(?:public\s+)?(?:final\s+)?(?:abstract\s+)?class\s+(\w+)", re.MULTILINE)
_JAVA_JAVADOC_RE = re.compile(r"/\*\*(.*?)\*/", re.DOTALL)
_PY_DOCSTRING_RE = re.compile(r'^\s*(?:"""(.*?)"""|\'\'\'(.*?)\'\'\')', re.DOTALL)
_JS_LEADING_COMMENT_RE = re.compile(r"^\s*/\*\*?(.*?)\*/", re.DOTALL)


def clean_javadoc(raw: str) -> str:
    lines = raw.splitlines()
    cleaned = []
    for line in lines:
        line = line.strip()
        line = re.sub(r"^\*\s?", "", line)
        if line.startswith("@"):
            break  # stop at the first @param/@author/etc. tag block
        cleaned.append(line)
    text = " ".join(l for l in cleaned if l).strip()
    return text


def scan_java_sources(project_dir: Path) -> tuple[list[str], str | None]:
    """Returns (list of 'package.ClassName' entries, best Javadoc summary found)."""
    java_files = iter_files(project_dir, ".java")
    entries: list[str] = []
    best_doc: str | None = None

    for jf in java_files:
        try:
            text = jf.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue

        pkg_match = _JAVA_PACKAGE_RE.search(text)
        package = pkg_match.group(1) if pkg_match else None
        class_match = _JAVA_CLASS_RE.search(text)
        class_name = class_match.group(1) if class_match else jf.stem

        entries.append(f"{package + '.' if package else ''}{class_name}")

        if best_doc is None:
            doc_match = _JAVA_JAVADOC_RE.search(text)
            if doc_match:
                candidate = clean_javadoc(doc_match.group(1))
                # Prefer a substantial, class-level doc comment over a
                # one-word/trivial one.
                if len(candidate) > 40:
                    best_doc = candidate

    return entries, best_doc


def scan_python_sources(project_dir: Path) -> tuple[list[str], str | None]:
    py_files = iter_files(project_dir, ".py")
    entries: list[str] = []
    best_doc: str | None = None

    for pf in py_files:
        try:
            text = pf.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        entries.append(str(pf.relative_to(project_dir)))

        if best_doc is None:
            match = _PY_DOCSTRING_RE.match(text.lstrip("\ufeff"))
            if match:
                candidate = (match.group(1) or match.group(2) or "").strip()
                candidate = " ".join(line.strip() for line in candidate.splitlines() if line.strip())
                if len(candidate) > 30:
                    best_doc = candidate

    return entries, best_doc


def scan_js_sources(project_dir: Path) -> tuple[list[str], str | None]:
    entries: list[str] = []
    best_doc: str | None = None
    for suffix in (".js", ".ts"):
        for jf in iter_files(project_dir, suffix):
            try:
                text = jf.read_text(encoding="utf-8", errors="replace")
            except OSError:
                continue
            entries.append(str(jf.relative_to(project_dir)))
            if best_doc is None:
                match = _JS_LEADING_COMMENT_RE.match(text.lstrip("\ufeff"))
                if match:
                    candidate = clean_javadoc(match.group(1))
                    if len(candidate) > 30:
                        best_doc = candidate
    return sorted(set(entries)), best_doc


@dataclass
class CodeScanResult:
    language: str
    modules: list[str]
    doc_summary: str | None


def scan_source_code(project_dir: Path) -> list[CodeScanResult]:
    results = []

    java_entries, java_doc = scan_java_sources(project_dir)
    if java_entries:
        results.append(CodeScanResult("Java", java_entries, java_doc))

    py_entries, py_doc = scan_python_sources(project_dir)
    if py_entries:
        results.append(CodeScanResult("Python", py_entries, py_doc))

    js_entries, js_doc = scan_js_sources(project_dir)
    if js_entries:
        results.append(CodeScanResult("JavaScript/TypeScript", js_entries, js_doc))

    return results


# ---------------------------------------------------------------------------
# Page assembly
# ---------------------------------------------------------------------------

def build_project_page(category_key: str, project_dir: Path, repo_root: Path) -> tuple[str, str, str]:
    """Builds a single wiki page for one sub-project.
    Returns (wiki_filename_without_ext, page_title, page_markdown)."""

    name = project_dir.name
    rel_path = project_dir.relative_to(repo_root).as_posix()
    github_link = f"https://github.com/runtoolkit/suite/tree/main/{rel_path}"

    readme_path = find_readme(project_dir)
    readme_title: str | None = None
    readme_summary: str | None = None
    if readme_path is not None:
        text = readme_path.read_text(encoding="utf-8", errors="replace")
        readme_title, readme_summary = extract_title_and_summary(text, name)

    metadata_results = gather_metadata(project_dir)
    code_results = scan_source_code(project_dir)

    # --- Resolve title ---
    title = readme_title
    if not title or title == name:
        for meta in metadata_results:
            if meta.display_name:
                title = meta.display_name
                break
    if not title:
        title = name

    # --- Resolve summary description (priority: README > metadata > code docstring) ---
    summary = readme_summary or None
    summary_source = "README" if summary else None

    if not summary:
        for meta in metadata_results:
            if meta.description:
                summary = meta.description
                summary_source = meta.source_file
                break

    if not summary:
        for code in code_results:
            if code.doc_summary:
                summary = code.doc_summary
                summary_source = f"{code.language} source comment"
                break

    if not summary:
        summary = "_No description could be found in the README, package metadata, or source comments for this sub-project._"

    # --- Build page body ---
    parts: list[str] = [f"# {title}", "", summary]

    if summary_source and summary_source != "README":
        parts.append("")
        parts.append(f"*(Description automatically extracted from `{summary_source}`.)*")

    # Metadata section
    if metadata_results:
        parts.append("")
        parts.append("## Metadata")
        parts.append("")
        for meta in metadata_results:
            parts.append(f"**Source:** `{meta.source_file}`")
            for line in meta.extra_lines:
                parts.append(f"- {line}")
            parts.append("")

    # Modules / code structure section
    if code_results:
        parts.append("## Modules")
        parts.append("")
        for code in code_results:
            parts.append(f"### {code.language}")
            parts.append("")
            if code.doc_summary and code.doc_summary != summary:
                parts.append(f"> {code.doc_summary}")
                parts.append("")
            shown = code.modules[:MAX_JAVA_FILES_LISTED]
            for entry in shown:
                parts.append(f"- `{entry}`")
            remaining = len(code.modules) - len(shown)
            if remaining > 0:
                parts.append(f"- _...and {remaining} more file(s)_")
            parts.append("")

    # Source / links section
    parts.append("## Source")
    parts.append("")
    parts.append(f"- Path in repo: `{rel_path}`")
    parts.append(f"- [View on GitHub]({github_link})")
    if readme_path is not None:
        parts.append(f"- Full README: [{readme_path.name}]({github_link}/{readme_path.name})")
    else:
        parts.append("- This sub-project has no README.md; this page was generated entirely from metadata files and source code comments.")

    parts.append("")
    parts.append("---")
    parts.append("_This page was generated automatically by `generate_wiki.py` from the README, package metadata, and source code of this sub-project. Manual edits will be overwritten the next time the script runs._")

    page_filename = f"{slugify(category_key)}-{slugify(name)}"
    return page_filename, title, "\n".join(parts)


def build_home_page(index_by_category: dict[str, list[tuple[str, str]]]) -> str:
    lines = [
        "# runtoolkit/suite Wiki",
        "",
        "This wiki is automatically generated from the README files, package metadata "
        "(fabric.mod.json / pack.mcmeta / package.json), and source code comments of every "
        "sub-project in [runtoolkit/suite](https://github.com/runtoolkit/suite).",
        "",
    ]

    for category_key, pages in index_by_category.items():
        if not pages:
            continue
        display_name = CATEGORIES.get(category_key, category_key)
        lines.append(f"## {display_name}")
        lines.append("")
        for page_filename, title in sorted(pages, key=lambda x: x[1].lower()):
            lines.append(f"- [{title}]({page_filename})")
        lines.append("")

    lines.append("---")
    lines.append("_This page was generated automatically by `generate_wiki.py`._")
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> int:
    parser = argparse.ArgumentParser(
        description="Automatically generates GitHub Wiki pages for runtoolkit/suite "
                    "by reading READMEs, package metadata, and source code."
    )
    parser.add_argument("suite_repo", type=Path, help="Path to the cloned runtoolkit/suite repo")
    parser.add_argument("wiki_repo", type=Path, help="Path to the cloned suite.wiki repo (created if missing)")
    args = parser.parse_args()

    suite_repo: Path = args.suite_repo.resolve()
    wiki_repo: Path = args.wiki_repo.resolve()

    if not suite_repo.is_dir():
        print(f"ERROR: suite repo path not found: {suite_repo}", file=sys.stderr)
        return 1

    wiki_repo.mkdir(parents=True, exist_ok=True)

    index_by_category: dict[str, list[tuple[str, str]]] = {key: [] for key in CATEGORIES}
    total_pages = 0

    for category_key in CATEGORIES:
        category_dir = suite_repo / category_key
        if not category_dir.is_dir():
            continue

        for project_dir in sorted(category_dir.iterdir()):
            if not project_dir.is_dir() or project_dir.name.startswith("."):
                continue

            page_filename, title, page_content = build_project_page(category_key, project_dir, suite_repo)
            out_path = wiki_repo / f"{page_filename}.md"
            out_path.write_text(page_content, encoding="utf-8")
            index_by_category[category_key].append((page_filename, title))
            total_pages += 1
            print(f"Wrote: {out_path.relative_to(wiki_repo)}")

    home_content = build_home_page(index_by_category)
    (wiki_repo / "Home.md").write_text(home_content, encoding="utf-8")
    print("Wrote: Home.md")

    print(f"\nGenerated {total_pages} sub-project page(s) + 1 Home.md -> {wiki_repo}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
