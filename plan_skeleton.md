# GrapheneOS Security Assessment — Plan & Document Skeleton

> **Status:** Draft plan · **Date:** 2026-11-23 · **Owner:** Raj · **Peer reviewer:** _TBD_
> **Classification:** Client confidential (TLP:AMBER) — internal working plan

---

## 1. Executive Summary

- **Goal:** Give the client a complete first view of what GrapheneOS secures, how
  it does it, and which parts deserve a deeper review first.
- **Format:** An initial assessment built around a **reference secure phone** (a
  supported Pixel running GrapheneOS with a hardened configuration). As of
  2026-11-23 that is a **Pixel 10-series** device: the newer Pixel 11 is not yet
  supported by GrapheneOS. Every device
  from the Pixel 8 to the newest supported model is compared in one matrix.
- **Why Pixel 8 is the floor:** It is the first generation with hardware memory
  tagging (MTE) and Google's 7-year support commitment. Pixel 6/7 are still
  supported by GrapheneOS but are out of scope; this is stated in the document in
  case the client already owns them.
- **No client input:** The document is written against three **reference
  profiles** (A Baseline, B High-risk, C Managed fleet) that cover the realistic
  personas, threat tiers and deployment models. The full persona and tier lists
  are kept as reference tables (Appendix B). Every assumption goes in an
  **assumption register** (Appendix A) so the client can confirm or correct it.
- **Effort, in two cuts:**
  - **Core cut (~3–4 h)** — meets the client's "few hours" expectation: §0
    Executive Summary, §5 Device matrix, §11 Areas to examine, §12 Reference
    configurations, Appendix A. Deliverable on its own.
  - **Full document (~8–10 h, 20–30 pages)** — adds the descriptive sections
    (§3–§10, §13) behind the core cut.
- **Main output:** A ranked list of areas worth a deeper look, each with the
  reason, a risk rating, the effort to verify, the device generations affected and
  a proposed test approach.
- **Working hypothesis (to be confirmed by the research, not assumed):**
  GrapheneOS is among the strongest mobile platforms against exploits and forensic
  extraction. Its main risks are in what it depends on and how it works in
  practice: Google's hardware, firmware and source releases; differences between
  device generations (GPU and modem attack surface); signing-key custody and
  infrastructure run by a small team; the sandboxed Play layer; limited
  detection and incident-response options; and limited enterprise management.

---

## 2. Phased Plan

**Effort summary**

| Phase                                   | Estimate  | In core cut?                      |
| --------------------------------------- | --------- | --------------------------------- |
| 1 — Scope, framing & fast-moving facts  | 1.5 h     | Yes                               |
| 2 — Descriptive sections                | 4–5 h     | Only 2.2 (device analysis)        |
| 3 — Areas to examine & recommendations  | 1.5 h     | Yes (3.1, 3.3)                    |
| 4 — Verification & delivery             | 1–1.5 h   | Yes (shortened)                   |
| **Total**                               | **8–9.5 h** | **Core cut ≈ 3–4 h**            |

### Phase 1 — Scope, Framing & Fast-Moving Facts (~1.5 h)
**Goal:** Replace client input with written assumptions, and settle the facts that
change quickly *before* anything is written on top of them.

| #   | Task                   | Details                                                                                                         | Owner | Depends on | Est.  | Done |
| --- | ---------------------- | --------------------------------------------------------------------------------------------------------------- | ----- | ---------- | ----- | ---- |
| 1.1 | Reference profiles     | Define profiles A/B/C (doc §2.1) and map personas P1–P5, tiers T1–T4 and deployment models onto them (doc §2.2–§2.5) | Raj   | –          | 20 m  | [x]  |
| 1.2 | Device facts           | Supported devices list, support end dates, Pixel 10a and Pixel 11 series status and specs, Titan M2 and MTE per generation (doc §5) | Raj   | –          | 30 m  | [x]  |
| 1.3 | Upstream facts         | Google device-tree and source-release changes, security bulletin cadence, OEM partnership status (doc §4.7, §9.3) | Raj   | –          | 20 m  | [x]  |
| 1.4 | Project facts          | Governance, team, infrastructure hosting and jurisdiction, any recent relocation (doc §3.1)                     | Raj   | –          | 10 m  | [x]  |
| 1.5 | Assumption register    | Every unconfirmed assumption, with an ID, the impact if wrong, and how to confirm it (Appendix A)               | Raj   | 1.1–1.4    | 10 m  | [x]  |

*Tasks 1.1–1.4 can run in parallel.*

### Phase 2 — Descriptive Sections (~4–5 h)
**Goal:** Write the overview, platform, device, hardening, privacy, forensic,
operations and enterprise sections (doc §3–§10) and the comparison (doc §13),
noting how each applies to each profile and device generation.

