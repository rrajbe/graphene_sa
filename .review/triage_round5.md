# Round 5 change list (internal; not part of the deliverable)

Applies to `grapheneos_assessment.md`. All earlier rules still apply:
`.review/style_round3.md` (abbreviations expanded in headings/table headers and
at first use per top-level section; no single-line lists of 3+ items — in cells
use `• a<br>• b`; tags as words) and `.review/style_round4_tables.md` (tables
where 3+ items share structure; lead-in sentence per table; ≤6 columns except
§5.1). Edit ONLY your assigned sections. Commit with a message ending:

    Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>

Line numbers below refer to commit a336163 and may drift; search by quote.

## Global decisions (all agents)

- G1 **Tag every row and finding.** Replace "—" in Confidence columns with the
  correct tag. Delete every sentence that explains missing tags ("the original
  point carried no tag", "the source text gave no tag", "a dash means…").
- G2 **Absence claims** are always "[Assessed] (absence — searched …)", never
  "[Documented] (absence)".
- G3 **MTE app coverage wording:** "on by default for the base OS and
  known-compatible user apps (optional for other apps)". Never "most apps".
- G4 **US v. Tunick wording (use everywhere it appears):** "US v. Tunick
  (Northern District of Georgia): a traveller was charged under 18 U.S.C.
  §2232(a) for allegedly wiping a phone — reportedly a Pixel running
  GrapheneOS — around a US Customs and Border Protection search in January
  2025; the wipe method is not confirmed in the public record; the case is
  pending. [Secondary]" Short form: "a phone wipe around a US border search has
  led to a pending prosecution (US v. Tunick) [Secondary]".
- G5 **UK and France wording:** UK — refusing to give a password is an offence
  under a Schedule 7 border examination or after a RIPA section 49 notice;
  France — refusal "can be" an offence under article 434-15-2 of the Code
  pénal. Never "is itself an offence in the UK and France".
- G6 **Compelled or stolen-key updates:** per-device (serial-locked) update
  packages are rejected, but a holder of the signing key — or someone
  compelling the project — could serve a validly signed malicious build only to
  chosen IP addresses. Detection depends on the target or a third party
  comparing the installed build with a reproducible build. [Assessed] Never say
  a compelled update "would have to ship to every device".
- G7 **BlastDoor comparison:** "No operating-system-provided equivalent of
  Apple's BlastDoor exists on AOSP, Pixel or GrapheneOS for third-party
  messengers. Samsung Message Guard (Galaxy S23 and later) sandboxes image
  parsing for Samsung Messages and Google Messages, but not WhatsApp or Signal.
  [Assessed]" Never "no Android equivalent".
- G8 **Device advice wording:**
  - Pixel 10 (non-Pro): "only where performance requires it; brings the newer
    PowerVR GPU and video-processing driver, which have less public study and
    one known zero-click chain (§5.2.1)".
  - Pro models: "not preferred for high-risk users (extra radios such as UWB;
    these can be disabled, so this is a preference, not a defect)".
  - Foldables: "not preferred (more hardware and drivers, no security gain)".
  - Pixel 8: "fine to keep until about 2030; do not buy new (shorter remaining
    support)".
  - Pixel 10a reasoning row: "Same secure element and modem as the Pixel 10
    (Titan M2, Exynos 5400); the system on a chip differs (Tensor G4 versus G5)".
  - Mali reconciliation (add under device advice in §0 and §5.3): "The Pixel
    10a's Mali GPU driver is the most-exploited GPU driver on Android. It is
    still preferred to the Pixel 10's PowerVR GPU and new video driver: Mali is
    heavily patched and hardened, while PowerVR is largely unstudied and the
    Pixel 10's video driver was used in a 2026 zero-click chain. Work package
    WP7 tests this choice. [Assessed]"
- G9 **Leaked forensic data scope:** always add "no equivalent data exists for
  the recommended Pixel 10a; WP12 tests it" where the Pixel 6–9 leak is used to
  support the recommendation.
