# The Constitution — an AI Governance Rule Book

**One rule book every AI tool I run or ship must obey.** A single, security- and privacy-forward
source of truth that covers safety, honesty, privacy, security, deployment, conduct, and enforcement —
so my AI tools behave consistently and I never have to repeat myself.

Modeled on the framework of [Claude's Constitution](https://www.anthropic.com/) (Anthropic, Jan 2026,
released CC0), then made my own: my values, my workflow, and the security knowledge I rely on it to
carry — because I'm a vibe coder, and the AI catches what I'd miss.

> **Read the law:** [`00 - THE CONSTITUTION (Master).md`](./00%20-%20THE%20CONSTITUTION%20(Master).md)

---

## What's inside

| Folder | What it holds |
|---|---|
| **`00 - THE CONSTITUTION (Master).md`** | **The law.** The single source of truth (v0.6). Start here. |
| **`01 - Old Constitution`** | The character & values layer + the Claude's-Constitution reference it's modeled on |
| **`02 - New Constitution`** | The security & policing layer — enforceable Articles + the five police agents |
| **`03 - Source Material`** | The four security guides (junior → attacker) behind the security rules |
| **`04 - Amendments & Versions`** | Frozen, read-only snapshots of every released version + the changelog |
| **`00 - README (Start Here)`** | The in-project navigation guide |

## How it works — a three-layer living system

```
HOOKS      reflexes     auto-block catastrophic shell/git before it runs
GUARDIANS  inspectors   proactive, per-domain — catch & BLOCK issues BEFORE they ship
POLICE     the courts   investigate · judge · sanction violations to a tamper-evident Record
```

- **Maximum enforcement** — the AI proactively catches, warns, and **blocks** insecure code, leaked
  secrets, and non-compliant launches *by default*.
- **Hard Lines** — a small set of bright lines no instruction can cross.
- **Guardians** — Keymaster (secrets), Privacy Officer, Security Reviewer, Supply-Chain Sentinel,
  Launch Marshal — each enforcing one Part.
- **A human always holds the final word.**

## The domains it governs

Safety · Honesty & Truth · Privacy & Data Protection (GDPR/CCPA-aware) · Security (OWASP-aligned) ·
Deployment & Secure Launch (web · iOS · Android · macOS) · Scope & Authority · Outward Boundaries ·
Conduct · Enforcement · Amendment — plus a references schedule of the authoritative standards
(OWASP ASVS/MASVS, Apple notarization, Play security, SLSA, NIST SSDF, CIS Benchmarks).

## Use it yourself

It's CC0 — public domain. Fork it, strip my personal parts, keep the framework, make it yours.

## License

Released under [CC0 1.0 Universal](./LICENSE) — no rights reserved. Use it for any purpose without
asking, just as Claude's Constitution was released for anyone to build on.