| #   | Task                       | Details                                                                                          | Owner | Depends on | Est.  | Done |
| --- | -------------------------- | ------------------------------------------------------------------------------------------------ | ----- | ---------- | ----- | ---- |
| 2.1 | Overview                   | Background, governance, infrastructure, design philosophy (doc §3)                               | Raj   | 1.4        | 20 m  | [x]  |
| 2.2 | Platform & trust model     | Hardware requirements, AVB, Titan M2, baseband isolation (doc §4)                                | Raj   | 1.2, 1.3   | 30 m  | [x]  |
| 2.3 | Device generation analysis | SoC, modem, GPU, fingerprint, radios, support windows; what differs for security (doc §5)        | Raj   | 1.2        | 45 m  | [x]  |
| 2.4 | Exploit mitigations        | hardened_malloc, MTE, exec spawning, kernel, Vanadium (doc §6)                                   | Raj   | 2.2        | 30 m  | [x]  |
| 2.5 | Privacy, network & apps    | Permissions, Scopes, sandboxed Play, default connections, VPN/DNS, app sourcing (doc §7)          | Raj   | 2.2        | 35 m  | [x]  |
| 2.6 | Physical & forensic        | BFU, auto-reboot, USB-C control, duress, PIN scrambling, border scenarios (doc §8)               | Raj   | 2.2        | 30 m  | [x]  |
| 2.7 | Operations & lifecycle     | Updates, signing, Auditor, procurement, detection & incident response (doc §9)                   | Raj   | 2.2        | 30 m  | [x]  |
| 2.8 | Enterprise & compatibility | MDM, Play Integrity, payments, usability trade-offs (doc §10)                                    | Raj   | 2.5, 2.7   | 20 m  | [x]  |
| 2.9 | Comparative baseline       | Stock Pixel, iOS with Lockdown Mode, Samsung Knox (doc §13)                                      | Raj   | 2.4–2.6    | 20 m  | [x]  |

*Tasks 2.4–2.7 can run in parallel once 2.2 is done.*

### Phase 3 — Areas to Examine & Recommendations (~1.5 h)
**Goal:** Rank the deeper-dive candidates and define the Stage 2 work packages.

| #   | Task                     | Details                                                                                                         | Owner | Depends on | Est.  | Done |
| --- | ------------------------ | --------------------------------------------------------------------------------------------------------------- | ----- | ---------- | ----- | ---- |
| 3.1 | Rate each area           | **Risk** = likelihood × impact (H/M/L) sets the rank. **Verification effort** (H/M/L) is a separate column that feeds Stage 2 costing, not the rank. Mark device generations affected (doc §11) | Raj   | Phase 2    | 30 m  | [ ]  |
| 3.2 | Map to profiles          | Which areas matter for which profile (A/B/C)                                                                    | Raj   | 3.1, 1.1   | 10 m  | [ ]  |
| 3.3 | Reference configurations | Profile A, B, C hardening configurations (doc §12)                                                              | Raj   | Phase 2    | 30 m  | [ ]  |
| 3.4 | Stage 2 proposal         | Work packages, effort, tooling (IDA Pro, Frida, lab Pixels per generation, forensic tooling) (doc §14)          | Raj   | 3.1        | 20 m  | [ ]  |

### Phase 4 — Verification & Delivery (~1–1.5 h)
**Goal:** Remaining claims are checked and tagged; the document is reviewed by
someone other than the author.

| #   | Task                     | Details                                                                                   | Owner         | Depends on | Est.  | Done |
| --- | ------------------------ | ----------------------------------------------------------------------------------------- | ------------- | ---------- | ----- | ---- |
| 4.1 | Check feature facts      | Current defaults: auto-reboot, USB-C mode, duress, eSIM handling, Auditor                 | Raj           | 2.4–2.7    | 20 m  | [ ]  |
| 4.2 | Claimed vs verified pass | Tag every claim Documented / Secondary / Observed / Assumed; re-check anything Phase 1 left as †      | Raj           | 4.1        | 20 m  | [ ]  |
| 4.3 | Executive summary        | Write doc §0 last, from §11 and §12                                                       | Raj           | 4.2        | 15 m  | [ ]  |
| 4.4 | Peer read                | Accuracy, tone, and that the core cut stands on its own                                   | _Reviewer TBD_ | 4.3       | 20 m  | [ ]  |
| 4.5 | Deliver                  | Add classification and limitations disclaimer; attach assumption register                 | Raj           | 4.4        | 5 m   | [ ]  |