- G10 **"No public in-the-wild exploitation of a current GrapheneOS release"**
  must be followed by: "This is weak evidence: GrapheneOS devices were exposed
  to the exploited modem bug CVE-2026-58704 until patched, and limited detection
  (§9.7) and a small user base make exploitation less likely to be seen."
- G11 **Patch-lag September row:** "About 2 days for the modem firmware
  (assumed to carry the fix); 10 days for all firmware; 17 days until the
  reported patch level changed — which is what Auditor and MDM compliance checks
  see."
- G12 **Vague wording fixes:** "Cellebrite may lose full extraction even on
  unlocked GrapheneOS devices" → "The matrix reportedly shows only partial
  extraction for unlocked GrapheneOS devices [Secondary]"; "In some
  jurisdictions the warning may itself attract attention" → "Border officers
  may notice the non-stock boot warning [Assessed]; no reported case found";
  "A short timer reduces the window either way" → "Whatever the enforcement
  mechanism, a shorter timer shortens the AFU exposure window [Assessed]".
- G13 **Certification:** wherever GrapheneOS's lack of certification is stated
  in a decision context, add "Stock Pixel 9 and 10 on Android 16 hold NIAP
  Common Criteria certification; GrapheneOS does not inherit it (§13.1)".

## Agent 1 — title block, §0–§3

1.1 §0: add a first block **"What GrapheneOS is"**: "A free, open-source,
    security-hardened version of Android built by a small Canadian non-profit.
    It runs on Google Pixel phones (Pixel 8 to 10a in scope; Pixel 11 not yet
    supported). It adds exploit mitigations, physical and forensic protections
    and privacy controls to stock Android, and ships no Google services by
    default. There is no vendor support, fleet console or certification (§3)."
    (Split into lines per R1 if it lists 3+ items.)
1.2 §0: add **"Reference secure phone (§12)"** after the device recommendation:
    Pixel 10a, installed and verified by the client (§12.2), with one of three
    configurations — A Baseline, B High-risk, C Managed fleet — each with a
    settings checklist that marks what the organisation can and cannot enforce
    or verify (§12.7). Define profiles A/B/C in one line here.
1.3 §0 verdict table: row 1 → "Among the most hardened phone platforms
    available, alongside iPhone 17 with Lockdown Mode [Assessed]"; conditions →
    "Desk assessment only; no hands-on testing in Stage 1". Row 2 → "Good fit
    against commercial spyware and forensic extraction: raises attacker cost
    substantially but cannot guarantee defeat (§2.5)". Add under the table: "All
    findings come from public sources; Stage 2 validates them."
1.4 §0 strengths: forensic row per G9; MTE wording per G3.
1.5 §0 top areas: rank 1 "Every fix and every new device depends on Google's
    release choices. Google has cut published source and bulletins, and Pixel 11
    support is stalled on Google now. This is an adoption and continuity risk,
    not an exploit path." Rank 6 "No on-device monitoring agent or intrusion
    log; Auditor proves only that the OS is unmodified, so an implant is
    unlikely to be detected." Add: "For high-risk users, start with ranks 2, 3
    and 5 (§11.3)."
1.6 §0 decision constraints: certification row per G13; legal row "…live
    examples in the US, UK and France (§8.8, §10.6)"; alternatives row "…iOS
    with Lockdown Mode, and certified purpose-built secure phones (§13.5)"; add
    row **"Reversible"**: "Devices can return to stock Android, typically in
    under an hour per device (§12.8) [Assessed]".
1.7 §0 device advice per G8 incl. Mali reconciliation.
1.8 §0 next step: "A first Stage 2 phase ('Tier 1') of about 20–34 analyst
    days, plus client legal time; less if either the high-risk or the fleet
    configuration is not needed (§14.2)." Replace "for Profile B" with "for
    high-risk users".
1.9 §1.1: add "a reference secure-phone build for each profile (§12)".
1.10 §3.1 legal compulsion bullet per G6.

