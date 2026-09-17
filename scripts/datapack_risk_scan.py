#!/usr/bin/env python3
"""
datapack_risk_scan.py

A read-only auditing tool for Minecraft (Java Edition) datapacks.

Purpose
-------
Scans .mcfunction (and function-tag .json) files inside a datapack for
COMMAND PATTERNS that are known to cause real-world problems: server/client
lag, world/data corruption, or griefing potential. It does NOT modify,
block, or disable anything. It produces a Markdown report with:

  - file + line number
  - the offending line
  - WHY it's risky
  - a concrete, safer alternative snippet you can paste in instead

This is meant to save you the "read every .mcfunction by hand" step before
merging or trusting a third-party datapack.

Usage
-----
    python3 datapack_risk_scan.py <path-to-datapack-or-folder> [--out report.md]

Exit code is always 0 -- this tool only reports, it never fails a build by
itself. If you want a CI gate, wrap the JSON summary output (--json) in your
own workflow step and decide the threshold yourself.
"""

import argparse
import json
import re
import sys
from dataclasses import dataclass, field
from pathlib import Path
from typing import Optional


@dataclass
class Finding:
    file: str
    line_no: int
    line: str
    severity: str          # "high" | "medium" | "low"
    rule_id: str
    message: str
    suggestion: Optional[str] = None


@dataclass
class Rule:
    rule_id: str
    pattern: re.Pattern
    severity: str
    message: str
    suggest: "callable"    # fn(match, line) -> str | None


# ---------------------------------------------------------------------------
# Detection rules
# ---------------------------------------------------------------------------

def _suggest_fill_gate(match, line):
    return (
        "Cap the region and gate it behind a manual trigger instead of "
        "letting it run unconditionally, e.g.:\n\n"
        "```mcfunction\n"
        "# only run when explicitly triggered, and keep the region small\n"
        "execute if score #confirm fill_guard matches 1 run "
        + line.strip() + "\n"
        "scoreboard players set #confirm fill_guard 0\n"
        "```\n"
        "If the datapack needs a big region filled, split it into chunk-sized "
        "(<= 32768 blocks, i.e. 32x32x32) batches spread across multiple ticks "
        "with `schedule`, instead of one huge `/fill`."
    )


def _suggest_unscoped_selector(match, line):
    return (
        "Narrow the selector so the command can't hit every player/entity on "
        "the server, e.g. add `distance=..`, `limit=..`, `type=..`, or a "
        "specific `tag=`:\n\n"
        "```mcfunction\n"
        + re.sub(r'@a\b', '@a[distance=..16,limit=1]',
                 re.sub(r'@e\b', '@e[type=minecraft:armor_stand,distance=..16,limit=10]', line.strip()))
        + "\n```"
    )


def _suggest_recursive_tick_gate(match, line):
    return (
        "Add an explicit stop condition so the function can't recurse forever "
        "if its exit condition is never met:\n\n"
        "```mcfunction\n"
        "# top of the function\n"
        "execute unless entity @s[tag=my_loop_active] run return 0\n"
        "\n"
        "# ... loop body ...\n"
        "\n"
        "# only recurse while a counter hasn't hit its cap\n"
        "execute if score #loop_count my_data matches ..200 run "
        "scoreboard players add #loop_count my_data 1\n"
        "execute if score #loop_count my_data matches ..200 run "
        + line.strip() + "\n"
        "```"
    )


def _suggest_gamerule(match, line):
    return (
        "Prefer scoping the effect to specific entities/areas instead of a "
        "global gamerule change, or at least gate it and log it:\n\n"
        "```mcfunction\n"
        "execute if score #allow_gamerule_change config matches 1 run "
        + line.strip() + "\n"
        "tellraw @a [{\"text\":\"[datapack] gamerule changed: "
        + line.strip().replace('"', "'") + "\",\"color\":\"yellow\"}]\n"
        "```"
    )


def _suggest_data_merge(match, line):
    return (
        "Merging arbitrary NBT into a broad target (all players / a whole "
        "storage namespace) can silently corrupt unrelated data. Target a "
        "specific, namespaced storage key and a single entity where possible:\n\n"
        "```mcfunction\n"
        + re.sub(r'@a\b', '@s', line.strip())
        + "\n# and prefer a dedicated namespaced storage over broad merges:\n"
        "# data merge storage yourpack:safe_namespace {your:'data'}\n"
        "```"
    )