**Outside our control:**
- We can't confirm the client's needs, so the assumption register stands in for that
- GrapheneOS docs may lag behind recent changes, especially support for the newest devices
- Google's upstream policy changes may invalidate parts of the analysis

### Phase 1 Findings — Fact Check (2026-11-23)

Sources: grapheneos.org (FAQ, releases, features) read 2026-11-23, plus press
coverage. **Primary** = GrapheneOS or Google; **Secondary** = press only.

**Device facts (task 1.2)**

| Fact | Finding | Source |
| --- | --- | --- |
| Supported Pixels in scope | Pixel 8, 8 Pro, 8a, 9, 9 Pro, 9 Pro XL, 9 Pro Fold, 9a, 10, 10 Pro, 10 Pro XL, 10 Pro Fold, 10a all officially supported | Primary |
| Older Pixels | Pixel 6a, 7, 7 Pro, 7a, Fold, Tablet still supported; Pixel 6/6 Pro on legacy extended support (patch level frozen) | Primary |
| Support end dates | As in doc §5.1; corrections: 9 Pro Fold **Aug 2031** confirmed, 10 Pro Fold **Oct 2032** (not Aug), 10a **Mar 2033** | Primary |
| **Pixel 11 series** | **Not supported by GrapheneOS yet** (absent from FAQ). Delay attributed to missing MTE enablement; GrapheneOS said on 2026-11-18 it now meets requirements and will be supported after Android 17 QPR2 lands in AOSP | Secondary |
| Pixel 11 hardware | Tensor G6; **MediaTek M90 modem** (first non-Exynos Pixel modem); PowerVR C-Series GPU; **Titan M3** secure element; ultrasonic fingerprint on non-Fold models; announced 2026-08-12 | Secondary |
| Pixel 10a | Released 2026-03-05; **Tensor G4** (previous-gen SoC, Mali GPU); **Exynos 5400** modem (Google-confirmed); optical fingerprint (one review) | Primary + Secondary |
| Pixel 10 | Exynos 5400 modem carried over; PowerVR DXT-48-1536 GPU; Titan M2 still present | Secondary (Titan: Google) |
| MTE | GrapheneOS uses MTE by default for the base OS and known-compatible user apps on 8th-gen and later Pixels; MTE is a hard requirement for new devices | Primary |
| Latest release | 2026111800, Android 17 QPR2, 2026-11-05 Pixel security patch level, kernel based on Linux 6.18 | Primary |
| Feature defaults | Auto-reboot **18 h** (10 min–72 h or off); USB-C **charging-only when locked**; duress PIN/password present | Primary |

**Upstream facts (task 1.3)**

| Fact | Finding | Source |
| --- | --- | --- |
| Device trees | With Android 16 (2025) Google moved the AOSP reference target to Cuttlefish and stopped publishing Pixel device trees and driver binaries | Secondary |
| Kernel source | Pixel kernel sources now obtained via a request form and Drive link with squashed history (GrapheneOS claim); base kernel tree still in AOSP | Secondary |
| AOSP cadence | From 2026 Google publishes AOSP source only in **Q2 and Q4**; Pixel monthly patches unchanged | Primary (Google statement via press) |
| Security bulletins | Risk-Based Update System since 2025: monthly bulletins carry only high-risk fixes; full bulletin is **quarterly** (first Sep 2025) | Primary (Android Enterprise notice) |
| OEM partner | **Motorola**, announced at MWC on 2026-03-01. First device **Motorola Signature 27** (Snapdragon, MTE, 7-year support); launch date and GrapheneOS availability not confirmed. Motorola provides engineers, not funding. 2027 Razr foldables next | Secondary |

**Project facts (task 1.4)**

| Fact | Finding | Source |
| --- | --- | --- |
| Legal entity | GrapheneOS Foundation, Canadian non-profit (not a registered charity), created March 2023, Toronto | Primary |
| Team | Roughly 10 full-time developers (figures vary 6–10; self-reported) | Primary (forum) |
| Funding | Mainly donations; company collaborations; Motorola is not a funder | Primary + Secondary |
| Infrastructure | Nov 2025: left France and OVH, citing French pressure on encryption. Update mirrors on sponsored servers (US, temporarily London); DNS on Vultr/BuyVM anycast; remaining services (email, Matrix, forum, Mastodon, **attestation**) moving to Netcup then Toronto colocation. Whether the move is complete in 2026 is **unverified** | Primary (project post) |
| Update integrity | Updates verified by signature and downgrade protection at three layers (updater, update_engine, verified boot), so mirror hosting is an availability risk more than an integrity risk | Primary |

**What this changes in the document**
- The "latest" device (Pixel 11) is **not yet supported**. The reference secure phone
  should be a Pixel 10-series device until Pixel 11 support ships.