## Agent 2 — §4–§6

2.1 §5.3 per G8 (Pixel 10a row, Pixel 10 alternative, avoid list, Mali
    reconciliation).
2.2 MTE wording per G3 wherever it appears in range.
2.3 Tags per G1/G2 across range.

## Agent 3 — §7–§10, §12, §13

3.1 §7.11 BlastDoor per G7.
3.2 §8.7 vague wording per G12; leak scope per G9 where used.
3.3 §8.8 boot warning per G12; §8.2 timer wording per G12.
3.4 §8.8/§10.6 Tunick per G4; UK/France per G5 (incl. any "is itself an
    offence" sentence).
3.5 §8.9 absence line per G10.
3.6 §9.1 table row on serial-locked packages: "rejects device-specific
    (serial-locked) packages; does not prevent selective delivery of a signed
    build". §9.2: add selective delivery to the compromise table per G6.
3.7 §9.3 September row per G11.
3.8 §12.5 runbook: "isolate the device (airplane mode; do not reboot) → capture
    evidence (screenshots, Mobile Verification Toolkit and adb output, MTE crash
    reports) → revoke credentials → reflash and re-enrol, or replace (§9.7)".
3.9 **New §12.8 "Lifecycle and exit"** table with rows: onboarding and training;
    lost or stolen device; after a duress wipe; end of support; offboarding and
    disposal (wipe, remove from attestation.app, dispose); exit to stock Pixel
    with Advanced Protection (flash Google factory image, re-lock bootloader;
    typically under an hour per device [Assessed]) with triggers: signing-key
    compromise, project inactive for more than 60 days, patch lag over the WP1
    threshold.
3.10 §13.1/§13.2 MTE wording per G3; §13.2 BlastDoor per G7.
3.11 §13.3 Knox: add a Confidence column; reword "Much stronger exploit
    mitigation" → "Stronger user-space exploit mitigation (hardened_malloc, MTE
    by default for compatible apps, exec spawning) [Assessed]"; "Faster and more
    consistent patching" → "Patches as fast as Pixel on supported devices;
    Samsung flagships also patch monthly, mid-range models less often
    [Assessed]"; add rows favouring Knox: Knox Vault secure element and
    Real-time Kernel Protection hypervisor [Documented if verified, else
    Assessed]; Message Guard (G7). Heading: drop "Hardened Android Enterprise"
    unless you add a row covering it.
3.12 **New §13.5 "Certified purpose-built secure phones"**: short table
    comparing the category (government-accredited hardened Android or custom
    secure handsets) with GrapheneOS on certification, management, cost and
    hardening. Do not name or characterise specific vendors unless you verify a
    public source; tag [Assessed].
3.13 Tags per G1/G2 across range.

## Agent 4 — §11, §14, Appendices

4.1 §11 ratings table: replace "Number" + "Area" with one "Area" column
    ("1. Upstream dependency on Google") and add a **"Risk event"** column
    (what is likely to happen), e.g. area 1 "A fix or device support is
    delayed long enough to leave devices exposed or unsupported"; area 4
    "Signing-key compromise or project discontinuity"; area 6 "A compromise
    goes undetected". Keep ≤6 columns.
4.2 Move "Evidence by area" (the 17 per-area tables) to a **new Appendix G
    "Evidence by area"**, and leave one line in §11.2 pointing to it. Tag every
    evidence row (G1).
4.3 Shorten "Rationale for ranking" to about five rows (one per band plus key
    exceptions).
4.4 §11 area 10 and §14.1 finding 8 per G4/G5. §11 area 4 evidence per G6.
4.5 §14.1 key findings: tag every row (findings 1, 6, 7, 9 → [Assessed];
    finding 8 → [Secondary]/[Documented]); MTE per G3; leak scope per G9.
4.6 §14.2: add selective-delivery check to WP2 scope (G6).
4.7 Appendix F: add a source for Samsung Message Guard if Agent 3 cites one.

## Additions from the whole-document consistency audit

### Global (all agents)
- G14 **Area names**: use the §11.2 names everywhere (in tables, §0, WP
  descriptions, cross-references): 1 Upstream dependency on Google; 2 GPU and
  accelerator drivers; 3 Baseband and IP Multimedia Subsystem (IMS); 4 Supply
  chain, governance and vulnerability handling; 5 Messaging and media parser
  zero-click surface; 6 Detection and incident response; 7 Enterprise
  manageability; 8 Browser and WebView; 9 App sourcing supply chain; 10 Legal and
  regulatory fit; 11 Pixel 11 new components; 12 Sandboxed Play compatibility
  layer; 13 Forensic claims; 14 Proximity radio firmware; 15 MTE and
  hardened_malloc opt-outs; 16 Default network and attestation data;
  17 Biometric differences. (Agent 4: check the exact §11.2 strings and use
  them; others use these.)
- G15 **Confidence column header** is "Confidence" (never "Tag"). Values always
  in brackets: "[Documented]", "[Assessed]", "[Secondary]".
- G16 **Every table has a one-sentence lead-in.**
- G17 **Spelling**: British throughout ("organisation", "randomisation",
  "defence", "behaviour", "e-mail"); "zero-click", "one-click", "two-factor"
  (never "0-click", "1-click", "2-factor").
- G18 **Expansion form**: "Universal Serial Bus Type-C (USB-C)", never the
  reverse; "IP Multimedia Subsystem (IMS)" (not "Internet Protocol Multimedia
  Subsystem"); "Digital Forensic Research Workshop (DFRWS)".
- G19 **QPR2 wording**: current release "ships Android 17 QPR2 firmware and
  kernels with the 2026-11-05 patch level; the QPR2 platform source is not yet
  in AOSP (§5.2.9)". Never "QPR2 base".
- G20 **Auditor wording**: "Auditor shows some of them (auto-reboot timeout,
  USB-C mode, adb and OEM unlocking; §9.4)" — never "only".

### Agent 1
- §0 next step: "MDM fit (for Profile C)" and "duress-PIN legal review (for
  high-risk users)".
