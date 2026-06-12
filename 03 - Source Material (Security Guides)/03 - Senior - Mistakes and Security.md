# Senior Coder / Architect: Mistakes and Security

At the senior level the code is rarely the problem. The mistakes are in judgment, system design, trade-offs, and the things that only show up at scale or under a determined attacker. A senior person's bad decision does not crash one feature, it costs the company money, data, or the whole platform. This list is about those decisions.

Last updated: June 2026.

---

## Part 1: General Mistakes (Non-Security)

1. **Designing for a scale you do not have.** Building for a billion users when you have a thousand, paying enormous complexity and cost for headroom you never use. The mirror mistake is ignoring scale entirely. Seniority is knowing which one applies. Fix: design for the next order of magnitude, not the tenth.

2. **Believing the eight fallacies of distributed systems.** The network is reliable, latency is zero, bandwidth is infinite, the network is secure, topology never changes, there is one admin, transport is free, the network is homogeneous. Every one of these is false, and every one causes outages when assumed true. Fix: design for partial failure as the normal case.

3. **No clear failure and recovery story.** No defined RTO/RPO, untested backups, no disaster recovery drills, single points of failure nobody mapped. Fix: know your recovery objectives, test restores and failovers regularly.

4. **Distributed monolith.** Splitting into services that are so tightly coupled they must deploy together. You get all the pain of microservices and none of the independence. Fix: split along real boundaries, or stay a modular monolith.

5. **Premature consistency or the wrong consistency model.** Forcing strong consistency everywhere (slow, fragile) or going eventually consistent on data that needs to be correct (money, inventory). Fix: choose per use case, be explicit about it.

6. **Ignoring the org chart (Conway's Law).** The architecture ends up mirroring team communication whether you plan it or not. Fix: align service boundaries with team boundaries on purpose.

7. **No deprecation or migration strategy.** Shipping v2 but leaving v1 alive forever, supporting both at growing cost. Fix: plan sunsets with timelines and client communication.

8. **Hero culture and bus factor of one.** Critical knowledge lives in one person's head, no docs, no decision records. Fix: write architecture decision records, spread knowledge, document the why.

9. **Optimizing the wrong layer.** Spending weeks shaving milliseconds off code while the real cost is a slow query or a chatty network call. Fix: measure end to end before deciding where to invest.

10. **Vendor lock-in with no exit.** Building so deeply on one provider's proprietary services that leaving is impossible, then getting squeezed on price or hit by their outage. Fix: weigh lock-in consciously, abstract where the risk is high.

11. **Letting "we'll fix it later" become the architecture.** Temporary decisions calcify. Fix: revisit deliberately, schedule the refactors.

---

## Part 2: Security Mistakes (Senior / Architectural)

At this level security failures are systemic. They are about trust boundaries, blast radius, and what happens after an attacker gets the first foothold.

### 1. No Threat Model
**The risk:** Security is treated as a feature or a checklist instead of a design input. You never asked "who would attack this, what do they want, where are our trust boundaries."

**Fix:** Threat model major features and the system as a whole. Identify assets, attackers, entry points, and trust boundaries before building. Update it as the system changes.

### 2. Huge Blast Radius
**The risk:** One compromised service, key, or credential gives access to everything. Flat networks, over-privileged IAM roles, one database for everything, secrets that unlock the whole estate.

**Fix:** Segment. Least privilege on every identity and role. Separate environments and data stores. Assume any single component will be breached and limit what that breach reaches.

### 3. Weak Identity and Trust Architecture
**The risk:** Implicit trust inside the perimeter, long-lived credentials, no central identity, services that authenticate users but not each other.

**Fix:** Zero trust architecture. Strong central identity, short-lived credentials, mutual auth between services, continuous verification rather than trust-by-location.

### 4. Insecure Software Supply Chain
**The risk:** Your build pipeline, dependencies, and CI/CD are the soft target. A poisoned dependency, a compromised build server, or an unsigned artifact gets shipped straight to production. This is how some of the largest breaches happened.

**Fix:** Pin and verify dependencies, generate a software bill of materials (SBOM), sign artifacts, lock down who can change the pipeline, scan continuously. Treat the pipeline as production infrastructure.

### 5. Secrets and Key Management at Scale
**The risk:** Secrets sprawl across config files, repos, and developer laptops. No rotation, no audit, no idea who can access what. One leak is catastrophic.

**Fix:** Central secrets management, automatic rotation, short TTLs, full audit trail, hardware-backed keys for the crown jewels.

### 6. No Detection or Incident Response
**The risk:** The breach is not the failure, not noticing it for months is. No centralized logging, no alerting on anomalies, no tested incident response plan, no one on call who knows what to do.

**Fix:** Centralized, tamper-resistant logging and a SIEM. Alert on meaningful anomalies. Write and rehearse an incident response plan. Run tabletop exercises and post-incident reviews.

### 7. Compliance and Data Governance as an Afterthought
**The risk:** Storing personal data with no idea where it lives, no retention policy, no deletion path, ignoring GDPR / regional data laws until a regulator or breach forces the issue.

**Fix:** Data classification, mapped data flows, retention and deletion policies, encryption and access controls aligned to the data's sensitivity, privacy by design.

### 8. Designing Out the Human Failure Modes
**The risk:** Security that depends on every engineer doing the right thing every time. People will paste a secret, click a phish, or skip a check under deadline.

**Fix:** Make the secure path the easy path. Guardrails in tooling, automated checks in CI, defaults that are safe, so a tired human cannot easily create a hole.

### 9. Underestimating Insider and Account Compromise
**The risk:** All defenses point outward. A compromised employee account or a malicious insider has standing access to everything.

**Fix:** Least privilege, just-in-time access, separation of duties, monitoring of privileged actions, MFA everywhere including internal tools.

---

## Part 3: Precautions Checklist (Senior / Architect)

**Design**
- [ ] Threat model exists and is kept current
- [ ] Trust boundaries are explicit and defended
- [ ] Single points of failure identified and addressed
- [ ] Consistency model chosen deliberately per use case

**Blast radius and identity**
- [ ] Least privilege on every identity, role, and service
- [ ] Network and data segmentation limits a breach
- [ ] Zero trust between services, short-lived credentials, mutual auth
- [ ] MFA everywhere, including internal and admin tools

**Supply chain and secrets**
- [ ] Dependencies pinned, verified, SBOM generated
- [ ] Build pipeline locked down and treated as production
- [ ] Artifacts signed
- [ ] Central secrets management with rotation and audit

**Detection and response**
- [ ] Centralized tamper-resistant logging and alerting
- [ ] Incident response plan written and rehearsed
- [ ] On-call knows the runbooks

**Governance and resilience**
- [ ] Data classified, mapped, with retention and deletion policies
- [ ] Compliance requirements designed in, not bolted on
- [ ] Backups, DR, and failover tested on a schedule
- [ ] Architecture decisions recorded (no bus factor of one)

---

## Sources
- The Eight Fallacies of Distributed Computing (InfoQ): https://www.infoq.com/news/2021/09/fallacies-distributed-computing/
- The Hidden Fallacies of Distributed Systems: https://thearchitectsnotebook.substack.com/p/the-3-hidden-fallacies-of-distributed
- Security Challenges in Distributed Systems: https://medium.com/@thefilmmaker436/security-challenges-in-distributed-systems-7010279b2ba5
- OWASP Top 10 2021 (A04 Insecure Design, A08 Integrity Failures): https://owasp.org/Top10/2021/
