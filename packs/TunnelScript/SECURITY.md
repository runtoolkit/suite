# Security Policy

TunnelScript is a general-purpose, multi-action command library. This policy
covers the project as a whole. It is intentionally written in broad terms and
is not tied to any single platform.

## Supported versions

Only the latest released line receives security fixes. Versions use a strict
`MAJOR.MINOR.PATCH` scheme (two dots, three numbers, e.g. `1.0.0`).

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0.0 | :x:                |

## Reporting a vulnerability

Please report suspected vulnerabilities privately. Do **not** open a public
issue for security problems.

1. Use GitHub's private "Report a vulnerability" feature on this repository, or
2. Contact the maintainers through the address listed on the organization
   profile.

When reporting, include:

- A clear description of the issue and its impact.
- Step-by-step reproduction instructions.
- The affected version and environment.

You can expect an acknowledgement within a few business days and a status
update as the investigation proceeds. Coordinated disclosure is appreciated:
please give maintainers a reasonable window to ship a fix before any public
write-up.

## Scope and safe-use notes

- This project ships **no** malicious code, hidden payloads, telemetry, or
  data exfiltration. Distributing modified copies that add such behaviour is
  strictly prohibited and is not endorsed by this project.
- The library executes the actions a user explicitly provides. Treat any
  input from untrusted sources as untrusted, exactly as you would treat any
  scripting input.
- A configurable per-run cooldown and a hard cap on actions per run are
  provided as built-in safety limits. There is **no** automatic repeating or
  looping execution path.
- Never commit credentials, access tokens, or other secrets to this
  repository. Tokens must never be embedded in code, configuration, or commit
  history. If a secret is exposed, rotate it immediately.

## Best practices for integrators

- Keep the action cap and cooldown at values appropriate for your deployment.
- Review action lists before forwarding them from external sources.
- Pin to a known-good release and review the changelog before upgrading.