- §0 area names per G14; §3.4 QPR2 per G19.
- Tables without lead-ins in range (approx. L154, 241, 251, 261, 331, 414, 432).

### Agent 2
- §4.3 Weaver schedule: VERIFY against https://grapheneos.org/faq (encryption
  section) — 4 free attempts + 15 listed delays = 19, but text says 20 in total.
  Correct whichever is wrong. Convert the 15-line schedule list into a table
  "Failed attempt number | Delay before the next attempt".
- L1034 "every supported device (Pixel 8 to 10a)" → "every in-scope supported
  device (Pixel 8 to 10a)".
- L548 dash-explanation sentence: delete (G1).
- Lead-ins at approx. L1015.

### Agent 3
- §8.7: delete the two detail bullets that repeat table rows ("Covers Pixel 6–9
  only", "Locked GrapheneOS Pixels: no access…").
- §9.4 hosting row → "hosted by GrapheneOS (location: §3.1)".
- §10.2 "Shown by Auditor" table duplicates §9.4: keep only the "not shown"
  rows plus "see §9.4".
- §12.5 enforcement limit → "Device-wide settings are user-set; see §10.2 and
  the last column of §12.7." Runbook per item 3.8 (evidence before reflash).
- §13.1 Advanced Protection list: merge sideloading, Play Protect and the
  JavaScript optimiser into the table as rows; cut the list to the lead-in.
- §13.4 L2362 cell → "Medium:<br>• 2G blocked<br>• sideloading blocked<br>•
  insecure Wi-Fi auto-connect off".
- Dash-explanation sentences at approx. L1586, L1699, L2321: delete (G1).
- "[Documented] (absence)" at L1446, L1522, L1646 and bare "(absence)" at
  L1392, L1580 → G2 form with what was searched.
- Lead-ins at approx. L1151, 1326, 1358, 1491, 1711, 1722, 2186, 2358.

### Agent 4
- A08 "over 6 months" → "over 12 months".
- A15: "kernel address space layout randomisation (KASLR)".
- A13: "work package 2 (WP2)".
- Delete "They keep their IDs A03 and A06 so references stay valid."
- §11.2: drop evidence tables for areas 6, 11 and 12 that only restate the
  summary (they move to Appendix G anyway — just point to the summary row).
- Confidence values in brackets in §11 evidence and §14.1 tables (G15).
- Glossary: add HAL (hardware abstraction layer), IPv6 (Internet Protocol
  version 6), W^X (write-xor-execute), ioctl (input–output control), N.D. Ga.
  (US District Court for the Northern District of Georgia), 9th Cir. (US Court
  of Appeals for the Ninth Circuit), D.C. Cir. (US Court of Appeals for the
  District of Columbia Circuit), U.S.C. (United States Code); DFRWS per G18.
- "## Appendices" empty heading: change to "# Appendices" or delete.
- Appendix F: remove blank lines inside lists; one blank line after every bold
  group heading. Describe the 12 Nov 2026 Privacy Guides source accurately
  ("GrapheneOS says Pixel 11 MTE works with its QPR2 port; support still waits
  for QPR2 source in AOSP").
- Lead-ins at approx. L2489, 2581, 2590.

## Additions from correctness review §11–end

### Global
- G21 **WhatsApp + Apple (CVE-2025-55177 + CVE-2025-43300, Aug 2025) was an
  iOS/macOS chain**, not Android. Wherever 2025 messaging cases are called
  "Android", say: "two on Android (LANDFALL, Paragon Graphite) and one on iOS
  and macOS (WhatsApp and Apple, August 2025), which shows the same
  messenger-plus-OS-parser pattern". Applies to §7.11 ("Recent Android cases"),
  §11 area 5 evidence, §14.1 finding 5.
- G22 **PUK** = "PIN Unblocking Key" (3GPP). Body: "SIM PIN Unblocking Key (PUK)".
- G23 **MIE**: "on A19-class iPhones (iPhone 17 models and iPhone Air) and later".

### Agent 3
- §7.11 per G21.
- §12.4: split "Network and Sensors permissions for new apps | Off by default"
  into "Network permission for new apps | Off at install" and "Sensors
  permission for new apps | Off by default".
- §12.7 Duress PIN C column: "Per policy (on for C+B only where the WP6 legal
  review allows it)".
- §12.5 enforcement list: add "VoLTE and Wi-Fi calling" to the not-verifiable
  items.
- §13.2 Lockdown Mode bullets: "• blocks most message attachment types other
  than certain images, video and audio<br>• blocks certain complex web
  technologies, including just-in-time (JIT) JavaScript compilation<br>•
  requires the device to be unlocked to connect to an accessory or computer"
  [Documented] (Apple support page; Apple newsroom, July 2022).
- §13.1 Wi-Fi: "turns off auto-connect to insecure Wi-Fi networks (Open, WEP
  and OWE); auto-connect can be turned back on for individual networks".
