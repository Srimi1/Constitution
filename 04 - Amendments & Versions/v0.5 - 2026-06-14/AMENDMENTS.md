# Version v0.5 — 2026-06-14 (LIVE)

Frozen snapshot. **Do not edit** — history. Living copy: `00 - THE CONSTITUTION (Master).md`.

## What changed since v0.4
- **⚙ Operational Postures (Draft / Prod) added** — `~/.claude/.posture` flag + `~/.claude/posture.sh` helper.
  Draft relaxes *tunable* checks to WARN (fast prototyping); Prod (default) is maximum enforcement.
  **Hard Lines + the Soul are posture-independent — always block.** Fail-safes: default prod, the Launch
  Marshal **forces prod** (no deploy in draft), draft switches are logged + announced (`⚠ DRAFT MODE`).
- **All 5 Guardians made posture-aware** — each carries its Hard-Line (always block) vs Tunable (warn in
  draft) split. Keymaster = secrets always block (posture has no effect). Launch Marshal forces prod.
- **Part 13 — The Judiciary & Advisory Council added** — the `/council` skill: an in-session sub-agent
  panel (First-Principles · Risk/Contrarian · Executor · Constitution-Counsel → Chairman) that reads the
  Constitution and returns one compliant recommended path. Mandatory deliberation (in prod) before
  DB/auth/>3-file changes; adjudicates rule conflicts. **Advisory — Srijan keeps final word.** The heavy
  6-model LLM Council web app stays an optional manual escalation.

## Implements
The proposal `Self-Improving Constitution_1.md`, refined per review: judiciary as a cheap in-session
sub-agent panel (not the web app), posture stored in a file, fail-safes added (default-prod,
launch-forces-prod, draft-logged).

## Wired live
`~/.claude/RULEBOOK.md` (v0.5) · `~/.claude/posture.sh` + `.posture` · `~/.claude/skills/council/` ·
5 posture-aware `~/.claude/agents/guardian-*.md`.

See `../CHANGELOG.md` for the full history.
