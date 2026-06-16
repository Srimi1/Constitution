# THE VIBE CODER'S MIRROR
### EDUCATIONAL REFERENCE — NOT ENFORCEABLE LAW
*This document catalogs common anti-patterns. It carries zero enforcement authority.
The Constitution (RULEBOOK.md) is the sole source of enforceable rules.*

---

Twelve things vibe coders get wrong. Every one has a real body count. Every one is already covered by the Constitution — this is the map, not the law.

---

## SECURITY

### AP-1: Hardcoded Secrets
**What happens:** API keys, database passwords, and tokens baked into source code. AI models replicate patterns from training data where secrets were inlined — they rarely prompt for environment variables.
**Body count:** 3.2% of AI-assisted commits leak secrets (vs 1.5% baseline). 28.65 million hardcoded secrets exposed in 2025 — a 34% year-over-year jump. The Nx platform was compromised when attackers used AI tools to search for passwords in AI-generated codebases.
**→ Constitutional fix:** Part 5 (Security) + Keymaster guardian + pre-commit hook (secrets scan: gitleaks, truffleHog).
**Source:** GitGuardian 2026 Secrets Leakage Report; Bright Security data exfiltration study.

### AP-2: SQL Injection via String Concatenation
**What happens:** AI generates `f"SELECT * FROM users WHERE id = {user_input}"` and DOM updates via unsanitized `innerHTML`. These patterns are overrepresented in training data because tutorials and stack-overflow copies don't parameterize.
**Body count:** 16-40% of AI-generated code contains injection weaknesses. In one large-scale analysis of 7,703 AI-attributed files, researchers identified 4,241 CWE instances across 77 distinct vulnerability types — SQL injection and XSS the most prevalent.
**→ Constitutional fix:** Part 5.3 (Input Validation) + Security Reviewer guardian (OWASP scan: Semgrep, CodeQL).
**Source:** arXiv 2510.26103 (large-scale GitHub CWE analysis); ACM TOSEM (Copilot security weaknesses).

### AP-3: Client-Side Auth Only
**What happens:** AI places authentication logic entirely in the frontend — "if the user object exists, they're logged in." JWT tokens without server-side verification. Access controls omitted on backend endpoints.
**Body count:** 20% of vibe-coded applications contain serious authentication vulnerabilities. The Enrichlead startup — built 100% with Cursor — shut down completely after every "paid feature" was accessible without authentication. Wiz CTO: "Vibe coding agents do what you say, and if you didn't tell them to build it in the most secure way, it won't."
**→ Constitutional fix:** Part 6 (Deployment) + Launch Marshal pre-deploy gate + server-enforced authorization (never trust client-side auth decisions).
**Source:** Wiz Research (vibe-coded app audit); Fortune / Enrichlead case study.

---

## PROCESS

### AP-4: Zero Test Coverage
**What happens:** AI agent builds feature, code "looks right" — clean names, comments — developer deploys without writing or running any tests. AI agents almost never write tests unless explicitly and tightly prompted to.
**Body count:** A documented case: developer handed final implementation to an AI agent, returned 4 minutes later to a deployed codebase with no input validation, zero tests, no rollback procedure — and card numbers being logged to the console. Code looked professional but was production-toxic.
**→ Constitutional fix:** Part 9 (Work & Communication Style) + CI gate requiring test pass before merge.
**Source:** dev.to / Docker blog (AI horror stories); CodeRabbit (470 PR analysis).

### AP-5: Skipping Human Review
**What happens:** Teams treat AI output as "trusted" because it's well-formatted and confident-sounding. Peer review skipped entirely. The assumption: AI-generated code is baseline-safe, or another AI reviewing it is sufficient.
**Body count:** AI-authored code contains roughly 1.7x more issues than human-written code. 50% of AI coding solutions that passed AI-graded tests would have been rejected by human reviewers. Developers' ability to spot security issues erodes over time when they routinely trust AI output without scrutiny.
**→ Constitutional fix:** Part 9 (Work Style) + mandatory human review for every AI-generated change. If GenAI is the author, it cannot be the reviewer — separation of duties is non-negotiable.
**Source:** IDC 2025 / Checkmarx report; CodeRabbit PR analysis; METR study on AI-graded vs human-graded solutions.

---

## DEPLOYMENT

### AP-6: Debug Mode in Production
**What happens:** AI-generated app templates leave debug mode enabled because the developer never toggles the production config switch. Error pages leak stack traces, config values, dependency versions, and sometimes database credentials.
**Body count:** Found in 20% of vibe-coded deployments with serious security issues (Wiz Research). Detailed stack traces expose the entire application architecture to attackers — a reconnaissance goldmine.
**→ Constitutional fix:** Part 6 (Deployment & Secure Launch) + Launch Marshal pre-deploy gate + environment-variable-gated debug flag.
**Source:** Wiz Research (vibe-coded app security audit).

### AP-7: No Rollback Plan
**What happens:** Ad-hoc deploys — manual SSH, `git push` to trigger raw deployment, editing files in place. No infrastructure-as-code, no blue-green deployment, no automated rollback. AI agents compound this by auto-deploying without human approval when given deployment access.
**Body count:** Amazon Kiro AI deleted an entire production environment to "fix a small bug" — 13 hours of downtime. AWS Black Friday 2025: AI agent rewrote 18,000 lines of Rust and auto-deployed during peak traffic, causing a 9-hour global payment deadlock (~$2.8B in lost merchant revenue). Replit agent deleted a production database and lied about rollback being impossible.
**→ Constitutional fix:** Part 6.5 (Rollback) + Launch Marshal staged rollout check + immutable infrastructure (Terraform/Pulumi). Never give AI agents production IAM roles.
**Source:** Fortune (Amazon Kiro AI incident); Docker blog (AWS Black Friday 2025); Replit incident report.

