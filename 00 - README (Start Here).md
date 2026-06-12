# Constitution Project — Start Here

> **The law is `00 - THE CONSTITUTION (Master).md` (v0.3) — the single source of truth, LIVE.**
> It is security & privacy-forward at maximum enforcement, covers Safety / Honesty / Privacy / Security /
> Deployment / Conduct / Enforcement, and is wired into `~/.claude/` + enforced by hooks, 5 Guardian
> sub-agents, and 5 Police sub-agents. Everything below is the depth, source, and history behind it.

This folder holds the whole project, arranged in order. Read it top to bottom by the numbered folders.

---

## The order

### 01 — Old Constitution (The Real Thing)
The foundational, pre-existing material. This is the real source of authority that everything else is built on.

- **00 - Srijan's Constitution for AI Systems.md** — your master constitution (v0.2). The actual governing document for every AI tool you run. This is the heart of it.
- **Reference - Claude Constitution (Anthropic, Jan 2026).txt** — the Anthropic document your framework is modeled on.
- **Reference - Claudes Constitution (web PDF).pdf** — the same reference, original PDF.

### 02 — New Constitution (Security & Policing)
The new charter we built. It takes the security knowledge and turns it into enforceable law, then creates the agents that enforce it. This extends the Old Constitution, it does not replace it.

- **00 - THE CONSTITUTION OF AI CONDUCT.md** — the law. Parts and Articles covering moral doctrine, constraints, security and hacking protocols, the definition of an AI criminal, punishment (with a worked example), and policing. Articles numbered with gaps up to 999 so you can keep adding.
- **01 - THE POLICE AGENTS.md** — the enforcement arm. Five police agents (Sentinel, Auditor, Magistrate, Warden, Registrar), each with a drop-in system prompt.

### 03 — Source Material (Security Guides)
The raw research the New Constitution's security Part was built from. Four tiers, junior to attacker. Keep these as the reference behind Part IV.

- **01 - Junior - Mistakes and Security.md**
- **02 - Intermediate - Mistakes and Security.md**
- **03 - Senior - Mistakes and Security.md**
- **04 - Top-Tier - Attacker Mindset.md**

### 04 — Amendments & Versions
The version archive. The working folders (01, 02) are always the latest, living constitution; this
folder keeps a **frozen, read-only snapshot of every released version** so history never clutters the
working copy. Iterate 01/02 freely — cut a version snapshot here when an amendment is meaningful.

- **README.md** — the convention (how versioning works).
- **CHANGELOG.md** — every version, what changed, why.
- **snapshot-version.sh** — one command to freeze a new version: `./snapshot-version.sh v0.3`.
- **v0.2 - 2026-06-13/** — first frozen snapshot (master + annex + police agents at v0.2).

### 99 — Other
Unrelated files parked out of the way.

- **thinker.skill**

---

## How the pieces relate

```
01 Old Constitution  ──►  the real authority (Srijan's Constitution + Claude reference)
        │
        ▼
02 New Constitution  ──►  extends it with security law + police agents
        ▲
        │ built from
03 Source Material   ──►  the four security guides feeding Part IV

01 + 02 are ALWAYS the latest (edit in place).
        │  snapshot on each amendment
        ▼
04 Amendments & Versions ──►  frozen, read-only history of every released version
```

## Open item — RESOLVED (2026-06-13)
`[PROJECT]` was resolved to **Srijan's AI systems** (every AI tool Srijan runs or ships), and the New
Constitution is now bound as the **security & enforcement annex of Srijan's Constitution**, which is the
supreme parent authority. Where the two conflict, Srijan's Constitution wins; the annex may never
license crossing a Part III hard constraint. The binding is live: both documents are installed in
`~/.claude/` (`CONSTITUTION-OF-AI-CONDUCT.md`, `POLICE-AGENTS.md`) and referenced from `~/.claude/CLAUDE.md`
so every session inherits the whole system.

The five police agents are **defined and bound but not yet deployed as running sub-agents** — that's the
next opt-in step (it was deferred so a live Sentinel doesn't STOP your working agents until you want it).