- §13.2/§13.4 MIE per G23 ("very high on iPhone 17, iPhone Air and later").

### Agent 4
- §11 area 5 evidence and §14.1 finding 5 per G21.
- §11.3 area 9 C+B → "High (MDM approved-app list covers the work profile
  only)".
- §11.3 Profile B "Then" cell → "Then areas 8, 9 and 13 (also High for Profile
  B). Settle area 10 (legal and regulatory fit) by legal review in parallel.
  Areas 1 and 4 come after the technical areas because Tier 1 (WP1, WP2) covers
  them for every profile."
- Scope table row 15 name: "Memory Tagging Extension (MTE) and hardened_malloc
  opt-outs".
- Glossary: DFRWS "Digital Forensic Research Workshop"; PUK per G22; MIE per
  G23; add RCE (remote code execution) and SELinux (Security-Enhanced Linux).
- A15 per earlier note (KASLR).
- Appendix F: add "Apple Newsroom, Apple expands industry-leading commitment to
  protect users from highly targeted mercenary spyware (Lockdown Mode), July
  2022: https://www.apple.com/newsroom/2022/07/apple-expands-commitment-to-protect-users-from-mercenary-spyware/".

## Additions from correctness review §7–§10

### Global
- G4 (amended): append to the Tunick long form "a suppression motion was
  pending at last report (August 2026), with no ruling found by November 2026".
