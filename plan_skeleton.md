# User Prompt
I want to make a plan for this activity; give me an executive summary of the plan and a skeleton or sections and subsections that we should cover?

We have a client who is interested in understanding Graphene OS.

In this first stage they are interested in understanding the general Graphene security offering, and which parts of the platform would be worth to look into first e.g. which parts of Graphene raise some eyebrows and would warrant a deeper dive.

can you make documentation about a real secure phone based on Graphene. It should only take a few hours to put together this initial document with your current understanding of it.

# GrapheneOS Security Assessment — Plan & Document Skeleton (v2)

> **Status:** Draft plan · **Date:** 2026-11-23 · **Owner:** Raj
> **Change from v1:** We can't contact the client, so the document covers all
> realistic personas, threat models and deployment models. Device scope is the
> Pixel 8 series through the newest supported Pixel, with differences between
> generations called out.

---

## 1. Executive Summary

- **Goal:** Give the client a complete first view of what GrapheneOS secures, how
  it does it, and which parts deserve a deeper review first.
- **Format:** An initial assessment of about 20–30 pages, built around a
  **reference secure phone** (a supported Pixel running GrapheneOS with a hardened
  configuration). Every device from the Pixel 8 to the newest supported model is
  compared in one matrix.
- **No client input:** Each section is written against several **personas and
  threat tiers**, and every assumption goes in an **assumption register**
  (Appendix A) so the client can confirm or correct them later.
- **Effort:** About 8–10 hours. Most of it is written from current knowledge,
  plus a verification pass on facts that change quickly: device support, end of
  support, Pixel 10 and newer status, Google's patch and source releases, and the
  OEM partnership.
- **Main output:** A ranked list of areas worth a deeper look, each with the
  reason, a risk hypothesis, the device generations affected and a proposed test
  approach.
- **Main message:** GrapheneOS is among the strongest mobile platforms against
  exploits and forensic extraction. Its main risks are in what it depends on and
  how it works in practice: Google's hardware, firmware and source releases;
  differences between device generations (new GPU and modem attack surface on
  newer devices); signing-key custody by a small team; the sandboxed Play layer;
  and limited enterprise management.

---

## 2. Phased Plan

### Phase 1 — Scope & Framing (no client input)
**Goal:** Replace client input with written assumptions and coverage across
personas and devices.

| #   | Task                | Details / Command                                                                    | Owner | Depends on | Done |
| --- | ------------------- | ------------------------------------------------------------------------------------ | ----- | ---------- | ---- |
| 1.1 | Persona matrix      | Personas P1–P5 (§3.1) with the assets and adversaries for each                       | Raj   | –          |      |
| 1.2 | Threat tiers        | T1 opportunistic → T4 nation-state 0-click (§3.2)                                    | Raj   | –          |      |
| 1.3 | Deployment models   | Individual, managed fleet, BYOD, air-gapped/minimal (§3.3)                           | Raj   | –          |      |
| 1.4 | Device scope        | Pixel 8 series → newest supported; build the device matrix (§5)                      | Raj   | –          |      |
| 1.5 | Assumption register | Every unconfirmed assumption, with an ID, the impact if wrong, and how to confirm it | Raj   | 1.1–1.4    |      |

*Tasks 1.1–1.4 can run in parallel.*

### Phase 2 — Descriptive Sections
**Goal:** Write the platform, hardening, privacy, forensic and operations sections
(§4–§10), with notes on how each applies to each persona and device.

| #   | Task                       | Details / Command                                                                   | Owner | Depends on | Done |
| --- | -------------------------- | ----------------------------------------------------------------------------------- | ----- | ---------- | ---- |
| 2.1 | Platform & trust model     | Hardware requirements, AVB, Titan M2, baseband isolation                            | Raj   | 1.4        |      |
| 2.2 | Device generation analysis | SoC, modem, GPU, fingerprint, radios and support windows; what differs for security | Raj   | 1.4        |      |
| 2.3 | Exploit mitigations        | hardened_malloc, MTE, exec spawning, kernel, Vanadium                               | Raj   | 2.1        |      |
| 2.4 | Privacy & permissions      | Network/Sensors permissions, Scopes, sandboxed Play, default connections            | Raj   | 2.1        |      |
| 2.5 | Physical & forensic        | BFU, auto-reboot, USB-C control, duress, PIN scrambling                             | Raj   | 2.1        |      |
| 2.6 | Operations & lifecycle     | Updates, signing, Auditor, enterprise fit, app compatibility                        | Raj   | 2.1        |      |
| 2.7 | Comparative baseline       | Stock Pixel, iOS with Lockdown Mode, Samsung Knox                                   | Raj   | 2.3–2.5    |      |

*Tasks 2.3–2.6 can run in parallel once 2.1 is done.*

