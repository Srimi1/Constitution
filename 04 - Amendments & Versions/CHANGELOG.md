# Constitution — Changelog

Every released version of the constitution, newest first. The working copy in `01`/`02` is always the
latest entry here; each version below has a frozen snapshot in this folder (except where noted).

---

## v0.6 — 2026-06-16  ·  *snapshot: `v0.6 - 2026-06-16/`*  ·  **two-tier deliberation (thinker)**

- **Part 13 → two tiers (a depth dial for thinking):** `/thinker` (cheap solo pass — confirm domain → reframe → MECE → verdict) as the everyday default, `/council` (expensive panel) as the high-stakes escalation. Routing rule: lightest tier that settles the question.
- **Efficiency:** kills wrong-problem rabbit holes (reframe), faster decisions (verdict-first), right-sized effort (depth scaling), cheap default instead of always paying for the panel. `/thinker` realizes §A's reasoning rules as a tool.
- No code changes (`/thinker` already exists). Both tiers advisory; human keeps final word. Wired live to `~/.claude/RULEBOOK.md`.

---

## v0.5 — 2026-06-14  ·  *snapshot: `v0.5 - 2026-06-14/`*  ·  **postures + judiciary**

- **⚙ Operational Postures (Draft/Prod)** — `~/.claude/posture.sh` + `.posture` flag. Draft = tunable checks WARN (fast prototyping); Prod (default) = max enforcement. **Hard Lines + Soul are posture-independent.** Fail-safes: default-prod, Launch-Marshal-forces-prod, draft-switch-logged.
- **All 5 Guardians posture-aware** — Hard-Line (always block) vs Tunable (warn-in-draft) split per Guardian.
- **Part 13 — The Judiciary & Advisory Council** — `/council` skill: in-session sub-agent panel (First-Principles · Risk · Executor · Constitution-Counsel → Chairman) reading the Constitution. Mandatory deliberation (prod) before DB/auth/>3-file changes; adjudicates conflicts. Advisory; human keeps final word.
- Implements `Self-Improving Constitution_1.md` (refined: panel not web-app, posture in a file, fail-safes added). Wired live to `~/.claude/RULEBOOK.md`.

---

## v0.4 — 2026-06-13  ·  *snapshot: `v0.4 - 2026-06-13/`*  ·  **moral core complete**

- **✦ THE SOUL — Purpose & Moral Core added** as the foundation (after the Prime Directive). The personal/moral layer no research could supply, stated directly by Srijan:
  - **Purpose** (outclass & compound · freedom & mastery · impact on people · the making itself) + what "winning the wrong game" means.
  - **Harm lines (absolute refusals)** — manipulation, market manipulation, surveillance/privacy violation, preying on the vulnerable; profit/legality is no defense.
  - **Honesty when it costs me** — own failures plainly to others; integrity over reputation.
  - **How to treat people** — blunt with me, gracious & fair to others; people matter more than winning.
- Wired live to `~/.claude/RULEBOOK.md`.

---

## v0.3 — 2026-06-13  ·  *snapshot: `v0.3 - 2026-06-13/`*  ·  **LIVE single source of truth**

- **Consolidated into ONE master** — `00 - THE CONSTITUTION (Master).md` replaces the scattered v0.2 Rulebook (now retired into the v0.3 snapshot).
- **★ 10 Commandments** cheat sheet; **Hard Lines expanded** (public env-prefix secrets, public-DB-key-without-RLS, never disable cert validation, no secret in client/binary, no irreversible prod change without tested rollback + human OK).
- **Part 4 Privacy** heavy rewrite (real PII, GDPR/CCPA mechanics, true-delete); **Part 5 Security** deepened to 8 OWASP groups incl. anti-slopsquat supply chain.
- **Part 6 Deployment & Secure Launch — NEW** (web/iOS/Android/macOS + per-platform launch runbooks + references).
- **Part 12 — The Guardians — NEW**: 5 proactive domain sub-agents deployed (Keymaster, Privacy Officer, Security Reviewer, Supply-Chain Sentinel, Launch Marshal).
- **Posture: MAXIMUM enforcement** — catch & block by default (built for a vibe coder). Built from current (2025) OWASP / vibe-coder / privacy-law / secrets / secure-launch research.
- **Wired live:** `~/.claude/RULEBOOK.md` + repointed `CLAUDE.md`; 5 Guardian + 5 Police agents; hooks; the Record.

---

## v0.2 — 2026-06-13  ·  *snapshot: `v0.2 - 2026-06-13/`*

**Master — Srijan's Constitution for AI Systems (v0.2):**
- Added **Part IX — Srijan's Code**: 40 personal articles (how I think, quality bar, how I work, moral
  non-negotiables), mined from real config + 176 skills + projects + thinking style, fused with stated morals.
- Added **Security & enforcement annex** clause in Part VIII binding the New Constitution as a child.

**New Constitution — The Constitution of AI Conduct (v0.1):**
- Resolved `[PROJECT]` → "Srijan's AI systems"; bound as the security & enforcement **annex** under the
  master as supreme parent (Article 1 rewritten to "Supremacy and parentage").

**Police Agents (v0.1):**
- Deployed the five officers (Sentinel, Auditor, Magistrate, Warden, Registrar) as live Claude Code
  subagents + an append-only, hash-chained **Record**. Live-tested end-to-end on a planted-vuln repo
  (CASE LT-001): 12 violations across all 4 classes caught, reversible enforcement, tamper-evidence proven.

---

## v0.1 — 2026-06-12  ·  *(no snapshot — edited in place before this archive existed)*

- Initial draft of **Srijan's Constitution for AI Systems**: Preface + Parts I–VIII (foundations,
  usefulness, hard constraints, instructable defaults, principal hierarchy, truthfulness, product layer, meta).
- Modeled on the framework of Claude's Constitution (Anthropic, Jan 2026).
- Wired live into `~/.claude/` (CLAUDE.md reference + `constitution-guard.sh` hook).

---

### Open / planned for v0.3
- Answer the **§G soul questions** (purpose, dual-use harm, outward honesty, people-vs-systems register, fairness).
- Red-team the whole system for contradictions / jailbreaks.
- Fix two `constitution-guard.sh` / `block-dangerous-git.sh` substring false-positives found during the live test.