- G24 **Paragon Graphite**: loaded inside WhatsApp, **then escaped the Android
  sandbox and infected other apps on the device** (Citizen Lab, March 2025).
  Never present it as an implant confined to one app.
- G25 **CVE-2026-58704**: "elevation of privilege in the modem; attack vector
  not published (likely needs a network position [Secondary]); not a forensic
  bug". Never "remote" as [Documented].
- G26 **Update server sees**: IP address, device model, release channel and
  installed version [Documented] (FAQ).

### Agent 3
- §7.11 Graphite row per G24; WhatsApp CVE-2025-55177 entry point → "WhatsApp
  linked-device synchronisation messages (iOS and macOS) and an Apple ImageIO
  parser"; table lead-in → "Recent messaging cases (Android, plus one iOS chain
  for comparison)"; LANDFALL → "Malformed Digital Negative (DNG) image, likely
  sent through WhatsApp (inferred from file names)".
- §7.6 update-server row and §7.10 per G26; Private DNS check row → "Private
  DNS (DNS-over-TLS) check, only when Private DNS is on | GrapheneOS | Google
  (follows the connectivity-check setting)".
- §9.1: replace "which the project strongly advises against" with "The usage
  guide documents only disabling the System Updater app, and warns that updates
  stop until it is re-enabled."
- §9.3 September row per G11 (17 days to listed patch level, release
  2026100200).
- §9.4: "First and last verification time" → "Recorded by the verifier" (not
  hardware-verified).
- §9.2: Pöll and Roland → "Pöll and Roland's analysis of AOSP build
  reproducibility (ACM WiSec 2022) gives a method for the test"; platform-key
  leak tag → "[Secondary] (Rapid7, reporting Google's Android Partner
  Vulnerability Initiative disclosure)".
- §8.2: "Classen 2024 reverse engineering of iOS 18.1".
- §8.1: FAU paper → "It showed that 7 of 13 tested phones used a key derivation
  that let the file-based-encryption master key be recovered from a RAM image."
- §8.4: split tag — "The wipe is enforced by the OS, not the secure element.
  [Documented] The duress PIN therefore does not help against an attacker who
  already has code execution on the device. [Assessed]"
- §8.9 CVE-2026-58704 row per G25.
- §9.7 Graphite detail per G24: "Paragon Graphite loaded inside WhatsApp and
  then escaped the Android sandbox into other apps (§7.11). Code running inside
  a messenger needs no OS exploit to read that app's data; OS hardening limits
  the sandbox escape that follows."
- §10.6 RIPA: "up to 2 years (5 years in national-security or child-indecency
  cases)"; Tunick per G4.

### Agent 2
- §4.5 CVE-2026-58704 wording per G25 if it says "remote".

### Agent 4
- §11 area 5 evidence: Graphite per G24. §11 area 3 per G25.

## Additions from correctness review §4–§6

### Global
- G27 **KASLR (important correction)**: GrapheneOS restored linear-map
  randomisation after Project Zero's finding — release 2025091000 ("fix linear
  region randomization by dropping memory hotplug support") for 6.1/6.6/6.12
  kernels and release 2026102100 ("add back linear map randomization
  downstream") for 6.18 [Documented] (GrapheneOS changelog,
  https://grapheneos.org/releases). The Pixel bootloader's fixed physical load
  address is outside GrapheneOS's control; how much KASLR entropy remains is a
  Stage 2 question [Assessed]. Remove every statement that GrapheneOS's KASLR
  position is "undocumented" or that "Pixel KASLR is ineffective" applies to
  GrapheneOS; keep "stock Pixel KASLR was effectively absent (Project Zero,
  Nov 2025)". A15 becomes: "GrapheneOS's restored linear-map randomisation
  gives meaningful kernel address space layout randomisation (KASLR) despite the
  fixed physical load address".
