# Version v0.6 — 2026-06-16 (LIVE)

Frozen snapshot. **Do not edit** — history. Living copy: `00 - THE CONSTITUTION (Master).md`.

## What changed since v0.5
- **Part 13 is now a two-tier deliberation branch (Thinker + Council)** — a *depth dial* for thinking,
  mirroring the Postures speed dial:
  - **Solo tier — `/thinker` (default, cheap):** one structured expert pass before acting — confirm
    domain → reframe the question → MECE issue tree → hypothesis → one recommended path, depth scaled to
    the problem. The everyday "think before you code" reflex. It *realizes §A's reasoning rules*
    (verdict-first, MECE, reframe) as a tool. (`~/.claude/skills/thinker/SKILL.md`.)
  - **Panel tier — `/council` (escalation, expensive):** the multi-agent panel, reserved for the
    highest-stakes architectural calls (DB/auth/>3-file), mandatory in Prod.
  - **Routing rule:** default to `/thinker`; escalate to `/council` only when the stakes are architectural
    and high. Don't convene a panel for what one pass settles.
- **Efficiency is the point:** fewer wrong-problem rabbit holes (reframe), faster decisions (verdict-first),
  right-sized effort (depth scaling), and a cheap default tier instead of always paying for the panel.

## Implementation
No code changes — `/thinker` already exists and runs; this wires it into the law. Both tiers stay
**advisory** (human keeps final word); neither can touch the Hard Lines or the Soul.

See `../CHANGELOG.md` for the full history.
