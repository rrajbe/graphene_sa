# Round 2 change list (internal; not part of the deliverable)

Applies to `grapheneos_assessment.md`. Read `.review/fix_brief.md` first for
style and the earlier decisions (still valid unless changed below). Edit ONLY
your assigned sections. Commit on your branch with a message ending:

    Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>

## 0. Global rules for this round (all agents)

**G1 Tag definitions (replace §1.4 definitions; apply everywhere in your range):**
- **[D] Primary** — first-party statement by the vendor or project concerned
  (GrapheneOS incl. developer posts on its forum/X/Mastodon; Google incl.
  bulletins, store spec pages, security blogs, Project Zero, GTIG; Arm;
  Imagination; MediaTek; Apple; Samsung; Motorola), CISA KEV, NVD, or the
  original research publication (peer-reviewed paper, conference talk, NGO
  technical report such as Amnesty Security Lab / Citizen Lab).
- **[S] Secondary** — press or third-party coverage only.
- **[O] Observed** — first-hand testing (none in Stage 1).
- **[A] Assessed** — analyst judgement or inference. Assumptions that could
  change a conclusion are also listed in Appendix A and cited by ID, written
  "[A] (A05)", never "[A05]" alone.
- Absence claims: always "[A] (absence — searched <what>, 2026-11)".
- Assessment notes are [A] unless tagged otherwise (say so once in §1.4).
- Delete the hard-coded tag count sentence in §1.4 entirely.

**G2 Canonical locations — state the full point ONCE there; elsewhere one
clause + "(§x.y)":**
- Cellebrite Oct 2025 leak → §8.7
- Pixel 11 status / QPR2 source wait / MTE "bare minimum" → §5.2.9
- Device recommendation → §5.3
- Fleet enforcement/verification gap → §10.2
- Update delivery mechanics → §9.1 (§3.4 keeps channels + versioning only)

**G3 Verified facts to use (all checked 2026-11-24):**
- **CVE-2026-58704**: Pixel modem elevation-of-privilege (logic error,
  permission bypass), flagged by Google as "under limited, targeted
  exploitation" in the September 2026 Pixel bulletin (patch level
  2026-09-05); CISA KEV 2026-09-16. Likely needs network position (nearby or
  compromised cellular network) [S, Kaspersky]. Same bulletin: Critical modem
  RCE CVE-2026-56967, DoS CVE-2026-55306, PowerVR info leak CVE-2026-58731.
  Sources: https://source.android.com/docs/security/bulletin/pixel/2026/2026-09-01 ;
  https://9to5google.com/2026/09/16/google-pixel-targeted-zero-day-modem-attack/
- **Pixel 11 MTE**: Tensor G6 has hardware MTE; it was disabled in launch
  firmware and enabled in Android 17 QPR2; GrapheneOS describes it as "at least
  bare minimum support for MTE at a hardware level" and is still evaluating
  performance/coverage; earlier (Aug 2026) GrapheneOS said Pixel 11 might be
  skipped. Pixel 11 support still waits for Google's QPR2 AOSP source.
  Sources: https://www.privacyguides.org/news/2026/11/12/grapheneos-announces-pixel-11-support-can-be-completed-now/ ;
  https://www.privacyguides.org/news/2026/09/01/pixel-11-has-hardware-mte-support-may-still-be-usable-for-grapheneos/
- **Pixel 11 series** (incl. Pro Fold): announced 2026-08-12, on sale
  2026-08-20; Titan M3 and 7-year updates (Aug 2033) are on Google's store
  spec pages → [D]. MediaTek M90 modem and PowerVR C-Series GPU remain [S].
- **Pixel 10a**: Titan M2 is on Google's spec page [D]; optical sensor type
  from reviews [S]. It has Exynos 5400 + satellite SOS (same radios as Pixel
  10 non-Pro); not "fewest radios".
- **Motorola**: March 2026 MWC = partnership for an unnamed future device [S];
  September 2026 = Signature 27 unveiled and confirmed by GrapheneOS as first
  non-Pixel device [D] (project statement); retail date and GrapheneOS
  availability timing not confirmed (A07).
- **Pixel 10 support delay** was due to Android 16 QPR1 reaching AOSP only on
  2025-11-11 plus no device trees; experimental support late Nov 2025, stable
  in release 2026011000 [D] (project statements). NOT the OVH move.
- **Tier 1 Stage 2 cost** — use whatever §14.2 ends up with after Agent 4's
  changes; Agent 4 must update §0's figure too? NO: §0 belongs to Agent 1.
  Agent 1: write the Tier 1 figure as "about 20–34 analyst days" (Agent 4 will
  make §14.2 Tier 1 sum to exactly 20–34; see 4.x).

## Agent 1 — title block, §0, §1, §2, §3

1.1 §0: Tier 1 → "about 20–34 analyst days (§14.2) covering patch-lag
    analysis, governance and signing-key custody, incident-response design,
    MDM fit, an attack-surface review of messaging/media parsers, and (for
    Profile B) a duress-PIN legal review".
1.2 §0: add a short **"Decision constraints"** block after "Top areas":
    no certification (A12); a fleet cannot enforce or fully verify device-wide
    settings and has no device-wide remote wipe (§10.2); duress-PIN legal
    exposure (§8.8); credible alternatives are stock Pixel with Advanced
    Protection and iOS with Lockdown Mode (§13); what GrapheneOS does not
    solve: app/account compromise, phishing, carrier metadata, code running
    inside a compromised messenger.
