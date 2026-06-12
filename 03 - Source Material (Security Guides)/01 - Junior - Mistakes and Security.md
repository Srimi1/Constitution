# Rookie Coder Mistakes and Security Checklist

A practical list of the mistakes junior developers make when shipping an app or website, with a heavy focus on security. Use it as a pre-launch checklist. Each security item names the risk, why it bites you, and how to fix it.

Last updated: June 2026.

---

## Part 1: General Rookie Mistakes (Non-Security)

These are the things that quietly wreck a project even when the code "works on my machine."

1. **Hardcoding everything.** Database URLs, ports, file paths, magic numbers stuffed directly into the code. The moment you move to a new environment it breaks. Fix: use config files and environment variables.

2. **No version control discipline.** Committing straight to main, giant commits with messages like "fixed stuff," no branches. Fix: small commits, clear messages, branch per feature.

3. **Committing things that should never be in the repo.** `.env` files, `node_modules`, build artifacts, secret keys. Fix: set up `.gitignore` on day one.

4. **No error handling.** Code assumes the happy path always happens. One bad input or a dropped network call crashes the whole thing. Fix: handle failures explicitly, fail gracefully, show useful messages.

5. **Not validating input.** Trusting that users send what you expect. They never do. (This is also a security issue, covered below.)

6. **Copy-pasting code without understanding it.** Stack Overflow and AI snippets get pasted in, including their bugs and bad practices. Fix: read it, understand it, then use it.

7. **No tests.** "I tested it manually" does not scale. Every change risks breaking something silently. Fix: at least cover the critical paths with automated tests.

8. **Premature optimization, or zero optimization.** Either spending days micro-tuning code nobody runs, or shipping N+1 database queries that melt under load. Fix: measure first, then optimize what actually matters.

9. **Ignoring mobile and different screen sizes.** Building only for their own laptop. Fix: test responsive layouts and real devices.

10. **No logging, or logging everything including secrets.** When something breaks in production you are blind. Or worse, you are logging passwords. Fix: structured logs, no sensitive data in them.

11. **Reinventing the wheel.** Writing custom auth, custom date parsing, custom crypto. These are solved problems with battle-tested libraries. Fix: use the standard library or a trusted package.

12. **Not reading the docs.** Guessing at how an API works and fighting it for hours. Fix: read first, code second.

13. **Shipping with debug mode on.** Stack traces, verbose errors, and dev tooling exposed in production. (Also a security issue, see Misconfiguration.)

14. **No backups and no rollback plan.** A bad deploy or a `DROP TABLE` and the data is gone forever. Fix: automated backups, tested restores, a way to roll back a release.

15. **Scope creep and no MVP.** Trying to build every feature before launching anything. Fix: ship the smallest useful version, then iterate.

---

## Part 2: Security Mistakes (The Main Event)

This section is structured around the OWASP Top 10, the industry-standard list of the most critical web application risks, plus the specific things juniors get wrong.

### A01. Broken Access Control
**The risk:** Users can do or see things they should not. The classic version is changing `/user/123` to `/user/124` in the URL and seeing someone else's data (called IDOR, Insecure Direct Object Reference). Also includes regular users hitting admin endpoints.

**Why it bites:** The number one risk on the OWASP list. Easy to introduce, easy for attackers to find.

**How to tackle it:**
- Check authorization on the server for every request, not just by hiding buttons in the UI.
- Deny by default. A user gets access only when a rule explicitly grants it.
- Never trust an ID coming from the client. Verify the logged-in user actually owns that resource.
- Use role-based access control and test it with a low-privilege account.

### A02. Cryptographic Failures (Sensitive Data Exposure)
**The risk:** Sensitive data (passwords, card numbers, personal info) stored or sent without proper protection.

**How to tackle it:**
- Use HTTPS/TLS everywhere. No plain HTTP for anything that matters.
- Never store passwords as plain text or with weak hashing like MD5/SHA1. Use bcrypt, scrypt, or Argon2 with salting.
- Encrypt sensitive data at rest.
- Do not invent your own encryption. Use vetted libraries.

### A03. Injection (SQL, NoSQL, Command, XSS)
**The risk:** Untrusted input gets treated as code or a command. SQL injection lets an attacker read or wipe your whole database. Cross-site scripting (XSS) lets them run JavaScript in other users' browsers.

**How to tackle it:**
- Use parameterized queries / prepared statements. Never build SQL by string concatenation with user input.
- Use an ORM correctly (it parameterizes for you).
- Escape or sanitize output that goes into HTML to stop XSS. Use your framework's auto-escaping.
- Validate input on the server: type, length, format, allowed values.
- For shell commands, avoid passing user input to the shell at all. Use safe APIs.

### A04. Insecure Design
**The risk:** The flaw is in the plan, not the code. For example, a "forgot password" flow that reveals whether an email exists, or a checkout that trusts the price sent by the browser.

**How to tackle it:**
- Think about how each feature could be abused before you build it (threat modeling).
- Never trust amounts, prices, discounts, or roles sent from the client. Recompute them on the server.
- Add rate limits to anything that can be brute forced or spammed.

### A05. Security Misconfiguration
**The risk:** Default passwords, debug mode on in production, overly open cloud storage buckets, verbose error pages leaking stack traces, unnecessary ports and services open.

**How to tackle it:**
- Turn off debug mode and detailed errors in production.
- Change every default credential.
- Lock down cloud storage (S3 buckets, etc.) so they are private by default.
- Set security headers (Content-Security-Policy, HSTS, X-Frame-Options).
- Remove sample apps, unused features, and default accounts.

### A06. Vulnerable and Outdated Components
**The risk:** Using libraries, plugins, or frameworks with known holes. Most breaches use a vulnerability that already had a patch available.

