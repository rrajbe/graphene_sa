# Shared brief for parallel fix agents (internal; not part of the deliverable)

Target file: `grapheneos_assessment.md` (client deliverable, GrapheneOS Stage 1
security assessment). Edit ONLY the sections assigned to you, so parallel edits
merge cleanly. Do not reflow or reformat text outside the lines you change.
Commit your changes on your branch when done with a clear message ending with:

    Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>

Style: plain, direct British/neutral English; short sentences; tables where
useful; keep confidence tags. No internal notes, no references to "the plan" or
"earlier drafts" — the client never sees those.

## Confidence tags (updated rule — apply in your sections)

- **[D] Documented** — stated by GrapheneOS or Google on official channels,
  **including posts by GrapheneOS developers on the project forum, X or
  Mastodon** (write "(project statement)" where useful), and vendor advisories
  (Arm, Google TAG, Project Zero).
- **[S] Secondary** — press or third-party reporting only.
- **[O] Observed** — first-hand testing (none in Stage 1).
- **[A] Assumed** — analyst judgement.

## Decisions already made (apply consistently; do not re-decide)

1. **Android version / Pixel 11 timeline.** Google shipped Android 17 QPR2 to
   Pixels on **2026-11-10**. GrapheneOS release 2026111800 moved Pixel
   firmware, drivers, HALs and kernels (6.18 base) to QPR2, with the 2026-11-05
   patch level. [D] **Pixel 11 support is waiting for Google to publish the QPR2
   platform source to AOSP**, which GrapheneOS says Google has delayed
   (project statement, Nov 2026). [D] MTE for Pixel 11 arrived with QPR2 and
   works in GrapheneOS's port. [D] Pixel 11 is therefore **not yet supported**;
   use present tense ("is waiting for"), never "waited". This is a concrete
   example of the Google-dependency risk (§11 #1).
2. **Device recommendation (changed).** Recommend **Pixel 10a for all
   profiles (A, B, C, C+B)**. Alternative: **Pixel 10 (non-Pro)** where more
   performance is needed. Avoid Pro models for B (UWB, extra radios), foldables,
   new purchases of Pixel 8, and Pixel 11 until supported and settled.
   Reasoning: same Titan M2 and Exynos 5400 modem as Pixel 10; mature,
   well-studied Mali GPU stack with active patching vs unstudied PowerVR; fewest
   radios; longest support (Mar 2033); lowest cost. GPU trade-off noted as not
   decisive. Pixel 10a Titan M2 and optical fingerprint: treat as [S]
   (Google spec page + review), drop the † daggers.
3. **P3 (Security/IT staff)** highest credible tier is **T2**, with
   **privileged admins at T3**. So P3/D1 = A, P3/D2 = C (C+B for privileged
   admins), P3/D3 = C (privileged admins: not recommended → issue D2 device).
4. **§2.5 tier coverage:** T2 forensic: A = Partial (18 h default auto-reboot
   leaves a long after-first-unlock window), B = Yes, C = Partial (user-set
   device controls cannot be enforced or verified by the organisation; sandboxed
   Play), C+B = Yes. T3 spyware: B and C+B = **Strong** (not "Yes"); A and C =
   Partial. Reserve "Yes" for T1 and B/C+B on T2.
5. **Risk rule for §11:** Impact-weighted. **High** = Impact H and Likelihood M
   or H. **Medium** = Impact H with Likelihood L, or Impact M with Likelihood M
   or H. **Low** = everything else. State this rule explicitly.
6. **Team size:** "6–10 full-time developers (project statements on its forum;
   figures vary over time)" tagged [D]. Use "6–10" everywhere (not "about ten").
7. **Forensic leak framing:** the Oct 2025 Cellebrite matrix covers **Pixel 6–9
   only**; Pixel 10/10a/11 are not in it. GrapheneOS builds older than about
   2022 were accessible. Stock Pixels are extractable (BFU extraction yields
   limited data without the passcode; AFU and unlocked yield much more), and
   Cellebrite reportedly cannot brute-force Pixel passcodes. [S]
8. **Stock Pixel Advanced Protection:** since Android 16 (2025), stock Android
   offers **Advanced Protection mode** (on Pixel 8+ includes MTE for some
   components, 2G off, USB data protection when locked, and other hardening)
   and a **72-hour inactivity reboot**. GrapheneOS's difference is **scope and
   default strength**: MTE across the OS and most apps, hardened_malloc, exec
   spawning, shorter configurable auto-reboot (10 min–72 h), duress PIN,
   configurable USB-C modes, no privileged Google services. Verify the exact
   Advanced Protection feature list with a quick web search before writing,
   and tag accordingly.
9. **Fleet enforcement gap:** a work profile cannot enforce or verify
   device-wide settings (auto-reboot, USB-C, PIN scrambling, cellular mode,
   duress PIN). Auditor/attestation verifies OS integrity and patch level, not
   settings. Organisations cannot detect configuration drift.

## Review findings by agent (numbers refer to the peer review)

See your assignment in the task prompt.
