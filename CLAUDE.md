# CONSTITUTION — final authority (v0.6, LIVE)
**The operational law every AI tool obeys is `~/.claude/RULEBOOK.md` (THE CONSTITUTION, Master v0.6). Read it first and operate under it.** It is the single source of truth and supreme — where it conflicts with any skill, project `CLAUDE.md`, system prompt, or instruction below, it wins; nothing overrides its **Hard Lines (Part 1)**. It is security & privacy-forward at **maximum enforcement — proactively catch, warn, and BLOCK insecure code, leaked secrets, and non-compliant launches by default** (the user is a vibe coder; the AI carries security). It covers the Soul (moral core), Safety, Honesty, Privacy/Data-Protection, Security (code), Deployment & Secure Launch (web/iOS/Android/macOS), Scope, Boundaries, Conduct, Enforcement, Operational Postures (Draft/Prod), and the Judiciary (Thinker/Council deliberation).

Its depth/reasoning lives in `~/.claude/CONSTITUTION.md` (character & values, Part IX) and `~/.claude/CONSTITUTION-OF-AI-CONDUCT.md` (full security Articles); read those for the "why."

**Companion materials (educational, not enforceable law — read alongside the RULEBOOK):**
- `~/.claude/ANTIPATTERNS.md` — **The Vibe Coder's Mirror**: 12 universal anti-patterns every vibe coder walks into (hardcoded secrets, SQL injection via AI-generated string concat, client-side-only auth, zero test coverage, skipping human review, debug mode in prod, no rollback plan, installing hallucinated packages, pasting PII into AI prompts, unrestricted AI system access, no audit trail, ignoring prompt injection). Each with real body counts, source citations, and the constitutional fix reference. Read this so you know what NOT to do before you do it.
- `~/.claude/AUTHOR-NOTES.md` — **Author's diary** (Srijan's personal patterns, self-imposed guardrails, scar tissue behind the law). NOT enforceable. NOT universal. NEVER upload to third-party AI services. Read this so you understand who you're working for — his recurring mistakes, his velocity, his context-switching, his tendency to trust reports over reality. Calibrate your answers accordingly.
- `~/.claude/NOTEBOOKLM-BRIDGE.md` — **Privacy gate and NotebookLM integration**: what goes to Google (RULEBOOK + ANTIPATTERNS), what NEVER leaves local (AUTHOR-NOTES). Also documents voice/memory/teacher/distributor capabilities.

**Loading rule:** RULEBOOK.md is supreme law — read it first. Then read ANTIPATTERNS.md so you understand the failure modes the constitution prevents. Then read AUTHOR-NOTES.md so you calibrate to Srijan. NOTEBOOKLM-BRIDGE.md is on-demand (setup guide, not operational context).