**How to tackle it:**
- Keep dependencies updated.
- Run a scanner: `npm audit`, `pip-audit`, Dependabot, Snyk, or similar.
- Remove packages you do not use.
- Pin versions and review what you pull in.

### A07. Identification and Authentication Failures
**The risk:** Weak login and session handling. Allowing "123456" as a password, no lockout on repeated failures, session tokens that never expire or are guessable, no protection against credential stuffing.

**How to tackle it:**
- Enforce strong passwords and check against known-breached password lists.
- Offer multifactor authentication.
- Rate-limit and lock out after failed login attempts.
- Use secure, random, expiring session tokens. Invalidate them on logout.
- Do not roll your own auth. Use a proven library or provider.

### A08. Software and Data Integrity Failures
**The risk:** Trusting code or updates from places you should not, insecure CI/CD pipelines, deserializing untrusted data.

**How to tackle it:**
- Verify integrity of dependencies and updates (signatures, checksums, lockfiles).
- Lock down your build pipeline and who can push to it.
- Do not deserialize untrusted input into objects without validation.

### A09. Security Logging and Monitoring Failures
**The risk:** An attacker is inside and you have no idea because nothing is logged or watched. The average breach goes undetected for months.

**How to tackle it:**
- Log security events: logins, failures, access-control denials, high-value actions.
- Make sure logs are tamper-resistant and do not contain secrets or passwords.
- Set up alerts for suspicious patterns.

### A10. Server-Side Request Forgery (SSRF)
**The risk:** Your server fetches a URL the user supplied, and the attacker points it at your internal network or cloud metadata service to steal credentials.

**How to tackle it:**
- Validate and allowlist any URL the server is asked to fetch.
- Block requests to internal IP ranges and metadata endpoints.
- Do not send raw responses from those fetches back to the user.

---

## Part 3: Race Conditions (Called Out Specifically)

You asked about "race" issues. A **race condition** is when two requests run at almost the same time and step on each other. The common security version is **TOCTOU** (Time of Check to Time of Use): you check something, then act on it, but the state changed in between.

**Real examples:**
- **Banking:** Account has 50 dollars. Attacker fires 100 transfer requests at once. Each one checks "balance is 50, ok" before any of them deducts. Money gets withdrawn multiple times.
- **Coupons:** A single-use discount code gets submitted in parallel and applied many times because each request passes the "not used yet" check before any marks it used.
- **One review / one vote per user:** Fire many requests at once and slip past the "already done?" check.

**How to tackle race conditions:**
- **Atomic database operations.** Combine the check and the update into one statement so the database does it as a single indivisible step. For example, decrement the balance with a `WHERE balance >= amount` condition instead of read-then-write.
- **Optimistic locking.** Add a version number to the row. The update only succeeds if the version still matches what you read. If not, retry with fresh data.
- **Pessimistic locking / mutexes.** Lock the resource so only one request touches it at a time. Use carefully, it can hurt performance.
- **Idempotency keys.** For payments and submissions, require a unique key so repeated requests are processed only once.
- **Code review rule:** Flag any check-then-act on shared state (balance checks before transfers, token checks before redemption) that is not protected by a database lock or atomic operation.

---

## Part 4: Precautions Checklist (Print This)

Before you ship, go down this list.

**Secrets and config**
- [ ] No secrets, keys, or passwords in the code or the git repo
- [ ] `.env` and similar are in `.gitignore` and not served publicly
- [ ] Secrets stored in a secrets manager or environment variables

**Input and output**
- [ ] All user input validated on the server
- [ ] Parameterized queries everywhere, no string-built SQL
- [ ] Output escaped to prevent XSS

**Auth and access**
- [ ] Authorization checked server-side on every protected action
- [ ] No IDOR: ownership verified before returning a resource
- [ ] Passwords hashed with bcrypt/scrypt/Argon2
- [ ] MFA available, login attempts rate-limited
- [ ] Sessions expire and are invalidated on logout

**Transport and storage**
- [ ] HTTPS/TLS enforced everywhere
- [ ] Sensitive data encrypted at rest
- [ ] Security headers set (CSP, HSTS, X-Frame-Options)

**Config and dependencies**
- [ ] Debug mode and verbose errors off in production
- [ ] All default credentials changed
- [ ] Cloud storage private by default
- [ ] Dependencies updated and scanned for known vulnerabilities

**Concurrency**
- [ ] Money, coupons, stock, and one-per-user actions use atomic ops or locking
- [ ] Idempotency keys on payments and critical submissions

**Operations**
- [ ] Security events logged, no secrets in logs
- [ ] Automated backups with a tested restore
- [ ] A rollback plan for bad deploys
- [ ] Rate limiting on login, signup, password reset, and APIs

---

## Sources
- OWASP Top 10 2021: https://owasp.org/Top10/2021/
- OWASP Top Ten project: https://owasp.org/www-project-top-ten/
- 8 Common Application Security Mistakes Beginners Make (Institute of Data): https://www.institutedata.com/blog/8-common-application-security-mistakes-beginners-make/
- Top 5 security mistakes software developers make (CSO Online): https://www.csoonline.com/article/3599778/top-5-security-mistakes-software-developers-make.html
- 10 Common Web Application Security Mistakes (Indusface): https://www.indusface.com/blog/10-common-web-application-security-mistakes/
- Race conditions (PortSwigger Web Security Academy): https://portswigger.net/web-security/race-conditions
- Practical Race Condition (TOCTTOU) Vulnerabilities in Web Applications (Defuse Security): https://defuse.ca/race-conditions-in-web-applications.htm
- Race Condition Vulnerabilities & Security Best Practices (Vaadata): https://www.vaadata.com/blog/what-is-a-race-condition-exploitations-and-security-best-practices/
