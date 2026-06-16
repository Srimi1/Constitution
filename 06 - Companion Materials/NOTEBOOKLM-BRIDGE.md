# NOTEBOOKLM BRIDGE — PRIVACY GATE
### INTERFACE DOCUMENTATION — NOT ENFORCEABLE LAW
*This file documents the NotebookLM integration boundary. It carries zero enforcement
authority. Its primary function is to enforce the privacy boundary between local
constitutional documents and third-party AI services.*


---

## §1 — The Privacy Boundary

This is the gate. Before anything touches NotebookLM, this table answers: what leaves local, what stays, and why.

| Document | NotebookLM | Rationale |
|---|---|---|
| RULEBOOK.md | ✅ Submit (with author consent) | Semi-public governance document |
| CONSTITUTION.md | ⚠️ Optional (author decides) | Personal values, moderately private |
| CONSTITUTION-OF-AI-CONDUCT.md | ✅ Submit (with author consent) | Security articles, governance |
| ANTIPATTERNS.md | ✅ Submit | Generic educational content |
| AUTHOR-NOTES.md | ❌ **NEVER** | Personal diary — most private document |
| NOTEBOOKLM-BRIDGE.md | ❌ Never | This file is the gate, not content |

**Rule**: AUTHOR-NOTES.md contains introspective personal content — recurring mistakes, self-critique, failure patterns. Under Part 4.7 of the Constitution, every third-party processor must be vetted. NotebookLM (consumer tier) processes data on Google's infrastructure with no DPA. Do not upload it. Do not copy-paste it into a chat window. Do not use it in a prompt. This is not a "be careful" — this is a hard boundary.

---

## §2 — What NotebookLM Unlocks

Once the privacy boundary is set, NotebookLM gives the constitution four things it currently lacks:

**Voice.** Audio Overviews of any constitutional Part. "Explain Part 5 to a junior dev who's never done OWASP." Two AI hosts debate tradeoffs, cite examples. Four formats: Deep Dive (two hosts), Brief (single speaker, under 2 minutes), Critique (constructive evaluation), Debate (opposing perspectives). 80+ languages. Customize with pre-generation prompts — define audience, expertise level, narrative arc.

**Memory.** RAG Q&A across all uploaded constitution docs. "What does the constitution say about eval()?" → citation-grounded answer with inline chips linking to the exact passage in Part 5. "What's the difference between Class I and Class II violations?" → answer grounded in Part 10 + Article 301. The model only answers from your sources — if the answer isn't there, it says "I don't know" rather than hallucinating. 1M-token context window.

**Teacher.** Auto-generated from constitution sources via the Studio panel:
- Study Guide: "OWASP checklist for a pre-deploy review"
- Briefing Doc: "Pre-launch security gates — summary for the team"
- FAQ: "Top 10 constitution questions vibe coders ask"
- Timeline: "When does each enforcement layer fire during a deploy?"
- Mind Map: Visual constitution structure
- Flashcards / Quizzes: Self-test on constitutional articles

**Distributor.** Public notebook link. Share the constitution as a knowledge base — not for others to adopt as their law, but to learn from as a reference architecture. "Here's what a vibe coder's constitution looks like. Build your own."

---

## §3 — Setup

After privacy decisions are made (see §1):

1. Ensure notebooklm MCP is registered in `~/.claude/settings.json` (already done — `/opt/homebrew/bin/notebooklm-mcp` on stdio)
2. Restart Claude Code so the MCP server connects
3. Run `setup_auth` — opens browser for Google login, pairs the account
4. Upload sources: RULEBOOK.md + CONSTITUTION-OF-AI-CONDUCT.md + ANTIPATTERNS.md
5. Set constitutional persona: *"You are a Constitutional enforcer. Judge every question against the RULEBOOK. Cite specific Parts and Articles. When uncertain, rule conservatively. Never answer from outside the uploaded sources. If the answer is not in the constitution, say so explicitly."*
6. Verify: ask "what does the constitution say about hardcoded secrets?" — confirm citation-grounded response citing Part 5 + Keymaster

---

## §4 — What NOT to Do

- **Never upload AUTHOR-NOTES.md.** Personal diary. Hard boundary. See §1.
- **Never set NotebookLM as an auto-load context source.** It's a query tool, not a context file. Do not add a hook that loads NotebookLM results on every session. That's stealth context injection — it costs tokens, adds latency, and creates a dependency on an external service for constitutional interpretation.
- **Never treat NotebookLM answers as constitutional rulings.** The RULEBOOK is the only authority. NotebookLM answers are educational aids grounded in uploaded sources — they are not enforceable, not precedential, and not a substitute for reading the law. If NotebookLM and the RULEBOOK conflict, the RULEBOOK wins. Always.
- **Never upload data you cannot afford to share with Google's infrastructure.** Consumer-tier NotebookLM processes uploaded content on Google's servers. If you wouldn't put it in a Google Doc, don't put it in a NotebookLM source.

---

*v1.0 — Interface documentation. Companion to RULEBOOK v0.6.*