- G28 **CVE-2025-6558** is a Chrome ANGLE/GPU sandbox escape exploited in the
  wild (2025) [Documented] (NVD) — NOT a Mali bug. Remove it from Mali lists;
  where useful, cite it under browser/WebView as a GPU-process sandbox escape.
- G29 **Pixel 11 dates**: announced with orders opening 2026-08-12
  [Documented] (Google blog); retail availability reported as 2026-08-20 and
  the Pro Fold ship date not confirmed by Google [Secondary]. Mark Pro Fold
  "August 2026†".
- G30 **Pixel 11 MTE timeline**: 2026-09-01 GrapheneOS found Tensor G6 retains
  "at least bare minimum support for MTE at a hardware level"; 2026-11-11 it
  said QPR2 adds MTE support and its QPR2 port works on Pixel 11; performance
  and coverage still being evaluated [Documented] (project statements). QPR2
  source wait: cite the GrapheneOS X post
  (https://x.com/GrapheneOS/status/2120727750235574616) for "Google has not
  pushed the QPR2 sources as promised" [Documented] (project statement).
- G31 **Release 2026111800** moved the supported Pixels (6 to 10a) to QPR2
  firmware, drivers, HALs and kernels — groundwork for, not, a Pixel 11 build.

### Agent 2
- §6.5 KASLR row per G27; Dirty Pagetable → "(N. Wu, 2023)".
- §5.2.1 Mali list: remove CVE-2025-6558 (G28); add source "GTIG, 'Sanctioned
  but Still Spying' (Intellexa), December 2025" for CVE-2024-4610.
- §5.2.1 Dolby: "the Dolby fix reached Pixels 82 days after public disclosure
  (about 6 months after the report to Dolby)".
- §5.1 Pixel 11 dates per G29; §5.2.9 per G30/G31.
- §4.1 IOMMU note → "The published list requires isolated radios, GPU and other
  components; the FAQ explains separately that baseband memory access is
  partitioned by the IOMMU. [Documented]"
- §6.6 WebView → "WebView lacks the browser's strict site isolation, so all web
  content loaded by one app shares that app's renderer sandbox"; add
  CVE-2025-6558 here as a Chrome GPU-process sandbox escape if useful (G28).
- §6.1/§6.3 MTE size → "slab allocations (128 KiB and below)" [Documented];
  Synacktiv: "only slab allocations (up to about 128 KiB) are tagged; larger
  allocations get guard pages only".
- §4.5 bulletin rows: "CVE-2026-56967 | Modem remote code execution
  (Critical)"; "CVE-2026-55306 | Modem denial of service (Critical)";
  "CVE-2026-58731 | PowerVR GPU information disclosure (High)".
- §4.5 suppliers Confidence → "[Documented]; MediaTek on Pixel 11 [Secondary]
  (assumption A02)".

### Agent 4
- A15 per G27; any §11 area 2/§14 text claiming GrapheneOS KASLR is
  undocumented or ineffective → per G27. CVE-2025-6558 per G28 in §11 area 2
  evidence. Appendix F: Dirty Pagetable author "Nicolas Wu".

## Additions from correctness review §0–§3

### Global
- G19 (amended): "It is built on the Android 17 platform source (AOSP
  CP2A.260605.016). Pixel firmware, drivers, HALs and kernels are updated to
  Android 17 QPR2, with the 2026-11-05 patch level (§9.3). The QPR2 platform
  source has not yet been published to AOSP (§5.2.9)." [Documented]