### Phase 3 — Areas to Examine & Recommendations
**Goal:** Rank the deeper-dive candidates and define the Stage 2 work packages.

| #   | Task                     | Details / Command                                                                            | Owner | Depends on | Done |
| --- | ------------------------ | -------------------------------------------------------------------------------------------- | ----- | ---------- | ---- |
| 3.1 | Score each area          | Likelihood × impact × how hard it is to verify; mark the device generations affected         | Raj   | Phase 2    |      |
| 3.2 | Map to personas          | Which areas matter for which persona and threat tier                                         | Raj   | 3.1, 1.1   |      |
| 3.3 | Reference configurations | Baseline, high-risk and fleet hardening profiles (§12)                                       | Raj   | Phase 2    |      |
| 3.4 | Stage 2 proposal         | Work packages, effort, tooling (IDA Pro, Frida, lab Pixels per generation, forensic tooling) | Raj   | 3.1        |      |

### Phase 4 — Verification & Delivery
**Goal:** Every time-sensitive claim is checked against current sources.

| #   | Task                     | Details / Command                                                                                     | Owner | Depends on | Done |
| --- | ------------------------ | ----------------------------------------------------------------------------------------------------- | ----- | ---------- | ---- |
| 4.1 | Check device facts       | Supported devices list, support end dates, Pixel 10a/11 status, whether MTE is on per device          | Raj   | 2.2        |      |
| 4.2 | Check upstream facts     | Google AOSP device-tree and source-release changes, security bulletin cadence, OEM partnership status | Raj   | 2.1        |      |
| 4.3 | Check feature facts      | Current defaults: auto-reboot, USB-C mode, duress, eSIM handling, Auditor                             | Raj   | 2.3–2.6    |      |
| 4.4 | Claimed vs verified pass | Tag every claim as Documented / Observed / Assumed                                                    | Raj   | 4.1–4.3    |      |
| 4.5 | Peer read & deliver      | Exec summary first; assumption register attached                                                      | Raj   | 4.4        |      |

**Outside our control:**
- We can't confirm the client's needs, so the assumption register stands in for that
- GrapheneOS docs may lag behind recent changes, especially Pixel 10 and newer support
- Google's upstream policy changes may invalidate parts of the analysis

---

## 3. Document Skeleton

