# Version v0.3 — 2026-06-13 (APPROVED & LIVE)

Frozen snapshot of the constitution as released at v0.3. **Do not edit these files** — this is history.
The living copy continues as `00 - THE CONSTITUTION (Master).md` in the project root.

## What this version contains
- `THE CONSTITUTION v0.3 (Master).md` — the promoted master: one security/privacy/deployment-forward rule book.
- `THE RULEBOOK v0.2 (retired).md` — the prior consolidated rulebook, retired and preserved here.

## What changed since v0.2
- **Consolidated into ONE master** (`THE CONSTITUTION (Master)`), replacing the scattered v0.2 Rulebook. Single source of truth.
- **★ 10 Commandments** cheat sheet added up front.
- **Hard Lines expanded** — public env-prefix secrets, public-DB-key-without-RLS, never disable cert validation, no secret in client/binary, no irreversible prod change without tested rollback + human OK.
- **Part 4 Privacy & Data Protection — heavy rewrite** (real PII): consent mechanics, purpose limitation, true-deletion, COPPA, DPAs, GDPR/CCPA day-one.
- **Part 5 Security — deepened** to 8 OWASP-aligned groups incl. anti-slopsquat supply chain.
- **Part 6 Deployment & Secure Launch — NEW**: web/iOS/Android/macOS rules + per-platform launch runbooks + "do it better" principles.
- **Part 12 — The Guardians — NEW**: 5 proactive domain sub-agents (Keymaster, Privacy Officer, Security Reviewer, Supply-Chain Sentinel, Launch Marshal).
- **Schedule A — References — NEW**: 16 authoritative standards (OWASP ASVS/MASVS, Apple notarization, Play security, SLSA…).
- **Posture set to MAXIMUM enforcement** — catch & block by default (built for a vibe coder).
- Built from current (2025) security/privacy/deployment research across OWASP, vibe-coder failures, privacy law, secrets/supply chain, and secure launch.

## Wired live (this release)
- `~/.claude/RULEBOOK.md` (the master, read first) · `~/.claude/CLAUDE.md` repointed to it.
- 5 Guardian + 5 Police subagents in `~/.claude/agents/`; hooks in `~/.claude/hooks/`; Record in `~/.claude/police/`.

See `../CHANGELOG.md` for the full history.