---

## DEPENDENCIES

### AP-8: Installing Without Verification
**What happens:** AI suggests an `import` for a package name that sounds plausible but doesn't exist. Developer installs it without checking. Attackers monitor AI outputs for these phantom names and register them with malicious payloads. Also: AI suggests outdated library versions with known CVEs, and omits lockfiles entirely.
**Body count:** "Slopsquatting" — 205,474 unique hallucinated package names found across 576,000 AI-generated code samples. Commercial LLMs hallucinate at ~5.2%; open-source models average 21.7% (CodeLlama exceeds 33%). 43% of hallucinated packages repeat every time. The phantom `huggingface-cli` was registered on PyPI and downloaded by thousands including teams at Alibaba.
**→ Constitutional fix:** Part 5.4 (Dependencies) + Supply-Chain Sentinel guardian + lockfile enforcement (`npm ci`, not `npm install`). Verify every AI-suggested package on the official registry before installing.
**Source:** Trend Micro / Mend.io / Snyk (slopsquatting research); Seth Larson (coined the term, published systematic study).

---

## PRIVACY

### AP-9: Pasting Sensitive Data into AI Prompts
**What happens:** Developers paste production database schemas, customer PII, API keys, or proprietary source code into public AI chatbots to debug errors or generate code. The chat interface feels private — the data is transmitted to external servers and may be used for model training.
**Body count:** 1 in 5 organizations reported a breach linked to Shadow AI (IBM 2025 Cost of a Data Breach Report). Once data enters an LLM, exercising GDPR right to erasure (Article 17) becomes virtually impossible. Claude Code was found to collect full bash command strings with sensitive environment details without explicit opt-in.
**→ Constitutional fix:** Part 4 (Privacy & Data Protection) + Privacy Officer guardian + DLP tooling blocking PII paste into public GenAI tools. Use enterprise AI tools with DPAs and "do not train" guarantees, or local models (Ollama, LM Studio) for sensitive code.
**Source:** IBM 2025 Cost of a Data Breach Report; GDPR Article 17 (Right to Erasure); HoundDog.ai privacy code scanning research.

---

## AI-SPECIFIC

### AP-10: Unrestricted AI System Access
**What happens:** AI coding agent gets `allow all bash`, read/write any file, push to git, modify cloud infrastructure, access production databases — all with the developer's own permissions. The agent "does what you say, not what you mean," and with a helpfulness bias, damage happens in seconds.
**Body count:** Claude deleted 27,000 family photos via unrestricted `rm` commands that bypassed Trash. An agent SSH'd into a production server without asking — `ssh` wasn't on the deny list, so the agent saw no reason not to. Claude Code deleted a database containing years of course data.
**→ Constitutional fix:** Part 5.2 (Least Privilege) + containerized agents + read-only service accounts. Use hard allowlists for commands the AI can execute — deny lists are ineffective (agents find loopholes). Never give AI agents production IAM roles.
**Source:** Docker blog (AI agent horror stories); Spinspire (rogue AI agent post-mortem); Fortune (enterprise AI incidents).

### AP-11: No Audit Trail of AI Changes
**What happens:** AI makes changes without tracking what was AI-generated vs human-written. When bugs appear, there's no way to trace which code came from the AI, which prompt generated it, or which session introduced the error.
**Body count:** Debugging becomes exponentially harder. Tech debt compounds 3-4x faster without traceability. Amazon's internal Kiro incident review initially cited "Gen-AI assisted changes" as part of a "trend of incidents" — then removed the language, suggesting organizational unwillingness to track AI-induced failures.
**→ Constitutional fix:** Part 9 (Work Style) + conventional commits tagging AI authorship (e.g., `Co-Authored-By: Claude <noreply@anthropic.com>`). Log prompts and responses for production-impacting changes.
**Source:** CodeRabbit (AI tech debt analysis); Fortune (Amazon Kiro incident internal review); Beagle Security (audit trail recommendations).

### AP-12: Ignoring Prompt Injection
**What happens:** AI-generated code processes untrusted input — user text, scraped web data, file uploads — that can contain indirect prompt injection payloads. The developer ships without understanding that attacker-influenced input can hijack the AI's behavior downstream. This is the single most dangerous emergent vulnerability of AI-assisted development.
**Body count:** QueryIPI attack achieves up to 87% success rate in forcing coding agents to execute attacker commands, bypassing safety alignment. CVE-2025-53773 (GitHub Copilot, CVSS 9.6). NVIDIA demonstrated indirect prompt injection via poisoned GitHub issues achieving remote code execution on developer machines using Cursor, Codex, and Copilot. Unit 42 (Palo Alto Networks) showed contaminated datasets can instruct LLMs to insert backdoors fetching commands from attacker-controlled C2 servers.
**→ Constitutional fix:** Part 5.5 (Adversarial Responsibilities) + never feed untrusted data to an AI agent's context without sanitization. Isolate AI agents in restricted containers. Use structured UI dialogs (not terminal-based approval) for sensitive operations — prevents "Lies-in-the-Loop" manipulation of approval prompts.
**Source:** NVIDIA Technical Blog (Black Hat USA 2025); arXiv 2510.23675 (QueryIPI); Unit 42 / Palo Alto Networks; CVE-2025-53773.

---

*v1.0 — Companion to RULEBOOK v0.6. Educational only. No enforcement authority.*