def _suggest_kill_summon_spam(match, line):
    return (
        "Unbounded kill/summon in a loop is a common lag + griefing vector. "
        "Add a type filter and a hard cap:\n\n"
        "```mcfunction\n"
        + re.sub(r'@e\b', '@e[type=minecraft:item,limit=20]', line.strip())
        + "\n```"
    )


RULES: list[Rule] = [
    Rule(
        rule_id="FILL_UNBOUNDED",
        pattern=re.compile(r'^\s*(execute[^\n]*run\s+)?(fill|clone)\b', re.IGNORECASE),
        severity="high",
        message="/fill or /clone with no visible size cap or trigger gate -- "
                "can freeze the server if the region is large or runs every tick.",
        suggest=_suggest_fill_gate,
    ),
    Rule(
        rule_id="UNSCOPED_SELECTOR",
        pattern=re.compile(r'@[ae](?!\[)'),
        severity="medium",
        message="Selector @a/@e used without any narrowing arguments "
                "(distance/limit/type/tag) -- affects every matching entity "
                "on the server.",
        suggest=_suggest_unscoped_selector,
    ),
    Rule(
        rule_id="RECURSIVE_TICK",
        pattern=re.compile(r'^\s*(execute[^\n]*run\s+)?function\s+[\w.]+:(\w[\w/]*)\s*$'),
        severity="medium",
        message="Function calls another function with no visible "
                "unless/if guard on the same line -- if this is a tick-loop "
                "self-call, verify there's a stop condition somewhere in the "
                "function body, not just at the call site.",
        suggest=_suggest_recursive_tick_gate,
    ),
    Rule(
        rule_id="GAMERULE_CHANGE",
        pattern=re.compile(r'^\s*gamerule\s+\w+', re.IGNORECASE),
        severity="low",
        message="Global gamerule change -- affects the whole world/server, "
                "not just this datapack's scope.",
        suggest=_suggest_gamerule,
    ),
    Rule(
        rule_id="DATA_MERGE_BROAD",
        pattern=re.compile(r'^\s*(execute[^\n]*run\s+)?data\s+merge\s+(entity\s+@a|storage\s+minecraft:)', re.IGNORECASE),
        severity="high",
        message="`data merge` targeting all players or a vanilla storage "
                "namespace -- can corrupt player/world data outside this "
                "datapack's own namespace.",
        suggest=_suggest_data_merge,
    ),
    Rule(
        rule_id="KILL_SUMMON_UNSCOPED",
        pattern=re.compile(r'^\s*(execute[^\n]*run\s+)?(kill|summon)\s+@e(?!\[)', re.IGNORECASE),
        severity="high",
        message="kill/summon against @e with no type filter or limit -- "
                "common source of both lag and griefing.",
        suggest=_suggest_kill_summon_spam,
    ),
]

SEVERITY_ORDER = {"high": 0, "medium": 1, "low": 2}


def scan_file(path: Path) -> list[Finding]:
    findings: list[Finding] = []
    try:
        text = path.read_text(encoding="utf-8", errors="replace")
    except Exception as e:
        return [Finding(str(path), 0, "", "medium", "READ_ERROR", f"Could not read file: {e}")]

    for line_no, line in enumerate(text.splitlines(), start=1):
        stripped = line.strip()
        if not stripped or stripped.startswith("#"):
            continue
        for rule in RULES:
            m = rule.pattern.search(line)
            if m:
                findings.append(
                    Finding(
                        file=str(path),
                        line_no=line_no,
                        line=stripped,
                        severity=rule.severity,
                        rule_id=rule.rule_id,
                        message=rule.message,
                        suggestion=rule.suggest(m, line),
                    )
                )
    return findings