### 0. Executive Summary
- Overall verdict (which persona/tier it fits, and where it doesn't)
- Top strengths
- Top areas to examine (ranked)
- Device recommendation by persona
- Recommended next step (Stage 2)

### 1. Scope, Method & Confidence
- 1.1 Purpose and audience
- 1.2 Method: documentation review, prior research, analyst knowledge
- 1.3 Confidence labels: **Documented / Observed / Assumed**
- 1.4 Out of scope for Stage 1: hands-on testing, code audit, RE
- 1.5 Pointer to the assumption register (Appendix A)

### 2. Personas, Threat Tiers & Deployment Models
- **2.1 Personas**
  - P1 Executive / VIP (corporate espionage, travel risk)
  - P2 Journalist / activist / high-risk individual (targeted spyware, border seizure)
  - P3 Security / IT staff (admin credentials, MFA devices)
  - P4 Field / operational staff (device loss, coercion)
  - P5 Privacy-conscious general user
- **2.2 Threat tiers**
  - T1 Opportunistic theft / loss
  - T2 Commercial forensic extraction (seizure, border, legal)
  - T3 Commercial spyware vendor (1-click / 0-click)
  - T4 Nation-state (0-click chains, baseband, supply chain)
- **2.3 Deployment models**
  - Individually owned, user-managed
  - Organization-owned, managed fleet
  - BYOD with a work profile
  - Minimal / air-gapped "communications-only" device
- 2.4 Persona × tier × deployment heat map

### 3. GrapheneOS Overview
- 3.1 Project background, governance, funding, team size
- 3.2 Design philosophy (security-first, no root, AOSP-based)
- 3.3 What it is not (not a "privacy ROM", no root, no LineageOS-style device breadth)
- 3.4 Release channels and versioning

### 4. Platform Foundations & Trust Model
- 4.1 Why Pixel only: hardware requirements GrapheneOS enforces
- 4.2 Verified boot with custom AVB keys, re-locked bootloader, rollback protection
- 4.3 Titan M2 secure element: Weaver throttling, insider attack resistance, StrongBox
- 4.4 Storage encryption: file-based plus metadata encryption, key derivation
- 4.5 Baseband/modem and peripheral isolation (IOMMU), proprietary firmware still trusted
- 4.6 Trust boundaries diagram: Google HW/FW → AOSP → GrapheneOS → apps → network/carrier
- 4.7 Planned non-Pixel OEM device: status and implications

### 5. Device Generation Analysis (Pixel 8 → Latest)

**5.1 Device matrix** († = verify in Phase 4)

| Device                        | SoC              | Modem        | GPU                    | Fingerprint     | UWB        | Released  | Support end | Notes                                                                               |
| ----------------------------- | ---------------- | ------------ | ---------------------- | --------------- | ---------- | --------- | ----------- | ----------------------------------------------------------------------------------- |
| Pixel 8 / 8 Pro               | Tensor G3        | Exynos 5300  | Mali                   | Optical         | 8 Pro only | Oct 2023  | Oct 2030    | First gen with MTE; oldest in scope                                                 |
| Pixel 8a                      | Tensor G3        | Exynos 5300  | Mali                   | Optical         | No         | May 2024  | May 2031    | Budget G3; same security baseline                                                   |
| Pixel 9 / 9 Pro / 9 Pro XL    | Tensor G4        | Exynos 5400  | Mali                   | Ultrasonic      | Pro only   | Aug 2024  | Aug 2031    | Satellite SOS modem path                                                            |
| Pixel 9 Pro Fold              | Tensor G4        | Exynos 5400  | Mali                   | Side capacitive | Yes        | Sep 2024  | Aug 2031†   | Foldable; two displays                                                              |
| Pixel 9a                      | Tensor G4        | Exynos 5300  | Mali                   | Optical         | No         | Apr 2025  | Apr 2032    | Older modem than the rest of the 9 line                                             |
| Pixel 10 / 10 Pro / 10 Pro XL | Tensor G5 (TSMC) | Exynos 5400† | PowerVR (Imagination)† | Ultrasonic      | Pro only   | Aug 2025  | Aug 2032    | New fab, new GPU driver stack; arrived after Google stopped publishing device trees |
| Pixel 10 Pro Fold             | Tensor G5        | Exynos 5400† | PowerVR†               | Side capacitive | Yes        | Oct 2025† | Aug 2032†   | Foldable                                                                            |
| Pixel 10a                     | †                | †            | †                      | †               | †          | 2026†     | †           | Confirm existence, specs, GrapheneOS support                                        |
| Pixel 11 series               | Tensor G6†       | †            | †                      | †               | †          | Aug 2026† | †           | Confirm GrapheneOS support status                                                   |

**5.2 Security-relevant differences**
- 5.2.1 MTE: availability and default enforcement per generation
- 5.2.2 GPU driver: Mali (G3/G4) vs PowerVR (G5); a new kernel attack surface with
  little public history
- 5.2.3 Modem: Exynos 5300 vs 5400; satellite messaging/SOS paths; known baseband CVEs
- 5.2.4 Fingerprint sensor type: spoofing resistance and how it affects fingerprint + PIN unlock
- 5.2.5 Radios: UWB, Thread, satellite, NFC; extra attack surface on Pro models
- 5.2.6 Support window remaining (procurement lifetime value)
- 5.2.7 Foldables: extra display/hinge sensors, larger driver surface
- 5.2.8 Time from device launch to GrapheneOS support (Pixel 10 case study)

**5.3 Device recommendation by persona and tier**

### 6. Exploit Mitigations
- 6.1 hardened_malloc (guard regions, randomization, zero-on-free, quarantine)
- 6.2 Hardened libc / Bionic changes
- 6.3 Hardware memory tagging (MTE): OS-wide default, per-app opt-in, crash reporting
- 6.4 Exec-based app spawning instead of zygote forking (per-app ASLR)
- 6.5 Kernel and toolchain hardening (CFI, shadow call stack, reduced attack surface)
- 6.6 Vanadium browser and WebView: JIT off by default, site isolation, patch cadence
- 6.7 Per-app compatibility toggles and how they weaken protections
- 6.8 Coverage by device generation (links to §5)

### 7. Privacy & Permission Model
- 7.1 Network permission (per app)
- 7.2 Sensors permission
- 7.3 Storage Scopes and Contact Scopes
- 7.4 Sandboxed Google Play: architecture, privileges, compatibility shim, eSIM handling
- 7.5 User profiles, Private Space, work profile isolation
- 7.6 Default outbound connections (connectivity checks, update server, SUPL/PSDS proxies, attestation)
- 7.7 Radio controls: LTE-only, 2G off, per-connection Wi-Fi MAC randomization
- 7.8 Telemetry and metadata exposure to GrapheneOS infrastructure

### 8. Physical & Forensic Resistance
- 8.1 BFU vs AFU states and why they matter
- 8.2 Auto-reboot timer (default and how to tune it)
- 8.3 USB-C port control while locked
- 8.4 Duress PIN/password wipe
- 8.5 PIN scrambling, fingerprint + PIN two-factor unlock
- 8.6 Titan M2 brute-force throttling
- 8.7 Leaked forensic-vendor capability matrices: what they show and their limits
- 8.8 Coercion and border-crossing scenarios (by persona)

### 9. Operations & Lifecycle
- 9.1 Update pipeline, OTA server, release channels, seamless (A/B) updates
- 9.2 Signing-key custody, build reproducibility, transparency
- 9.3 Patch timing vs Google's bulletin and source-release changes
- 9.4 Auditor app and hardware-based attestation (single device and fleet)
- 9.5 Installation and procurement supply chain (web installer, hardware sourcing)
- 9.6 Backup and recovery options and their security trade-offs

### 10. Enterprise & Compatibility
- 10.1 Android Enterprise / work profile support; what works with MDM
- 10.2 No fleet console: options and compensating controls
- 10.3 Play Integrity API: banking and corporate apps; hardware attestation allowlisting
- 10.4 Android Auto, Wear OS, eSIM, RCS, payments (no Google Wallet NFC)
- 10.5 Usability vs security trade-offs by persona

### 11. Areas to Examine First (Ranked)

| #   | Area                           | Why it raises eyebrows                                                             | Devices           | Personas / tiers | Proposed Stage 2 test                               |
| --- | ------------------------------ | ---------------------------------------------------------------------------------- | ----------------- | ---------------- | --------------------------------------------------- |
| 1   | Upstream dependency on Google  | Device trees no longer published, changes to source/patch cadence, closed firmware | All; G5+ most     | All / T3–T4      | Patch-lag timeline analysis; upstream diff tracking |
| 2   | Supply chain & governance      | Small team, signing-key custody, bus factor, reproducible builds                   | All               | All / T4         | Build-reproducibility test; governance review       |
| 3   | GPU driver (PowerVR on G5)     | New driver stack, little public research history                                   | Pixel 10+         | P1–P3 / T3–T4    | Driver attack-surface mapping; fuzzing scope        |
| 4   | Baseband / cellular stack      | Largest closed surface left; satellite paths; how strong the IOMMU isolation is    | All; 5400 vs 5300 | P1, P2 / T4      | Firmware RE scope (IDA); CVE history review         |
| 5   | Sandboxed Play shim            | Compatibility code with an IPC surface; eSIM provisioning path                     | All               | P1, P4, P5       | Shim code review; IPC fuzzing                       |
| 6   | Browser / WebView patch lag    | Vanadium vs upstream Chromium on in-the-wild 0-days                                | All               | All / T3         | Historical patch-latency study                      |
| 7   | MTE / hardened_malloc opt-outs | Per-app weakening; how fail-open behaves in practice                               | All               | All / T3         | Opt-out census of common apps                       |
| 8   | Forensic claims                | BFU and auto-reboot hold up on paper; need validation against current tools        | All               | P2, P4 / T2      | Lab extraction test per generation                  |
| 9   | Default network behaviour      | Metadata exposure to GrapheneOS servers                                            | All               | P2, P5           | Traffic capture and analysis                        |
| 10  | Biometric differences          | Optical vs ultrasonic vs capacitive spoofing resistance                            | Per device        | P2, P4 / T2      | Spoof testing                                       |
| 11  | Enterprise manageability       | No fleet console; MDM gaps; attestation at scale                                   | All               | Fleet / BYOD     | MDM compatibility matrix                            |

### 12. Reference Secure-Phone Configurations
- **12.1 Hardware selection**
  - Recommended device per persona
  - Procurement and supply-chain hygiene
- **12.2 Installation and verification**
  - Web installer
  - Bootloader re-lock
  - Auditor pairing
- **12.3 Profile A — Baseline (P5, T1–T2)**
- **12.4 Profile B — High-risk (P1–P2, T3–T4)**
  - No Play
  - Strict USB mode
  - Short auto-reboot
  - Duress PIN
  - LTE-only
- **12.5 Profile C — Managed fleet (P3–P4)**
  - Work profile
  - Attestation
  - Compensating controls
- 12.6 App policy: no Play vs sandboxed Play in a separate profile
- 12.7 Hardening checklist (settings table, per profile)

### 13. Comparative Positioning
- 13.1 GrapheneOS vs stock Pixel (Android 16+)
- 13.2 GrapheneOS vs iOS with Lockdown Mode
- 13.3 GrapheneOS vs Samsung Knox / hardened Android Enterprise
- 13.4 Summary comparison table

### 14. Recommendations & Proposed Stage 2
- 14.1 Key findings
- 14.2 Stage 2 work packages (scope, effort, tooling, devices needed)
- 14.3 Lab requirements (one device per SoC generation: G3, G4, G5 and newer)
- 14.4 Open questions for the client (from the assumption register)

### Appendices
- **A.** Assumption register (ID · assumption · impact if wrong · how to confirm)
- **B.** Glossary (AVB, BFU/AFU, MTE, Weaver, StrongBox, IOMMU, etc.)
- **C.** Device specification detail
- **D.** Hardening settings reference
- **E.** References and sources (with claimed vs verified tags)