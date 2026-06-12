# Intermediate Coder: Mistakes and Security

The junior list was about getting the basics wrong. By the intermediate stage the syntax is fine and the app ships. The mistakes move up a level: they are now about architecture, APIs, data, and the gap between "it works" and "it holds up in production under attack." Same structure as before: general mistakes, then security, then a checklist.

Last updated: June 2026.

---

## Part 1: General Mistakes (Non-Security)

1. **Overengineering.** Reaching for microservices, Kubernetes, and event queues for an app with 200 users. Complexity you do not need is a cost you pay forever. Fix: build the simplest thing that works, split it only when you feel real pain.

2. **The opposite: no structure at all.** One giant file, business logic tangled into controllers, no separation of concerns. Fix: clear layers (routing, business logic, data access).

3. **Breaking REST statelessness by accident.** Storing session state in server memory or an in-process cache keyed by user. Works on one server, falls apart the moment you run two. Fix: keep servers stateless, push shared state to a database or cache like Redis.

4. **N+1 queries and no indexes.** The app is fast with 100 rows and dies at 100,000. Fix: profile your queries, add indexes, batch or eager-load.

5. **No caching strategy, or caching the wrong things.** Either hammering the database for data that never changes, or caching so aggressively that users see stale data. Fix: cache deliberately with clear invalidation rules.

6. **Inconsistent API design.** One endpoint returns `userId`, another `user_id`, a third does five things at once. Fix: pick conventions and apply them everywhere, one endpoint one job.

7. **No API versioning.** You change a response shape and break every client in the wild. Fix: version from the start (`/v1/`).

8. **Ignoring failure modes.** Assuming the network, the database, and the third-party API are always up and instant. They are not. Fix: timeouts, retries with backoff, circuit breakers, graceful degradation.

9. **Poor migration discipline.** Editing the database by hand, no migration files, no way to reproduce the schema. Fix: versioned migrations checked into the repo.

10. **Weak observability.** No metrics, no tracing, logs that do not correlate across services. When it breaks you cannot tell where. Fix: structured logs with request IDs, basic metrics and dashboards.

11. **Letting tech debt compound silently.** Quick hacks pile up with no ticket, no comment, no plan. Fix: track it, name it, pay it down in slices.

12. **Treating the cloud bill as someone else's problem.** Leaving big instances running, no autoscaling limits, unbounded log retention. Fix: set budgets and alerts.

---

## Part 2: Security Mistakes (Intermediate)

At this level the dangerous bugs are mostly in APIs, authorization logic, and how services trust each other. This maps closely to the OWASP API Security Top 10.

### 1. Broken Object Level Authorization (BOLA / IDOR at scale)
**The risk:** The number one API vulnerability. An endpoint like `GET /api/orders/4012` returns the order without checking the caller owns it. Change the number, read anyone's data.

**Fix:** On every object access, verify the authenticated user is allowed to touch that specific object. Do not rely on the ID being hard to guess. Centralize the ownership check so you cannot forget it on a new endpoint.

### 2. Broken Function Level Authorization
**The risk:** A normal user calls an admin-only function (`POST /api/admin/deleteUser`) because the only thing stopping them was a hidden button in the UI.

**Fix:** Enforce role checks server-side on every privileged action. Default to deny.

### 3. Excessive Data Exposure
**The risk:** The API returns the full database object and the frontend just hides the extra fields. Attackers read the raw response and get password hashes, internal flags, other users' emails, unmasked payment data.

**Fix:** Return only the fields the client needs. Use explicit response schemas / serializers, never "send the whole model."

### 4. Mass Assignment
**The risk:** You bind request JSON straight onto your model, so a user adds `"isAdmin": true` or `"balance": 99999` to the signup payload and the framework happily saves it.

**Fix:** Allowlist exactly which fields a request may set. Never trust the client to send only the fields you expected.

### 5. No Rate Limiting or Throttling
**The risk:** Login endpoints get brute-forced, APIs get scraped, and a single client can take the service down. Also enables the race conditions from the junior doc.

**Fix:** Rate limit per user and per IP, throttle expensive endpoints, add lockouts and backoff on auth.

### 6. Misplaced Trust Between Services (Castle and Moat)
**The risk:** Moving to microservices but keeping the mindset that anything inside the VPC is trusted. Service A trusts Service B with no auth. An attacker who finds one small SSRF or foothold in a public service can then call internal APIs freely and dump databases.

**Fix:** Zero trust between services. Authenticate and authorize service-to-service calls (mTLS, signed tokens). Treat the internal network as hostile.

### 7. Secrets in the Wrong Place
**The risk:** API keys in the frontend bundle, secrets in environment variables logged on crash, long-lived credentials that never rotate.

**Fix:** Use a secrets manager (Vault, AWS Secrets Manager). Keep secrets server-side only. Rotate them. Scope keys to least privilege.

### 8. Insecure Direct Use of Third-Party Input
**The risk:** Trusting data from a webhook, a partner API, or a message queue without verifying its signature or validating it. Webhooks especially get spoofed.

**Fix:** Verify webhook signatures, validate all external input, do not assume the source is who it claims.

### 9. CORS and Security Headers Misconfigured
**The risk:** `Access-Control-Allow-Origin: *` on authenticated endpoints, missing CSP, missing HSTS. Opens you to data theft from malicious sites.

**Fix:** Lock CORS to known origins, set CSP, HSTS, and the standard security headers.

### 10. JWT and Session Handling Done Wrong
**The risk:** JWTs with `alg: none` accepted, no expiry, no revocation, signing secret weak or shared. Once issued, a stolen token works forever.

**Fix:** Verify the algorithm explicitly, short expiry plus refresh tokens, a revocation mechanism, strong signing keys.

---

## Part 3: Precautions Checklist (Intermediate)

**API and authorization**
- [ ] Every object access checks ownership (no BOLA/IDOR)
- [ ] Every privileged function checks role server-side
- [ ] Responses return only needed fields (no over-exposure)
- [ ] Input fields are allowlisted (no mass assignment)
- [ ] API is versioned

**Trust and secrets**
- [ ] Service-to-service calls are authenticated (zero trust)
- [ ] Secrets live in a secrets manager, scoped and rotated
- [ ] Webhooks and external input are signature-verified and validated

**Resilience and abuse**
- [ ] Rate limiting and throttling on auth and expensive endpoints
- [ ] Timeouts, retries with backoff, and circuit breakers on external calls
- [ ] Servers are stateless; shared state in DB/cache

**Web hardening**
- [ ] CORS locked to known origins
- [ ] CSP, HSTS, and security headers set
- [ ] JWT algorithm pinned, tokens expire, revocation exists

**Operations**
- [ ] Versioned, repeatable database migrations
- [ ] Structured logs with request IDs, metrics, and dashboards
- [ ] Cost budgets and alerts set

---

## Sources
- OWASP API Security Top 10: https://owasp.org/www-project-api-security/
- API Design Mistakes and Best Practices: https://eleopardsolutions.com/api-design-mistakes-and-best-practices/
- 10 Common API Development Mistakes (DEV): https://dev.to/neelp03/10-common-api-development-mistakes-and-how-to-avoid-them-489o
- 5 Common API Security Mistakes (DEV): https://dev.to/jigar_online/5-common-api-security-mistakes-developers-still-make-and-how-to-fix-them-1odp
- Security Challenges in Distributed Systems: https://medium.com/@thefilmmaker436/security-challenges-in-distributed-systems-7010279b2ba5