1.3 §0 strengths: add **persistence resistance** — verified boot + rollback
    protection stop an implant surviving a reboot by modifying the OS, so
    auto-reboot also limits how long a memory-resident implant lasts [D]/[A].
1.4 §0 top areas: update to match Agent 4's new §11 order (see 4.1): 1 Google
    dependency, 2 GPU and accelerator drivers, 3 baseband (now with an
    in-the-wild Pixel modem exploit, CVE-2026-58704), 4 trust in a small team,
    5 messaging and media parser 0-click surface, 6 detection and incident
    response. Keep each to one line.
1.5 §0: tag line "Claims in this summary are tagged in the sections
    referenced." Remove the Cellebrite detail to one clause "(§8.7)".
1.6 §1.4: apply G1.
1.7 §2.4 P3/D1 cell → "A (privileged admins: not recommended → issue D2
    device)".
1.8 After §2.5 add **§2.6 Residual risk with Profile B applied** (table):
    T1 negligible; T2 AFU window up to the auto-reboot timer (1 h) and
    vendor counter-measures (§8.2); T3 browser/WebView, messaging/media and
    driver 0-day chains remain possible, raised in cost not removed; T4
    baseband/firmware (now including an exploited Pixel modem bug),
    supply-chain and signing-key compromise; operational: settings drift,
    no remote wipe, app/account compromise. Tag [A].
1.9 §3.1 history: split the Motorola row per G3 (two rows). Cut the history
    table to the essential rows (founding 2014; CopperheadOS 2015–2018 and
    split; rename; Foundation 2023; OVH exit Nov 2025; Motorola 2026) — keep
    it short; trim narrative prose around it.
1.10 §3.1 note: remove "(it delayed early Pixel 10 support)" — say only
    "it also shows service availability can be disrupted."
1.11 §3.1: add **legal compulsion** bullet: the project and keys sit under
    Canadian jurisdiction; because per-device targeted updates are rejected
    (§9.1), a compelled malicious update would have to ship to every device,
    making it more detectable (especially with reproducible-build checks)
    [D]/[A].
1.12 §3.2: move the Pixel 11 / QPR2 bullet out; replace with one clause
    "(Pixel 11 status: §5.2.9)".
1.13 §3.3: Motorola/[S]/[D] tagging per G1; absence tags per G1.
1.14 §3.4: keep channels table and versioning; replace "How updates are
    delivered" bullets with one line "Update delivery and its security
    properties: §9.1." (Agent 3 moves the content into §9.1.) Keep the
    assessment note but shorten.

## Agent 2 — §4, §5, §6

2.1 **New §4.8 "Attack-surface map"** (place at the END of §4 to avoid
    renumbering): table with columns: Surface | Reachable when (BFU /
    AFU-locked / unlocked / remote) | GrapheneOS-specific control | Residual
    risk | §11 area. Rows: browser (Vanadium); WebView in apps; messaging apps
    and media/image parsers; cellular radio (2G/LTE/5G pre-auth); IMS
    (VoLTE / Wi-Fi calling) and SMS/MMS/RCS; Wi-Fi; Bluetooth; NFC; USB-C;
    GPU and accelerator drivers (Mali, PowerVR, Tensor VPU); sandboxed Play
    layer; app stores/sideloading; update channel; secure element. Use §11
    area names (numbers per 4.1 order: 1 Google dependency, 2 GPU & accelerator
    drivers, 3 Baseband & IMS, 4 Supply chain & governance (incl. vulnerability
    handling), 5 Messaging & media parsers, 6 Detection & IR, 7 Enterprise
    manageability, 8 Browser/WebView, 9 App sourcing, 10 Sandboxed Play layer,
    11 Pixel 11 components, 12 Forensic claims, 13 Proximity radios (Wi-Fi/BT/NFC
    firmware), 14 Legal & regulatory fit (incl. duress PIN), 15 MTE /
    hardened_malloc opt-outs, 16 Default network & attestation data,
    17 Biometrics). Add one sentence: "Typical Android spyware chains combine
    an entry bug (browser renderer, messaging/media parser, or baseband) with
    a sandbox escape and a kernel or GPU/accelerator driver bug (GTIG 2025;
    §11)." [D]
2.2 §4.1 table fixes (M1, M2): MTE cell "Pixel 8 to 10a (FAQ); Pixel 11
    pending (§5.2.9)"; StrongBox cell "All in-scope Pixels (Titan M2; Titan M3
    on Pixel 11)"; add after table: "The IOMMU row is not on GrapheneOS's
    published list; the FAQ describes IOMMU isolation of the baseband
    separately. [D]"
2.3 §4.3: Titan M3 [D] (Google spec page) + "little public research" [A].
    **Add Titan M track record**: Quarkslab's Titan M research (Black Hat
    2021/2022; code execution CVE-2022-20233) shows the secure element itself
    has had exploitable bugs — use the Agent-3 research items if provided in
    section 3 of this file, else tag [A] and cite generically. Shorten the
    Cellebrite sentence to one clause "(§8.7)".