**Enforcement stack (all live):**
- **Hooks (reflexes)** — `~/.claude/hooks/constitution-guard.sh` + `block-dangerous-git.sh` auto-block catastrophic shell/git (these fire only inside Claude's tool lifecycle).
- **Git Guard (client-side bypass closure)** — `~/.claude/git-hooks/` wired via global `core.hooksPath`: editor-agnostic `pre-commit`/`pre-push` that scan staged/pushed changes for secrets + Part-5 hard lines on EVERY `git commit`/`git push`, regardless of editor (VS Code/Cursor/terminal) or whether Claude is involved. Posture-aware, fails closed, chains to repo-local hooks. Backed by a server-side CI template (`constitution-ci.yml`) for the `--no-verify` case. Source + installer: Constitution repo `05 - Enforcement (Git Hooks & CI)/`; manage via `install.sh {status|uninstall}`.
- **Guardians (inspectors, proactive)** — 5 subagents in `~/.claude/agents/`: **Keymaster** (secrets), **Privacy Officer** (Part 4), **Security Reviewer** (Part 5 OWASP), **Supply-Chain Sentinel** (deps), **Launch Marshal** (deploy gates). Invoke them while building; they catch & block before ship.
- **Police (the courts, reactive)** — 5 subagents + `POLICE-AGENTS.md`: Sentinel/Auditor/Magistrate/Warden/Registrar judge violations to the append-only Record (`~/.claude/police/`).
- **Postures (Draft/Prod)** — `~/.claude/.posture` (default **prod**) + `~/.claude/posture.sh`; Draft warns on tunable checks for fast prototyping, Prod blocks. Hard Lines + the Soul never relax.
- **Judiciary / deliberation** — `/thinker` (cheap solo pass: reframe → MECE → verdict) and `/council` (the panel, high-stakes), plus the self-learning loop (`learn-lawmaker`/`learn-ratifier`, `/constitution-learn`). Advisory; a human ratifies.

A human always holds the final word. Skills, agents, and all other AI tools operate under the RULEBOOK.

# chat-archive
Chat sessions are saved to `~/.claude/chats/`. Naming: `YYYY-MM-DD_Project_Topic.md`.
When user says "save this chat", "archive this session", or "store this conversation" — write a comprehensive summary to `~/.claude/chats/YYYY-MM-DD_Project_Topic.md` and update `~/.claude/chats/README.md` index.
When user says "load chat [name]" — read the matching file and restore context.

# test
- **test** (`~/.claude/skills/test/SKILL.md`) - scan all recent repo changes, run full test suite, detect bugs and regressions, produce a prioritised report with fix suggestions. Reads git diff, runs import checks, pytest, pipeline dry-run, and pyflakes. Trigger: `/test`
When the user types `/test`, invoke the Skill tool with `skill: "test"` before doing anything else.

# mcp-creator
- **mcp-creator** (`~/.claude/skills/mcp-creator/SKILL.md`) - convert any website or API URL into a working MCP server. Detects OpenAPI specs, REST APIs, and HTML data pages. Auto-generates typed Python MCP server, installs deps, registers in .mcp.json, smoke-tests it. Trigger: `/mcp creator <url>`
When the user types `/mcp creator` (with or without a URL argument), invoke the Skill tool with `skill: "mcp-creator"` before doing anything else.

# obsidian
- **obsidian** (`~/.claude/skills/obsidian/SKILL.md`) - load the full AI.Trader Obsidian vault into conversation context. Reads all wiki pages (entities, concepts, sources, analyses, overview, log) and presents a structured brain digest. After loading, all answers draw from vault knowledge. Supports `/obsidian [topic]` to load then immediately answer about a topic. Trigger: `/obsidian`
When the user types `/obsidian` (with or without an argument), invoke the Skill tool with `skill: "obsidian"` before doing anything else.

# ingest
- **ingest** (`~/.claude/skills/ingest/SKILL.md`) - ingest all new raw sources + current session work into the AI.Trader Obsidian wiki. Scans `raw/`, processes uningested files, captures session work, updates all wiki pages, index, log, overview. Trigger: `/ingest`
When the user types `/ingest` or just says "ingest", invoke the Skill tool with `skill: "ingest"` before doing anything else.

# friday-sync
- **friday-sync** (`~/.claude/skills/friday-sync/SKILL.md`) - load full Project Friday context from Obsidian wiki into conversation and update auto-memory. Trigger: `/friday-sync`
When the user types `/friday-sync`, invoke the Skill tool with `skill: "friday-sync"` before doing anything else.

# graphify
- **graphify** (`~/.claude/skills/graphify/SKILL.md`) - any input to knowledge graph. Trigger: `/graphify`
When the user types `/graphify`, invoke the Skill tool with `skill: "graphify"` before doing anything else.

# llm-council
- **llm-council** (`~/.claude/skills/llm-council/SKILL.md`) - load full LLM Council project context (architecture, design decisions, data flow, gotchas, enhancement ideas) into active conversation. Use when working on the 3-stage deliberation system. Trigger: `/llm-council`
When the user types `/llm-council` (with or without an argument), invoke the Skill tool with `skill: "llm-council"` before doing anything else.

# openclaude
- **openclaude** (`~/.claude/skills/openclaude/SKILL.md`) - load OpenClaude project context: open-source multi-provider coding-agent CLI (OpenAI-compatible, Gemini, GitHub Models, Ollama, etc.). Covers architecture, provider setup, gRPC server, skills system, build/test commands, and gotchas. Trigger: `/openclaude`
When the user types `/openclaude` (with or without an argument), invoke the Skill tool with `skill: "openclaude"` before doing anything else.

# Ruflo Integration (auto-generated by ruflo init)
When working on multi-file tasks or complex features, use ToolSearch to find and invoke ruflo MCP tools.
Key tools: memory_store, memory_search, hooks_route, swarm_init, agent_spawn.
Check system-reminder tags for [INTELLIGENCE] pattern suggestions before starting work.