def scan_json_function_tag(path: Path) -> list[Finding]:
    """Sanity-check function tag JSON files (data/*/tags/functions/*.json)."""
    findings = []
    try:
        obj = json.loads(path.read_text(encoding="utf-8", errors="replace"))
    except json.JSONDecodeError as e:
        return [Finding(str(path), e.lineno, "", "medium", "INVALID_JSON",
                         f"Malformed JSON: {e.msg}")]
    values = obj.get("values", []) if isinstance(obj, dict) else []
    if "minecraft:tick" in str(path).replace("\\", "/") and len(values) > 20:
        findings.append(
            Finding(
                file=str(path), line_no=0, line="",
                severity="low", rule_id="MANY_TICK_FUNCTIONS",
                message=f"{len(values)} functions registered on minecraft:tick "
                        "-- each one runs every single tick (20x/sec). Verify "
                        "they all need to.",
                suggestion="Move anything that doesn't need per-tick precision "
                           "to a `schedule function ... <delay>` call instead "
                           "of a permanent tick-tag entry.",
            )
        )
    return findings


def find_target_files(root: Path):
    for p in root.rglob("*.mcfunction"):
        yield p, "function"
    for p in root.rglob("*.json"):
        if "/tags/functions/" in str(p).replace("\\", "/") or "\\tags\\functions\\" in str(p):
            yield p, "tag"


def render_markdown(findings: list[Finding], root: Path) -> str:
    findings_sorted = sorted(findings, key=lambda f: (SEVERITY_ORDER.get(f.severity, 9), f.file, f.line_no))
    counts = {"high": 0, "medium": 0, "low": 0}
    for f in findings_sorted:
        counts[f.severity] = counts.get(f.severity, 0) + 1

    lines = []
    lines.append(f"# Datapack Risk Scan Report")
    lines.append("")
    lines.append(f"Scanned: `{root}`")
    lines.append("")
    lines.append(f"**Summary:** {counts['high']} high, {counts['medium']} medium, "
                  f"{counts['low']} low severity findings.")
    lines.append("")
    if not findings_sorted:
        lines.append("No risky patterns detected by the current rule set. "
                      "This does not guarantee the datapack is safe -- it "
                      "only means it didn't match known risky patterns.")
        return "\n".join(lines)

    lines.append("| Severity | Rule | File | Line |")
    lines.append("|---|---|---|---|")
    for f in findings_sorted:
        loc = f"{Path(f.file).relative_to(root) if root in Path(f.file).parents or Path(f.file) == root else f.file}:{f.line_no}"
        lines.append(f"| {f.severity.upper()} | `{f.rule_id}` | {loc} |")
    lines.append("")
    lines.append("---")
    lines.append("")

    for f in findings_sorted:
        lines.append(f"## [{f.severity.upper()}] {f.rule_id} -- {f.file}:{f.line_no}")
        lines.append("")
        if f.line:
            lines.append("```mcfunction")
            lines.append(f.line)
            lines.append("```")
        lines.append(f"**Why:** {f.message}")
        lines.append("")
        if f.suggestion:
            lines.append(f"**Suggested alternative:**")
            lines.append("")
            lines.append(f.suggestion)
        lines.append("")
        lines.append("---")
        lines.append("")

    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(description="Scan a Minecraft datapack for risky command patterns.")
    parser.add_argument("path", type=Path, help="Path to a datapack folder (or any folder containing .mcfunction files)")
    parser.add_argument("--out", type=Path, default=None, help="Write the Markdown report to this file (default: stdout)")
    parser.add_argument("--json", action="store_true", help="Also print a machine-readable JSON summary to stderr")
    args = parser.parse_args()

    root = args.path
    if not root.exists():
        print(f"Path does not exist: {root}", file=sys.stderr)
        sys.exit(1)

    all_findings: list[Finding] = []
    for path, kind in find_target_files(root):
        if kind == "function":
            all_findings.extend(scan_file(path))
        else:
            all_findings.extend(scan_json_function_tag(path))

    report = render_markdown(all_findings, root)

    if args.out:
        args.out.write_text(report, encoding="utf-8")
        print(f"Report written to {args.out}", file=sys.stderr)
    else:
        print(report)

    if args.json:
        summary = [
            {"file": f.file, "line": f.line_no, "severity": f.severity, "rule": f.rule_id}
            for f in all_findings
        ]
        print(json.dumps(summary, indent=2), file=sys.stderr)

    # Always exit 0: this is an advisory report, not a gate.
    sys.exit(0)


if __name__ == "__main__":
    main()