2.4 §4.5 baseband — add, tagged [D] with citations:
    - **CVE-2026-58704** exploited Pixel modem bug (G3) — first Pixel-specific
      baseband bug Google has marked exploited in the wild.
    - Project Zero 2023 Exynos disclosure: 18 bugs, 4 internet-to-baseband RCE
      via **IMS (VoLTE / Wi-Fi calling)** needing only the phone number;
      interim mitigation was turning off Wi-Fi calling and VoLTE
      (https://projectzero.google/2023/03/multiple-internet-to-baseband-remote-rce.html).
      So **LTE-only does not remove the IMS path** — fix any wording that
      implies it does.
    - Google red team modem RCE via 2G stack CVE-2022-20170 (Black Hat USA
      2023, https://i.blackhat.com/BH-US-23/Presentations/US-23-Karimi-Over-the-Air-Under-the-Radar.pdf)
      supports disabling 2G.
    - Google compiler hardening of Exynos baseband since Dec 2023 (BoundSan,
      IntSan) and Pixel 9 "most hardened baseband" (stack canaries, auto-init)
      (https://security.googleblog.com/2023/12/hardening-cellular-basebands-in-android.html ;
      https://security.googleblog.com/2024/10/pixel-proactive-security-cellular-modems.html);
      no equivalent statement for MediaTek M90 → [A] unverified.
    - 5G pre-auth injection without a fake base station (SNI5GECT, USENIX Sec
      2025, https://www.usenix.org/conference/usenixsecurity25/presentation/luo-shijie)
      and 5GBaseChecker (USENIX Sec 2024, https://usenix.org/conference/usenixsecurity24/presentation/tu):
      disabling 2G is not enough to make pre-auth parsing unreachable.
    - IOMMU limits (PeriScope NDSS 2019 idea; Project Zero Broadcom Wi-Fi 2017
      https://projectzero.google/2017/10/over-air-vol-2-pt-3-exploiting-wi-fi.html):
      IOMMU stops arbitrary DMA but not malicious data via shared buffers the
      driver reads; no primary Google document describes Tensor SMMU config →
      open question [A].
    - Umbrella citation: Carnot & Francillon, "SoK: Insecurity of Cellular
      Basebands", USENIX WOOT 2026 (https://www.usenix.org/conference/woot26/presentation/carnot).
2.5 §4.7 Motorola per G3 / C2 / M7 wording.
2.6 §5.1: Pixel 11 rows — Titan M3 [D] no dagger, Aug 2026 release, Aug 2033
    support end for both rows, Pro Fold "Aug 2026"; Pixel 9 row release "Aug
    2024 (9 Pro: Sep 2024)"; Pixel 10a note per G3 (Titan M2 [D], optical [S]).
2.7 §5.2 reorder subsections to: GPU & accelerator drivers, modem, secure
    element, MTE, fingerprint, radios, support window, foldables, time to
    support (keep numbering 5.2.1… contiguous after reorder).
2.8 GPU subsection — rename "GPU and accelerator drivers"; add [D] with
    citations:
    - Mali in-the-wild history incl. Pixel 6 (CVE-2021-39793, Pixel bulletin
      Mar 2022), CVE-2022-22706, CVE-2023-4211, CVE-2023-26083, CVE-2024-4610
      (Intellexa), Mali user-space CVE-2025-6558 (GTIG 2025 review,
      https://cloud.google.com/blog/topics/threat-intelligence/2025-zero-day-review/).
      Fix m5 (Mind the Gap does not cover CVE-2021-39793).
    - **CVE-2025-0072** (GitHub Security Lab, May 2025,
      https://github.blog/security/vulnerability-research/bypassing-mte-with-cve-2025-0072/):
      Mali UAF gave kernel code execution on Pixel 8 with kernel MTE on —
      **MTE does not cover memory the GPU reaches via its own page tables**.
    - PhantomMap (NDSS 2026, https://www.ndss-symposium.org/ndss-paper/phantommap-gpu-assisted-kernel-exploitation/):
      Mali GPU page-table handling turns ordinary heap bugs into physical
      memory R/W.
    - Google/Arm Mali ioctl SELinux hardening (Dec 2025,
      https://blog.google/security/further-hardening-android-gpus/) and the
      2024 Mali review that found bugs in Pixel-specific driver code
      (CVE-2023-48409, -48421; https://security.googleblog.com/2024/09/google-arm-raising-bar-on-gpu-security.html).
      No equivalent published hardening for PowerVR.
    - PowerVR: steady DDK CVE stream 2024–2026 (e.g. CVE-2024-43702,
      CVE-2025-25178/-25179/-25180, CVE-2025-46707; Imagination advisories
      https://imaginationtech.com/gpu-driver-vulnerabilities); no public
      in-the-wild exploitation found; low research ≠ robustness [A].
    - **Pixel 10 0-click chain** (Project Zero, May 2026,
      https://projectzero.google/2026/05/pixel-10-exploit.html): Dolby decoder
      CVE-2025-54957 → new Tensor G5 `/dev/vpu` video-accelerator driver
      mapping arbitrary physical memory. Pixel 9 chain (Project Zero, Jan 2026,
      https://projectzero.google/2026/01/pixel-0-click-part-3.html): Dolby
      decoder → BigWave driver; Dolby fix took 82 days to reach Pixel; stock
      MTE only on under Advanced Protection; Pixel KASLR ineffective.
    - Google Android Red Team GPU exploitation (Black Hat USA 2024, Adreno,
      https://i.blackhat.com/BH-US-24/Presentations/REVISED02-US24-Gong-The-Way-to-Android-Root-Wednesday.pdf):
      GPU features give physical-memory R/W bypassing CFI/W^X — relevant to
      Motorola/Snapdragon (§4.7).
2.9 Modem subsection: point to §4.5 for detail; add MediaTek: FirmWire (NDSS
    2022) and BaseBridge (OffensiveCon 2025, MediaTek baseband RCE without
    ASLR bypass, https://citation.thinkst.com/talk/96286) and MediaTek
    bulletin CVE-2025-20634 (rogue base station RCE,
    https://corp.mediatek.com/product-security-bulletin/February-2025) → the
    MediaTek M90 is not a less-studied target.
2.10 §5.2 MTE subsection (Pixel 11) — keep short, point to §5.2.9.
2.11 §5.2.9 (time to support, canonical Pixel 11 location): Pixel 10 delay
    cause per G3 (QPR1 + device trees, not OVH); Pixel 11 full status per G3
    incl. "bare minimum" MTE caveat, August "may be skipped" statement, and
    QPR2 source wait.
2.12 §5.3 fix C4: replace "Fewest radios" with "No UWB: same radio set as
    Pixel 10 non-Pro (incl. satellite SOS), fewer than Pro models; Pixel 9a/8a
    lack satellite but have shorter support and an older modem." Keep the
    Pixel 10a recommendation.
2.13 §5.2.2 m2: "Mali (Tensor G3 and G4, including Pixel 10a)".
2.14 §6 intro: add Rust/memory-safety context — Google reports memory-safety
    bugs fell below 20% of Android vulnerabilities in 2025 (Nov 2025 Google
    blog https://blog.google/security/rust-in-android-move-fast-fix-things/);
    remaining legacy C/C++ in media codecs, GPU user-space libraries and
    vendor blobs is where hardened_malloc and MTE add value [D]/[A].
2.15 §6.1 hardened_malloc: add Synacktiv independent review (Sept 2025,
    https://synacktiv.com/en/publications/exploring-grapheneos-secure-allocator-hardened-malloc):
    markedly stronger than Scudo esp. vs UAF; limits: ≥128 KiB allocations
    untagged (guard pages only), qualitative not a bypass study — the only
    independent evaluation found [D].
2.16 §6.3 MTE: add a **"Limits of MTE"** paragraph [D]:
    TikTag (Kim et al., arXiv 2406.08719, 2024, https://arxiv.org/abs/2406.08719)
    leaks tags speculatively on Pixel 8 (>95% in <4 s, incl. from Chrome and
    the kernel); StickyTags (IEEE S&P 2024, https://download.vusec.net/papers/stickytags_sp24.pdf)
    argues random tags are weak; Project Zero "MTE As Implemented" (Brand 2023,
    https://projectzero.google/2023/08/summary-mte-as-implemented.html):
    kernel MTE weaker (match-all tag, DMA, async); 16-byte granule misses
    intra-granule overflows; GPU page-level bugs bypass it (CVE-2025-0072).
    Conclusion: MTE raises cost, not a hard barrier; hardened_malloc's
    reserved freed-memory tag and differing neighbour tags partly follow the
    StickyTags direction [D, GrapheneOS docs if confirmed, else A].
    Apple MIE/EMTE (Sept 2025, https://security.apple.com/blog/memory-integrity-enforcement/)
    designed against tag leakage — depth vs GrapheneOS's breadth.
2.17 §6.3/§6.7: exploit-protection compatibility mode switches to Scudo, which
    has published exploitation techniques (Mao et al., USENIX WOOT '24, Best
    Paper, https://www.usenix.org/conference/woot24/presentation/mao), one
    still working → opt-out is not "slightly weaker".
2.18 §6.4 exec spawning: cite Lee et al., "From Zygote to Morula", IEEE S&P
    2014 (https://tc.gtisc.gatech.edu/cs8803/2014/r/morula.pdf) — zygote
    shared layout lets one leak defeat ASLR everywhere [D].
2.19 §6.5 kernel: per m1, re-head the second group "Also present in stock
    Pixel builds, and listed by GrapheneOS as enabled in its builds" [D].
    Add **kernel ASLR**: Project Zero (Nov 2025,
    https://projectzero.google/2025/11/defeating-kaslr-by-doing-nothing-at-all.html)
    showed Pixel kernel ASLR effectively absent (fixed linear map + fixed load
    address), Google treats as intended; GrapheneOS position undocumented [A]
    → Stage 2 question. Add **data-only kernel attacks**: Dirty Pagetable
    (Wu & Zhang 2023, https://yanglingxi1993.github.io/dirty_pagetable/dirty_pagetable.html)
    and SLUBStick (USENIX Sec 2024, https://www.usenix.org/conference/usenixsecurity24/presentation/maar-slubstick)
    bypass CFI/PAC/KASLR; no documented page-table protection [A].
2.20 §6.6 browser: add [D]: V8 sandbox (Groß 2024, https://v8.dev/blog/sandbox)
    — ~half of V8 bugs outside the JIT, MTE helps V8 little, sandbox not yet a
    strong boundary; Edge "Super Duper Secure Mode" data (2021,
    https://microsoftedge.github.io/edgevr/posts/Super-Duper-Secure-Mode/) —
    ~45% of V8 CVEs JIT-related; Intellexa/Predator Android first stages are
    Chrome renderer bugs, delivered via one-time links, network injection and
    malicious ads (GTIG Dec 2025, https://cloud.google.com/blog/topics/threat-intelligence/intellexa-zero-day-exploits-continue ;
    Amnesty Predator Files 2023). No public Vanadium patch-latency data exists
    [A] (absence).
2.21 §6.7 note: "opt-out the organisation cannot see" stays.
2.22 Shorten repeated Cellebrite / Pixel 11 / device-rec text in your range
    per G2.

## Agent 3 — §7, §8, §9, §10, §12, §13

(Additional forensic/legal research items will be appended in section 3 of
this file before you start — read it.)

3.1 §7.7: IMS — add that VoLTE and Wi-Fi calling are separate toggles and that
    Project Zero's 2023 internet-to-baseband RCEs went through IMS (§4.5);
    LTE-only does not remove IMS. Always-on VPN / Private DNS → [D] (Android
    documentation). Bluetooth: note GrapheneOS Bluetooth auto-off timeout [D
    if on features page, else A].
3.2 §7 new **§7.11 Messaging and media parsers**: image/media decoding inside
    apps runs in the app's own process (AOSP isolates audio/video codecs in
    separate processes; https://source.android.com/docs/core/media/framework-hardening);
    2025 0-click chains: LANDFALL Samsung Quram DNG CVE-2025-21042 via
    WhatsApp, exploited ~9 months (Unit 42 Nov 2025,
    https://unit42.paloaltonetworks.com/landfall-is-new-commercial-grade-android-spyware/);
    Paragon Graphite via WhatsApp 0-click running inside WhatsApp (Citizen Lab
    Mar 2025, https://citizenlab.ca/2025/03/a-first-look-at-paragons-proliferating-spyware-operations/);
    WhatsApp CVE-2025-55177 + Apple CVE-2025-43300 (Aug 2025); Project Zero
    Qmage MMS 0-click 2020 (CVE-2020-8899). iOS BlastDoor (Project Zero 2021,
    https://projectzero.google/2021/01/a-look-at-imessage-in-ios-14.html)
    has no Android equivalent for third-party messengers. GrapheneOS levers:
    hardened_malloc/MTE in app processes (untested against these exploits
    [A]), per-profile isolation of messengers, Network permission. Pixels do
    not ship Quram, but the bug class exists in AOSP and app-bundled libraries.
3.3 §8: add **§8.9 Track record** table (incident | date | affected |
    GrapheneOS impact/response | tag), using the forensic research items in
    section 3 of this file; include CVE-2026-58704 (modem, Sept 2026) only by
    reference to §4.5; and an absence line "no public in-the-wild
    exploitation of current GrapheneOS found [A] (absence — searched …)".
3.4 §8.7: canonical Cellebrite text (G2), keep Pixel 6–9 limit.
3.5 §8.8 / new **§10.6 Legal and regulatory fit**: regulated-communications
    recording (FINRA/SEC, FCA, MiFID II) vs Signal/disappearing
    messages/duress wipe; litigation hold/e-discovery vs duress wipe; employee
    privacy limits for BYOD monitoring; import/export of encryption devices;
    compelled-password jurisdictions; any 2025 police statements in Spain or
    France linking GrapheneOS Pixels with criminality — include ONLY if the
    forensic/legal research in section 3 provides a source, else omit. Tag [A]
    for the regulatory analysis.
3.6 §9.1: take over "How updates are delivered" content from §3.4 (copy it
    from the current §3.4 text and merge with §9.1; Agent 1 removes it from
    §3.4). Use one convention for "no deferral setting" ([A] absence).
3.7 §9.2: add [D]: 2022 leaked OEM platform certificates (Samsung, LG,
    MediaTek) signing malware (Rapid7,
    https://www.rapid7.com/blog/post/2022/12/02/leaked-android-platform-certificates-create-risks-for-users/
    → [S]); Pixel Binary Transparency log exists for stock Pixel images
    (https://security.googleblog.com/2023/08/pixel-binary-transparency-verifiable.html)
    — no equivalent GrapheneOS log found [A] (absence); TUF (Samuel et al.,
    ACM CCS 2010, https://theupdateframework.io/) role separation/threshold/
    offline root as the benchmark for Stage 2; Pöll & Roland "accountable
    builds" (ACM WiSec 2022, DOI 10.1145/3507657.3528537) for the
    reproducibility test. Compelled signing point → one clause pointing to
    §3.1.
3.8 §9.3: add a small **patch-lag evidence** table (desk data) if you can
    verify 3–6 data points quickly from https://grapheneos.org/releases and
    the Pixel/Chrome bulletins (e.g. Sept 2026 Pixel bulletin 2026-09-15 vs
    the GrapheneOS release carrying 2026-09-05). If you cannot verify, add a
    one-line "no published measurement exists; Stage 2 WP1" [A] (absence).
    Add RBUS detail (July 2025 bulletin listed 0 fixes, Sept 2025 listed 119)
    [S]; GrapheneOS says adevtool meant device-tree removal did not halt
    porting [D] (project statement).
3.9 §9.4 Auditor: replace "attestation verifies … not device settings" with the
    documented list of what Auditor reports (check https://attestation.app/about
    and the Auditor README/tutorial: e.g. OS/patch level, verified-boot key,
    adb enabled, OEM unlocking, device admins, accessibility services,
    enrolled fingerprints/user profiles, etc.). Then state precisely which
    §12.7 settings it does NOT see (auto-reboot timer, USB-C mode, PIN
    scrambling, cellular mode, duress PIN, per-app compatibility mode — verify).
    Local verification wording per earlier source check. attestation.app data
    stored → check what the server stores; tag accordingly.
3.10 §9.5: add install-time supply chain: never accept devices with
    GrapheneOS pre-installed by a reseller; install yourself from a trusted
    computer; confirm OEM unlocking is off via Auditor; avoid second-hand units
    for B [A].
3.11 §9.7: add persistence resistance (verified boot + rollback; reboot clears
    memory-resident implants) and the IR trade-off (capture evidence before
    rebooting, since reboot also destroys volatile evidence) [A]. Paragon
    Graphite shows code can run inside an app's sandbox where OS hardening
    only limits next steps (§7.11).
3.12 §10.2 canonical enforcement gap (G2) — update with what Auditor CAN see
    (from 3.9).
3.13 §12.4 and §12.7 B column: add **"Wi-Fi calling off; VoLTE off where the
    carrier allows voice without it — check emergency calling"**; note
    LTE-only without VoLTE may mean no voice calls on many carriers.
    Bluetooth/NFC off when unused; Bluetooth auto-off timeout. Update the
    "How enforced / verified" column per 3.9.
3.14 §12.1: remove the device table duplicating §5.3; keep procurement bullets
    and point to §5.3.
3.15 §13: add BlastDoor comparator line (iOS) and Apple MIE as depth vs
    breadth (one line each; detail stays in §6.3/§7.11). Check §13.1 claims
    flagged as from memory (stock allocator Scudo [D: AOSP], zygote [D],
    stock fingerprint 20 attempts [D: GrapheneOS features page]).
3.16 Apply G1 tags in range (e.g. Wallet requires certified OS → [D] Google
    Wallet help; F-Droid criticism and Accrescent recommendation → [D]
    project statements; "MTE crash reports can be shared" → [D]).

## Agent 4 — §11, §14, Appendices

4.1 §11.1: keep impact-weighted rule; add **"L and I are rated for the most
    exposed profile the area applies to (normally B)"** and a **tie-break**:
    "Within a band: higher likelihood first, then areas that decide whether
    the client can adopt at all, then lower verify effort."
4.2 §11.2 — new area list and order (re-rate with the rule; numbers below are
    the target order):
    1 Upstream dependency on Google (L H, I H) — impact mechanism stated:
      loss/late arrival of firmware, driver and platform fixes; Pixel 11 QPR2
      source wait as live evidence (§5.2.9).
    2 GPU and accelerator drivers (L H, I H) — Mali ITW history, MTE bypass
      via GPU page tables (CVE-2025-0072), PhantomMap, PowerVR unstudied,
      Pixel 10 VPU 0-click chain.
    3 Baseband and IMS (L M, I H) — CVE-2026-58704 exploited ITW (Sept 2026),
      IMS internet-to-baseband RCE (Project Zero 2023), MediaTek on Pixel 11.
    4 Supply chain, governance & vulnerability handling (L M, I H) — merge old
      #12 (vulnerability handling) into it; add Pixel Binary Transparency gap
      and 2022 platform-key leaks as context.
    5 Messaging and media parser 0-click surface (L M, I H) — NEW (LANDFALL,
      Graphite, WhatsApp 2025 chains).
    6 Detection & incident response (L H, I H for B) — now High.
    7 Enterprise manageability (L H, I M) — Medium.
    8 Browser / WebView (L M, I M).
    9 App sourcing (L M, I M).
    10 Sandboxed Play layer (L L, I H).
    11 Pixel 11 components (L M, I M) — add "bare minimum" MTE caveat.
    12 Forensic claims (L L, I H).
    13 Proximity radios: Wi-Fi/Bluetooth/NFC firmware (L L, I H) — NEW
       (Broadpwn/Project Zero Broadcom 2017, BrakTooth 2021, Pixel BT bulletin
       CVE-2026-55330 Oct 2026 Critical EoP).
    14 Legal & regulatory fit (L L, I H) — widen old #13 duress PIN legal
       exposure to legal/regulatory (recording obligations, e-discovery,
       export, compelled passwords).
    15 MTE / hardened_malloc opt-outs (L M, I M for C? keep rule) — note
       compatibility mode falls back to Scudo with published exploitation
       technique (WOOT '24); if I becomes M then Medium — your call under the
       rule; explain.
    16 Default network & attestation data (merge old #15 default network and
       old #17 attestation.app data protection) (L M, I L).
    17 Biometrics (L L, I L).
    Re-check each Risk against the rule; if your rating changes the order,
    follow the rule. **Report the final old→new mapping in your reply.**
    Use the target numbering above in your text; other agents use it too.
4.3 §11 "Rationale for ranking": rewrite for the new order; fix the #15
    rationale contradiction ("client can limit via approved-app list and
    training, but cannot enforce or verify it (§12.7)").
4.4 §11.3: rows for all 17 areas; "Reading the table" prioritised:
    "Profile B: start with 2, 3, 5, 6, 1, 4; settle 14 by legal review in
    parallel. Profile C: 1, 4, 6, 7, 10; check 16 before enrolling devices."
4.5 §14.1 key findings: update to new evidence (exploited Pixel modem bug;
    MTE limits; messaging/media parsers; Pixel 11 MTE caveat); one clause for
    Cellebrite "(§8.7)".
4.6 §14.2: renumber WPs sequentially in tier order (no out-of-sequence WP14);
    add WPs for: messaging/media parser attack-surface review (Tier 1, 3–5 d);
    proximity radios (Tier 3, 3–5 d); IMS/VoLTE path added to baseband WP;
    legal & regulatory review (Tier 1 if B, 1–3 d). **Make Tier 1 sum to
    exactly 20–34 days** (Agent 1 writes that in §0). Add a column "Decision it
    informs / threshold" with one concrete threshold per WP (e.g. "WP1: median
    lag from Google fix to GrapheneOS release for in-the-wild bugs > 14 days
    raises #1 confidence; ≤ 7 days lowers likelihood"). Add **§14.5 Stage 2
    exit criteria** (3–5 bullets). Update tier totals arithmetically.
4.7 §14.3: list Pixel 10a explicitly; comparison device "stock Pixel with
    Advanced Protection"; add SDR/IMS test capability for VoLTE/Wi-Fi calling.
4.8 §14.4: add questions: regulated-communications recording obligations;
    current platform and risk appetite; travel destinations; willingness to
    fund or contract with the project (reduces #4); budget and timeline. Put
    compliance questions right after persona questions.
4.9 Appendix A: A03/A06 move out into a new short list "Dependencies to
    monitor" (they are [D] facts); A02 "§11 #2, #3, #11" (update to final
    numbers); A04 per G3 (Titan M2 [D], optical [S]); add assumptions: GrapheneOS
    kernel ASLR position (A15), Tensor SMMU/IOMMU configuration for modem/Wi-Fi/GPU
    (A16), Pixel 11 MTE adequacy (A17). Update all §11 references to the new
    numbers.
4.10 Appendix B: drop the personas table (duplicate of §2.3); keep tiers and
    deployment models. Appendix D: delete (pointer only) and renumber
    following appendices? NO — keep letters stable: replace D's body with
    "Merged into §5.1." to avoid breaking references.
4.11 Appendix F: add all new sources cited by Agents 2 and 3 in this file
    (copy URLs from sections 2 and 3 above) grouped by topic: Memory safety;
    Baseband & radios; GPU & drivers; Forensics & physical; Spyware & parsers;
    Supply chain & updates; Upstream & devices.

## 3. Additional items (forensics/legal research + §7–end correctness review)

### For Agent 2 (§4.3)
- Weaver schedule [D] (https://grapheneos.org/faq encryption section): attempts
  1–4 no delay, then 1 min, 5, 15, 30, 90 min, 4 h, 12 h, 36 h, 4 d, 13 d,
  41 d, 123 d, 1 y, 3 y, 9 y; **only 20 attempts in total**; random 6-digit
  PIN ≈ 1-in-50,000 guessing chance if the secure element holds.
- Titan M track record [D]: Quarkslab "Attack on Titan M, Reloaded" (Black Hat
  USA 2022; https://blog.quarkslab.com/attacking-titan-m-with-only-one-byte.html;
  CVE-2022-20233) — code execution on first-gen Titan M and StrongBox key
  leak, needing root or SPI access; no Weaver break; "2021: A Titan M Odyssey"
  (Black Hat EU 2021, https://i.blackhat.com/EU-21/Wednesday/EU-21-Rossi-Bellom-2021-A-Titan-M-Odyssey.pdf).
  No public break of M2/M3 found [A] (absence).
- Google Pixel certification page [D] (https://support.google.com/pixelphone/answer/11062200):
  Titan M2 CC PP0084 (TrustCB) through Pixel 10/10a; **Titan M3 CC listed as
  "Ongoing"** (FIPS CAVP/ESV listed).

### For Agent 3
- §8.1 [D]: Johns Hopkins (Zinkus, Jois, Green 2021, https://arxiv.org/abs/2105.12613)
  — forensic extraction overwhelmingly targets AFU. 2024 Pixel firmware
  0-days used by forensic firms and reported by GrapheneOS: CVE-2024-29745
  (fastboot RAM leak), CVE-2024-29748 / CVE-2024-32896 (wipe interruption),
  all CISA KEV (https://nvd.nist.gov/vuln/detail/CVE-2024-29745 ;
  https://discuss.grapheneos.org/d/11860-vulnerabilities-exploited-in-the-wild-fixed-based-on-grapheneos-reports);
  Pixel fastboot now zeroes RAM. FAU "One key to rule them all" (DFRWS EU
  2021) FBE master key from RAM on 7/13 phones; FROST cold boot (ACNS 2013).
  DE storage readable BFU by design; GrapheneOS announced but not (found)
  shipped a toggle to effectively disable DE data (https://discuss.grapheneos.org/d/20401).
- §8.1 fix: "End session" only for secondary profiles; Owner keys cleared only
  by reboot (which auto-reboot does).
- §8.2 fix: Cellebrite "Safeguard Mode" targets **iOS** inactivity reboot, and
  has no reliable primary source → soften to [S] unverified or drop; better
  example: GrayKey "Evidence Preservation Mode" reportedly keeps iPhones AFU
  across reboot (404 Media, Oct 2026,
  https://www.privacyguides.org/news/2026/10/01/leaked-video-shows-that-police-can-bypass-iphones-automatic-reboot-feature/)
  [S]. Add: iOS timer fixed 72 h and Secure-Enclave-enforced (Classen 2024,
  https://naehrdine.blogspot.com/2024/11/reverse-engineering-ios-18-inactivity.html);
  GrapheneOS timer configurable but OS-enforced (init + kernel-panic
  fallback) [D].
- §8.3 [D]: Amnesty Feb 2025 Cellebrite USB chain (CVE-2024-53104,
  CVE-2024-53197, CVE-2024-50302; all KEV) on a locked Samsung; Amnesty cited
  GrapheneOS USB-C control as a defence
  (https://securitylab.amnesty.org/latest/2025/02/cellebrite-zero-day-exploit-used-to-target-phone-of-serbian-student-activist/).
  GrapheneOS states its control blocks all three at USB controller and kernel
  and it shipped fixes earlier via LTS kernels
  (https://discuss.grapheneos.org/d/20402-cellebrite-exploits-used-to-target-serbian-student-activist)
  — untested → Stage 2 replay test.
- §8.4 [D]: duress wipe is OS-enforced, not secure-element; ineffective against
  an attacker with code execution.
- §8.5 [D]: CVE-2022-20465 Pixel SIM-PUK lock-screen bypass (AFU only) —
  lock-screen logic is attack surface; short auto-reboot is a backstop.
- §8.7 add row: Nov 2024 GrayKey leak — Pixel up to 9 "partial" AFU only; no
  GrapheneOS entries reported (https://www.schneier.com/blog/archives/2024/11/what-graykey-can-and-cant-unlock.html) [S].
- §8.8 / §10.6 legal [D unless noted]:
  - **US v. Tunick** (N.D. Ga.): traveller indicted under 18 U.S.C. §2232(a)
    for a GrapheneOS duress wipe during a CBP search (Jan 2025); pending as of
    Nov 2026 [S] (https://www.404media.co/man-charged-for-wiping-phone-before-cbp-could-search-it/ ;
    https://www.privacyguides.org/news/2025/12/10/atlanta-activist-charged-with-wiping-phone-before-cbp-search/).
    Also US v. Basart guilty plea for remote iPhone wipe (DOJ M.D. Fla. 2022).
  - US circuit split on compelled biometrics: US v. Brown (D.C. Cir. 2025) vs
    US v. Payne (9th Cir. 2024) (https://cdt.org/insights/circuit-court-split-lays-the-groundwork-for-scotus-case-on-biometric-cell-phone-unlocking/).
  - UK: Schedule 7 Terrorism Act refusal is an offence (R v Rabbani 2017,
    https://www.statewatch.org/media/documents/news/2017/sep/rabbani-judgment-25-sept-2017.pdf);
    RIPA s.49/s.53 up to 2 years (5 national security).
  - France: Cour de cassation Ass. plén. 7 Nov 2022 n° 21-83.146 — refusing an
    unlock code protecting encryption can be an offence (art. 434-15-2).
  - Do NOT include the "Spain/France police statements" item (no source).
- §9.4 [D]: key attestation forged via leaked keyboxes/relays (Guardsquare Jan
  2026, https://www.guardsquare.com/blog/bypassing-key-attestation-api);
  Auditor's pairing pins a per-device key so forged chains from another key
  fail; first pairing is trust-on-first-use; Google rotated the attestation
  root in 2026 (new root signs RKP chains from 1 Feb 2026) — self-hosted
  verifiers must trust both roots.
- §9.7: Android 16 Advanced Protection intrusion logging exists on stock [D]
  (no GrapheneOS equivalent found [A] absence).
- §7.6 add rows: App Store (GrapheneOS), Certificate Transparency lists
  (GrapheneOS; alt Google/off), Private DNS check (GrapheneOS), DNS
  (network-provided; alt Private DNS); intro "the main default connections".
- §7.9: Accrescent "Distributed through the GrapheneOS App Store [D]; small
  catalogue [A]"; F-Droid criticism [D] project statements.
- §9.1: no-deferral → [D] (usage guide documents disabling only) — this
  overrides 3.6's [A].
- §9.2 reproducible builds → [D] (grapheneos.org/build documents reproducing
  official builds and SSH tag verification; https://grapheneos.org/build).
- §10.4 Wallet row: "Alternatives include contactless cards and watches with
  their own NFC; some bank apps offer their own NFC payments [S]" (drop Curve
  Pay unless sourced).
- §12.7: lock credential → "8+ digit PIN (MDM 'high' password complexity)";
  enforcement "MDM sets required complexity for the device lock via the work
  profile; exact length not enforceable". B USB-C: "Charging-only (or Off when
  charging by other means is acceptable)".
- §13.1: Advanced Protection per Google page: USB protection while locked,
  blocks 2G on supported devices, **turns off auto-connect** to open/WEP Wi-Fi
  (manual still possible), blocks sideloading, Play Protect on, Chrome JS
  optimizer off, 72 h inactivity reboot, intrusion logging [D]; MTE/Pixel 8+
  details [S]. Add: stock Pixels (Pixel 9/10, Android 16) hold NIAP Common
  Criteria MDFPP certification (VID11647, 2026; https://sec-certs.org/cc/3cb11fb7adbdf59a/)
  — GrapheneOS does not inherit it [D].
- §13.2: Lockdown Mode features [D] (Apple); MIE "arrived only with iPhone
  17 / iPhone Air (A19) hardware; older iPhones get only its allocator
  hardening" [D]; iOS 18.1 reboot detail [S] or [D] via Classen.
- §13.4: Stock Pixel certification "Yes (NIAP CC MDFPP, Pixel 9/10 on Android
  16) [D]"; WEP wording "(2G and sideloading blocked; insecure Wi-Fi
  auto-connect off)"; app compatibility "High (Play apps; sideloading
  blocked)".

### For Agent 4
- §11 #12 (Forensic claims) evidence: Amnesty USB chain (blocked class),
  2024 Pixel firmware 0-days; Safeguard Mode reference → GrayKey (iOS) [S].
- §11 #14 Legal & regulatory: raise L to M for US/UK/FR travel given US v.
  Tunick (live prosecution), UK Schedule 7, French ruling → likely Medium;
  re-check band.
- §11 #11 Pixel 11: Titan M3 CC "Ongoing" (Google cert page).
- §11 #1 wording: "Pixel kernel source harder to obtain" (not "by request").
- Appendix A A08: "despite quarterly full security bulletins and twice-yearly
  AOSP source releases".
- Appendix E: add row "LTE-only / 2G | Settings > Network & internet > SIMs >
  (SIM) > Preferred network type [D]; 'Allow 2G' (path not documented)".
- Appendix F: replace the xcancel URL with
  https://x.com/GrapheneOS/status/1993035936800584103 ; relabel the Android
  Developers QPR2 page as "beta release notes" and cite 9to5Google for the
  2026-11-10 release; mark the Android Enterprise KB "(may require sign-in)";
  add all section-3 sources.