- Pixel 11 introduces **three new security components at once** (MediaTek modem,
  Titan M3, new PowerVR generation) — added to §5.2 and §11.
- Pixel 10a is a G4 device (Mali, not PowerVR), so the GPU split is by SoC, not by
  model year.
- Motorola Signature 27 is a credible non-Pixel option to track (doc §4.7).

---

## 3. Document Skeleton

> Front matter: classification (TLP:AMBER), version, date, author, reviewer, and a
> limitations disclaimer (desk-based assessment; no hands-on testing in Stage 1).

### 0. Executive Summary
- Overall verdict (which profile it fits, and where it doesn't)
- Top strengths
- Top areas to examine (ranked)
- Device recommendation by profile
- Recommended next step (Stage 2)

### 1. Scope, Method & Confidence
- 1.1 Purpose and audience
- 1.2 Device scope: Pixel 8 → newest supported; why Pixel 8 is the floor (MTE,
  7-year support); note on Pixel 6/7 if the client already owns them
- 1.3 Method: documentation review, prior research, analyst knowledge
- 1.4 Confidence labels: **Documented / Secondary / Observed / Assumed**
  (Secondary = press or third-party reporting only). Stage 1 is
  desk-based, so "Observed" is used only where we have first-hand evidence;
  most claims will be Documented or Assumed
- 1.5 Out of scope for Stage 1: hands-on testing, code audit, RE
- 1.6 Pointer to the assumption register (Appendix A)

### 2. Reference Profiles
- **2.1 Profiles used throughout the document**
  - **A — Baseline:** privacy-conscious individual; opportunistic theft and
    commercial forensics (T1–T2)
  - **B — High-risk:** executive/VIP, journalist, activist; targeted spyware and
    nation-state (T3–T4); coercion and border seizure
  - **C — Managed fleet:** security/IT staff and field staff on organization-owned
    or BYOD devices; loss, coercion, credential theft (T1–T3)
- **2.2 How a profile is chosen** (two questions, applied in order)
  1. **Threat tier sets the hardening level:** highest credible tier T1–T2 → A
     controls; T3–T4 → B controls.
  2. **Ownership sets the management model:** organization-managed (fleet or
     BYOD) → C. If the user also faces T3–T4, apply B controls inside C, written
     **C+B**.
  - BYOD at T3–T4 is **not recommended**: a work profile cannot enforce
    device-wide controls (auto-reboot, USB-C mode, no Play, duress PIN), so issue
    a dedicated device instead.

- **2.3 Persona summary** (full definitions in Appendix B)

  | Persona                               | Main assets                                         | Likely adversaries                                       | Highest credible tier  | Default profile               |
  | ------------------------------------- | --------------------------------------------------- | -------------------------------------------------------- | ---------------------- | ----------------------------- |
  | P1 Executive / VIP                    | Deal data, board communications, contacts, location | Competitors, commercial spyware customers, states        | T3 (T4 for some roles) | B, or C+B on a fleet          |
  | P2 Journalist / activist / high-risk  | Sources, unpublished material, contacts, location   | Commercial spyware customers, states, border agents      | T4                     | B                             |
  | P3 Security / IT staff                | Admin credentials, MFA tokens, internal access      | Criminal groups, access brokers, states via supply chain | T3                     | C (C+B for privileged admins) |
  | P4 Field / operational staff          | Operational data, location, organization access     | Thieves, local authorities, coercion                     | T2                     | C                             |
  | P5 Privacy-conscious individual       | Personal data, accounts, location history           | Thieves, data brokers, ad tracking                       | T1–T2                  | A                             |

- **2.4 Persona × deployment model → profile**

  | Persona | D1 Individually owned | D2 Organization-owned fleet | D3 BYOD with work profile         | D4 Minimal / comms-only |
  | ------- | --------------------- | --------------------------- | --------------------------------- | ----------------------- |
  | P1      | B                     | C+B                         | Not recommended → issue D2 device | B                       |
  | P2      | B                     | C+B (newsroom / NGO fleet)  | Not recommended → issue D2 device | B                       |
  | P3      | A                     | C (C+B if privileged admin) | C                                 | n/a                     |
  | P4      | A                     | C                           | C                                 | C (stripped-down)       |
  | P5      | A                     | n/a                         | A plus work profile               | A                       |

- **2.5 Threat tier coverage by profile** (what each profile is designed to resist)

  | Tier                               | A Baseline | B High-risk | C Managed fleet | C+B      |
  | ---------------------------------- | ---------- | ----------- | --------------- | -------- |
  | T1 Opportunistic theft / loss      | Yes        | Yes         | Yes             | Yes      |
  | T2 Commercial forensic extraction  | Yes        | Yes         | Partial¹        | Yes      |
  | T3 Commercial spyware (1-/0-click) | Partial²   | Yes         | Partial²        | Yes      |
  | T4 Nation-state                    | No         | Partial³    | No              | Partial³ |

  ¹ Fleet usability settings (longer auto-reboot, sandboxed Play for work apps)
  widen the after-first-unlock window.
  ² Exploit mitigations apply in every profile, but A and C keep more attack
  surface (Play services, more apps, more radios on).
  ³ No profile fully addresses T4: baseband, firmware and supply-chain attacks sit
  below the OS. B raises the cost; it does not remove the risk.

### 3. GrapheneOS Overview
- 3.1 Project background, governance, funding, team size; infrastructure hosting
  and legal jurisdiction, and any recent relocation (vendor and availability risk)
- 3.2 Design philosophy (security-first, no root, AOSP-based)
- 3.3 What it is not (not a "privacy ROM", no root, no LineageOS-style device breadth)
- 3.4 Release channels and versioning

### 4. Platform Foundations & Trust Model
- 4.1 Why Pixel only: hardware requirements GrapheneOS enforces
- 4.2 Verified boot with custom AVB keys, re-locked bootloader, rollback protection
- 4.3 Titan secure element: Weaver throttling, insider attack resistance,
  StrongBox; Titan M2 through Pixel 10a, Titan M3 on Pixel 11
- 4.4 Storage encryption: file-based plus metadata encryption, key derivation
- 4.5 Baseband/modem and peripheral isolation (IOMMU), proprietary firmware still trusted
- 4.6 Trust boundaries diagram: Google HW/FW → AOSP → GrapheneOS → apps → network/carrier
- 4.7 Motorola partnership (announced March 2026): Signature 27 as first non-Pixel
  device; Qualcomm MTE and secure element; Motorola engineers port, no funding;
  implications for single-vendor dependency on Google

### 5. Device Generation Analysis (Pixel 8 → Latest)

**5.1 Device matrix** († = confirm in Phase 1, task 1.2)

| Device                        | SoC              | Modem          | GPU                       | Secure element | Fingerprint     | UWB        | Released | Support end | GrapheneOS     | Notes                                                                 |
| ----------------------------- | ---------------- | -------------- | ------------------------- | -------------- | --------------- | ---------- | -------- | ----------- | -------------- | --------------------------------------------------------------------- |
| Pixel 8 / 8 Pro               | Tensor G3        | Exynos 5300    | Mali                      | Titan M2       | Optical         | 8 Pro only | Oct 2023 | Oct 2030    | Supported      | First gen with MTE; oldest in scope                                   |
| Pixel 8a                      | Tensor G3        | Exynos 5300    | Mali                      | Titan M2       | Optical         | No         | May 2024 | May 2031    | Supported      | Budget G3; same security baseline                                     |
| Pixel 9 / 9 Pro / 9 Pro XL    | Tensor G4        | Exynos 5400    | Mali                      | Titan M2       | Ultrasonic      | Pro only   | Aug 2024 | Aug 2031    | Supported      | Satellite SOS modem path                                              |
| Pixel 9 Pro Fold              | Tensor G4        | Exynos 5400    | Mali                      | Titan M2       | Side capacitive | Yes        | Sep 2024 | Aug 2031    | Supported      | Foldable; two displays                                                |
| Pixel 9a                      | Tensor G4        | Exynos 5300    | Mali                      | Titan M2       | Optical         | No         | Apr 2025 | Apr 2032    | Supported      | Older modem than the rest of the 9 line                               |
| Pixel 10 / 10 Pro / 10 Pro XL | Tensor G5 (TSMC) | Exynos 5400    | PowerVR DXT-48-1536       | Titan M2       | Ultrasonic      | Pro only†  | Aug 2025 | Aug 2032    | Supported      | New fab and GPU driver stack; first gen after device trees stopped    |
| Pixel 10 Pro Fold             | Tensor G5        | Exynos 5400    | PowerVR                   | Titan M2       | Side capacitive | Yes†       | Oct 2025 | Oct 2032    | Supported      | Foldable                                                              |
| Pixel 10a                     | Tensor G4        | Exynos 5400    | Mali                      | Titan M2†      | Optical†        | No†        | Mar 2026 | Mar 2033    | Supported      | Previous-gen SoC; gains satellite SOS via 5400 modem                  |
| Pixel 11 / 11 Pro / 11 Pro XL | Tensor G6        | MediaTek M90†  | PowerVR C-Series†         | Titan M3       | Ultrasonic      | †          | Aug 2026 | Aug 2033†   | **Not yet**    | New modem vendor, new secure element, new GPU gen; support pending Android 17 QPR2 in AOSP |
| Pixel 11 Pro Fold             | Tensor G6        | MediaTek M90†  | PowerVR C-Series†         | Titan M3†      | Side capacitive†| †          | 2026†    | †           | **Not yet**    | Foldable                                                              |

*Non-Pixel to track: Motorola Signature 27 (Snapdragon, MTE, 7-year support) — first GrapheneOS partner device; availability unconfirmed (§4.7).*

**5.2 Security-relevant differences**
- 5.2.1 MTE: availability and default enforcement per generation
- 5.2.2 GPU driver: Mali (G3/G4) has a long record of in-the-wild exploitation by
  commercial spyware; PowerVR (G5) is a new kernel attack surface with little
  public history. Known-exploited vs unknown, not "safe" vs "risky"
- 5.2.3 Modem: Exynos 5300 vs 5400 vs **MediaTek M90 (Pixel 11)** — first change of
  modem vendor; satellite messaging/SOS paths; known baseband CVEs for each vendor
- 5.2.4 Secure element: Titan M2 (Pixel 8–10a) vs **Titan M3 (Pixel 11)** — new
  firmware and Weaver/StrongBox implementation with little public research
- 5.2.5 Fingerprint sensor type: spoofing resistance and how it affects fingerprint + PIN unlock
- 5.2.6 Radios: UWB, Thread, satellite, NFC; extra attack surface on Pro models
- 5.2.7 Support window remaining (procurement lifetime value)
- 5.2.8 Foldables: extra display/hinge sensors, larger driver surface
- 5.2.9 Time from device launch to GrapheneOS support: Pixel 10 (disrupted by the
  late-2025 infrastructure move) and Pixel 11 (3+ months and counting, MTE gating)

**5.3 Device recommendation by profile**

### 6. Exploit Mitigations
- 6.1 hardened_malloc (guard regions, randomization, zero-on-free, quarantine)
- 6.2 Hardened libc / Bionic changes
- 6.3 Hardware memory tagging (MTE): OS-wide default, per-app opt-in, crash reporting
- 6.4 Exec-based app spawning instead of zygote forking (per-app ASLR)
- 6.5 Kernel and toolchain hardening (CFI, shadow call stack, reduced attack surface)
- 6.6 Vanadium browser and WebView: JIT off by default, site isolation, patch cadence
- 6.7 Per-app compatibility toggles and how they weaken protections
- 6.8 Coverage by device generation (links to §5)

### 7. Privacy, Network & App Model
- 7.1 Network permission (per app)
- 7.2 Sensors permission
- 7.3 Storage Scopes and Contact Scopes
- 7.4 Sandboxed Google Play: architecture, privileges, compatibility shim, eSIM handling
- 7.5 User profiles, Private Space, work profile isolation
- 7.6 Default outbound connections (connectivity checks, update server, SUPL/PSDS proxies, attestation)
- 7.7 Radio and network controls: LTE-only, 2G off, per-connection Wi-Fi MAC
  randomization, always-on VPN with lockdown, Private DNS
- 7.8 Carrier exposure: SIM PIN, eSIM provisioning, IMSI-catcher considerations
- 7.9 App sourcing supply chain: Play (sandboxed) vs Accrescent vs F-Droid vs
  Obtainium/direct; signing and update trust for each
- 7.10 Telemetry and metadata exposure to GrapheneOS infrastructure

### 8. Physical & Forensic Resistance
- 8.1 BFU vs AFU states and why they matter
- 8.2 Auto-reboot timer (18 h default; 10 min–72 h range)
- 8.3 USB-C port control while locked (default: charging-only when locked)
- 8.4 Duress PIN/password wipe
- 8.5 PIN scrambling, fingerprint + PIN two-factor unlock
- 8.6 Titan M2 brute-force throttling
- 8.7 Leaked forensic-vendor capability matrices: what they show and their limits
- 8.8 Coercion and border-crossing scenarios (by profile), including the risk
  that a GrapheneOS device itself attracts attention

### 9. Operations & Lifecycle
- 9.1 Update pipeline, OTA server, release channels, seamless (A/B) updates
- 9.2 Signing-key custody, build reproducibility, transparency
- 9.3 Patch timing vs Google's bulletin and source-release changes
- 9.4 Auditor app and hardware-based attestation (single device and fleet)
- 9.5 Installation and procurement supply chain (web installer, hardware sourcing;
  carrier-locked Pixels such as Verizon units cannot be unlocked to install)
- 9.6 Backup and recovery options and their security trade-offs
- 9.7 Detection & incident response: with no root and no mobile threat defence
  agent, how compromise would be detected; what Auditor does and does not prove;
  log access, MVT-style triage, and reflash-and-replace as the realistic response

### 10. Enterprise & Compatibility
- 10.1 Android Enterprise / work profile support; what works with MDM
- 10.2 No fleet console: options and compensating controls
- 10.3 Play Integrity API: banking and corporate apps; hardware attestation allowlisting
- 10.4 Android Auto, Wear OS, eSIM, RCS, payments (no Google Wallet NFC)
- 10.5 Usability vs security trade-offs by profile

### 11. Areas to Examine First (Ranked)

Rank is by **Risk** (likelihood × impact). **Verify effort** feeds Stage 2
costing only. Ratings below are working hypotheses, to be re-scored in Phase 3.

| #   | Area                                  | Why it raises eyebrows                                                                           | Risk | Verify effort | Devices           | Profiles | Proposed Stage 2 test                                  |
| --- | ------------------------------------- | ------------------------------------------------------------------------------------------------ | ---- | ------------- | ----------------- | -------- | ------------------------------------------------------ |
| 1   | Upstream dependency on Google         | Device trees no longer published; AOSP source only Q2/Q4; quarterly bulletins; closed firmware  | H    | M             | All; G5+ most     | A, B, C  | Patch-lag timeline analysis; upstream diff tracking    |
| 2   | Supply chain, governance & infrastructure | Small team, signing-key custody, bus factor, reproducible builds; hosting jurisdiction and relocation | H | M          | All               | B, C     | Build-reproducibility test; governance and hosting review |
| 3   | Baseband / cellular stack             | Largest closed surface left; satellite paths; IOMMU isolation; vendor switch to MediaTek on Pixel 11 | H | H           | All; Pixel 11 new | B        | Firmware RE scope (IDA); CVE history review            |
| 4   | GPU driver (Mali and PowerVR)         | Mali: known-exploited history on G3/G4. PowerVR on G5: new stack, little public research          | H    | H             | All; G5+ unknown  | B, C     | Mali CVE review; PowerVR attack-surface mapping; fuzzing scope |
| 5   | Pixel 11 new components        | Titan M3 and MediaTek M90 arrive together, plus a new PowerVR generation; GrapheneOS support pending | M | H | Pixel 11 | B | Readiness review once supported; SE and modem research scope |
| 6   | Detection & incident response         | No root, no MTD agent; compromise may go unseen; Auditor proves OS integrity only               | M    | M             | All               | B, C     | IR playbook dry run; log and triage options review     |
| 7   | Browser / WebView patch lag           | Vanadium vs upstream Chromium on in-the-wild 0-days                                              | M    | L             | All               | A, B     | Historical patch-latency study                         |
| 8   | Sandboxed Play shim                   | Compatibility code with an IPC surface; eSIM provisioning path                                   | M    | M             | All               | A, C     | Shim code review; IPC fuzzing                          |
| 9   | App sourcing supply chain             | App stores and direct installs are a larger real-world risk than the OS                          | M    | L             | All               | A, B, C  | Store trust-model review; recommended app list         |
| 10  | MTE / hardened_malloc opt-outs        | Per-app weakening; how fail-open behaves in practice                                             | M    | L             | All               | A, B     | Opt-out census of common apps                          |
| 11  | Forensic claims                       | BFU and auto-reboot hold up on paper; need validation against current tools                      | M    | H             | All               | A, B     | Lab extraction test per generation                     |
| 12  | Enterprise manageability              | No fleet console; MDM gaps; attestation at scale                                                 | M    | M             | All               | C        | MDM compatibility matrix                               |
| 13  | Default network behaviour             | Metadata exposure to GrapheneOS servers                                                          | L    | L             | All               | A, B     | Traffic capture and analysis                           |
| 14  | Biometric differences                 | Optical vs ultrasonic vs capacitive spoofing resistance                                          | L    | M             | Per device        | A, B     | Spoof testing                                          |

### 12. Reference Secure-Phone Configurations
- **12.1 Hardware selection**
  - Recommended device per profile
  - Procurement and supply-chain hygiene (unlocked, non-carrier units; trusted channel)
- **12.2 Installation and verification**
  - Web installer
  - Bootloader re-lock
  - Auditor pairing
- **12.3 Profile A — Baseline (P5; P3/P4 on their own devices)**
- **12.4 Profile B — High-risk (P1, P2)**
  - No Play
  - Strict USB mode
  - Short auto-reboot
  - Duress PIN
  - LTE-only
  - Always-on VPN with lockdown
- **12.5 Profile C — Managed fleet (P3, P4)**
  - Work profile
  - Attestation
  - Compensating controls
  - Incident response runbook
  - **C+B variant:** Profile B device settings on a fleet device, for P1/P2 and
    privileged P3 users (see §2.2)
- 12.6 App policy: no Play vs sandboxed Play in a separate profile; approved app sources (links to §7.9)
- 12.7 Hardening checklist (settings table, per profile)

### 13. Comparative Positioning
- 13.1 GrapheneOS vs stock Pixel (Android 16+)
- 13.2 GrapheneOS vs iOS with Lockdown Mode
- 13.3 GrapheneOS vs Samsung Knox / hardened Android Enterprise
- 13.4 Summary comparison table

### 14. Recommendations & Proposed Stage 2
- 14.1 Key findings
- 14.2 Stage 2 work packages (scope, effort from the §11 verify-effort column, tooling, devices needed)
- 14.3 Lab requirements (one device per SoC generation: G3, G4, G5 and newer)
- 14.4 Open questions for the client (from the assumption register)

### Appendices
- **A.** Assumption register (ID · assumption · impact if wrong · how to confirm).
  Seeded from the Phase 1 fact check:

  | ID  | Assumption | Impact if wrong | How to confirm |
  | --- | ---------- | --------------- | -------------- |
  | A01 | The client wants a phone they can deploy now, so the reference device is a supported Pixel 10-series model, not Pixel 11 | Recommendation changes to "wait for Pixel 11" | Ask client; re-check GrapheneOS FAQ before delivery |
  | A02 | Pixel 11 uses a MediaTek M90 modem and PowerVR C-Series GPU (press reports only) | §5.2 and §11 #3–#5 change | Google spec sheet or teardown |
  | A03 | Pixel 11 GrapheneOS support follows Android 17 QPR2 in AOSP, within weeks | Pixel 11 stays out of scope for longer | GrapheneOS releases page / announcements |
  | A04 | Pixel 10a has an optical fingerprint sensor and Titan M2 (one review) | §5.2.5 biometric comparison | Google spec sheet or teardown |
  | A05 | Infrastructure move off OVH (Nov 2025) has completed | §3.1 and §11 #2 risk rating | GrapheneOS announcements; DNS/IP ownership lookup |
  | A06 | Team size is about 10 full-time developers (self-reported, figures vary) | Bus-factor rating in §11 #2 | Public statements; commit-author analysis |
  | A07 | Motorola Signature 27 will ship with GrapheneOS support in 2026–2027 | §4.7 and non-Pixel recommendation | Motorola / GrapheneOS announcements |
  | A08 | Pixel monthly patches continue despite quarterly AOSP bulletins, so GrapheneOS patch level stays current | §9.3 patch-lag analysis | Compare GrapheneOS patch levels against Pixel bulletins over 6 months |
  | A09 | The client is not restricted to US/EU-sourced hardware or to a specific carrier | §12.1 device choice | Ask client |
  | A10 | Highest credible tier per persona is as in §2.3 (e.g. P1 at T3, P2 at T4) | Profile assignment and §11 priorities shift | Ask client which personas they actually have |
  | A11 | Organization-owned devices can be issued to high-risk staff instead of BYOD | C+B and the BYOD "not recommended" guidance may not be acceptable | Ask client about device ownership policy |
  | A12 | The client has no hard requirement for certified products (Common Criteria, FIPS 140, government accreditation) | GrapheneOS may be ruled out for regulated uses regardless of technical strength | Ask client about compliance obligations |
  | A13 | Official GrapheneOS builds are reproducible from source (not stated on the features page) | §9.2 and §11 #2 rating; build-verification Stage 2 work package | GrapheneOS build docs; attempt a reproducible build in Stage 2 |
  | A14 | Device-owner (fully managed) MDM provisioning works on GrapheneOS | Profile C design changes to work-profile-only | Test with the client's MDM in Stage 2 |
- **B.** Persona, threat-tier and deployment-model definitions
  - Personas: P1 Executive/VIP · P2 Journalist/activist/high-risk individual ·
    P3 Security/IT staff · P4 Field/operational staff · P5 Privacy-conscious user
  - Threat tiers: T1 Opportunistic theft/loss · T2 Commercial forensic extraction ·
    T3 Commercial spyware (1-click/0-click) · T4 Nation-state (0-click chains,
    baseband, supply chain)
  - Deployment models: individually owned · organization-owned fleet · BYOD with
    work profile · minimal/air-gapped communications-only device
- **C.** Glossary (AVB, BFU/AFU, MTE, Weaver, StrongBox, IOMMU, etc.)
- **D.** Device specification detail
- **E.** Hardening settings reference
- **F.** References and sources (with Documented / Observed / Assumed tags)
