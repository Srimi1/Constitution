# 04 — Amendments & Versions

The version archive. This folder exists so the working constitution can be iterated freely **without
creating a mess**. The rule is simple:

> **The working folders (`01 Old`, `02 New`) always hold the latest, living constitution.**
> **This folder holds a frozen snapshot of every released version.**

## How it works

- You keep editing the real documents in place — `01 - Old Constitution/00 - Srijan's Constitution…`
  and `02 - New Constitution/…`. Those are always the current truth.
- When a set of edits is meaningful enough to be a new **version** (an amendment), you take a
  **snapshot** of the current documents into a new dated subfolder here, e.g. `v0.3 - 2026-07-01/`.
- The snapshot is **immutable** (files are made read-only). It is the permanent record of what the
  constitution said at that version. You never edit a snapshot — you only ever add new ones.
- `CHANGELOG.md` records, in one place, what changed in each version and why.

So: **history lives here, the present lives in 01/02.** Nothing is ever lost, and the working folders
never fill up with `v1`, `v2`, `v3` copies scattered around.

## Layout

```
04 - Amendments & Versions/
├── README.md            ← this file (the convention)
├── CHANGELOG.md         ← every version, what changed, why
├── snapshot-version.sh  ← one command to freeze a new version
├── v0.2 - 2026-06-13/   ← frozen snapshot (read-only)
│   ├── 00 - Srijan's Constitution for AI Systems.md
│   ├── 00 - THE CONSTITUTION OF AI CONDUCT.md
│   ├── 01 - THE POLICE AGENTS.md
│   └── AMENDMENTS.md     ← what defines this version
└── v0.3 - …/            ← (future versions land here)
```

## To cut a new version

From this folder:

```bash
./snapshot-version.sh v0.3
```

That copies the current working documents into `v0.3 - <today>/`, freezes them read-only, and stubs an
`AMENDMENTS.md`. Then: fill in `AMENDMENTS.md`, add a line to `CHANGELOG.md`, and bump the version
header inside the working document in `01`. Done — the working folder keeps moving, the version is
preserved.

> Snapshots are project history only. The **live, deployed** copies that govern your AI tools live in
> `~/.claude/` (`CONSTITUTION.md`, `CONSTITUTION-OF-AI-CONDUCT.md`, `POLICE-AGENTS.md`) and are updated
> separately when you wire a new version in.