- G32 **Infrastructure (current, per https://grapheneos.org/articles/grapheneos-servers,
  modified 2026-10-21)** [Documented]: update mirrors on dedicated servers,
  several sponsored, in Dallas, Frankfurt, Amsterdam, London, Los Angeles, Miami
  and Toronto; DNS anycast ns1 on Vultr, ns2 on Misaka.io, DataPacket and Xenyth;
  e-mail on Xenyth (Toronto); forum, Matrix and Mastodon on netcup (Manassas,
  US); attestation service on netcup (Nuremberg, Germany). No OVH servers
  listed; the move off OVH appears complete; long-term Toronto colocation only
  partly in place [Assessed] (assumption A05 — update A05 accordingly). Building
  and signing on "hardened local machines" under the project's physical control
  [Documented]; their location and jurisdiction are not published [Assessed].
  Remove any wording that the signing keys "sit under Canadian jurisdiction"
  as a [Documented] fact (the legal entity is Canadian).
- G33 **Audit**: "no published independent audit report; the FAQ describes
  continuous external review by researchers and organisations, for example
  ANSSI" — never simply "no audit".
- G34 **Motorola**: March 2026 partnership [Documented] (Motorola press
  release, MWC 2026). Signature 27 retail: Motorola's US page reportedly
  indicates November 2026 [Secondary]; GrapheneOS has indicated 2027 for
  Motorola devices [Secondary] (assumption A07).
- G35 **Update verification points**: System Updater (over the air), recovery
  (sideloaded updates), verified boot — not update_engine.
- G36 **Device advice (§0 must match §5.3)**: "Pixel 8 series — fine to keep
  until about 2030; do not buy new"; "Pixel 11 — avoid until supported and
  settled (§5.2.9)".

### Agent 1
- §3.4 per G19; §3.1 infrastructure rows per G32 (replace the four rows); legal
  compulsion per G6 + G32 ("The legal entity is Canadian. The project says it
  builds and signs on local machines under its physical control, but does not
  publish where they are or under which jurisdiction (§9.2).").
- §3.1 audit bullet per G33; funding → "Funding is donations (bank transfer,
  PayPal, GitHub Sponsors, Interac and cryptocurrency); some servers are
  sponsored in kind. The FAQ states the project is 'entirely funded by
  donations' and will remain a non-profit." [Documented]
- §3.1 update verification per G35.
- §3.1 Motorola rows per G34; §1.2 Motorola status per G34.
- §3.4 channels: Legacy extended support cell → "• Stopgap releases for
  end-of-life devices (currently Pixel 6 and 6 Pro)<br>• patch level frozen at
  2026-11-01<br>• the project recommends ending use of these devices"; add row
  "Security preview | Opt-in releases carrying early AOSP patches ahead of the
  bulletins (for example 2026111801) | [Documented]".
- Absence tags in §3.1/§3.3 per G2.
- §1.4 GrapheneOS sources row → "• the grapheneos.org site (FAQ, features,
  usage guide, releases, history, build guide)<br>• developer posts on its
  forum, X, Mastodon or Bluesky (marked 'project statement' where useful)".
- §0 area names per G14 and area 4 reason "6–10 full-time developers; no
  published key custody, succession plan or disclosure policy"; device advice
  per G36; Tier 1 list "for Profile C, MDM fit and an attestation data review";
  FIPS → "Federal Information Processing Standards (FIPS) 140"; §3.3 "(§13.1)".
- §0 verdict conditions per item 1.3 (desk-only) — do not keep "None stated".
- §2.1 Profile C threats → "• Loss and theft (T1 opportunistic theft or
  loss)<br>• commercial forensics (T2 commercial forensic extraction)<br>• also
  coercion and credential theft".
- §2.4 P5/D3 → "C (work profile only; A settings on the personal side)".

### Agent 2
- §4.7 Motorola per G34.

### Agent 4
- A05 per G32; A07 per G34.
- Appendix F: add https://grapheneos.org/articles/grapheneos-servers and the
  Motorola MWC 2026 press release (motorolanews.com) if a URL is found.
