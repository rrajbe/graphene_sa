# Round 6 residual list (internal; not part of the deliverable)

From the two final whole-document reviews. All earlier rules apply
(`style_round3.md`, `style_round4_tables.md`, decisions in `triage_round5.md`).
Edit ONLY your assigned sections. Line numbers refer to commit bc6c2a8; search
by quote. Commit with a message ending:

    Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>

## Global rules for this round

- R1 **Canonical homes — state in full once; elsewhere one clause + pointer:**
  - Selective delivery of a signed build → full text in §9.2 only.
  - US v. Tunick → full text in §8.8 only (short form elsewhere: "a pending US
    prosecution over a phone wipe at a border search (§8.8)").
  - "No equivalent data exists for the recommended Pixel 10a; WP12 tests it" →
    full text in §8.7 only; elsewhere "(Pixel 10a not covered; §8.7)".
  - NIAP certification of stock Pixel → full text in §13.1 only.
  - Pixel 10 non-Pro advice and the Mali-versus-PowerVR paragraph → full text in
    §5.3 only; §0 keeps one sentence each pointing to §5.3.
- R2 **Detection wording everywhere:** "a compromise may well go unnoticed".
- R3 **Scudo:** "Scudo has published exploitation techniques" (plural).
- R4 **Dash convention:** where a table legend says a dash means none, use "—"
  (not "None"). Make §12.2, §12.4 and §14.4 consistent with their legends (add
  a legend line "A dash (—) means nothing further applies" where missing).
- R5 **Dense cells:** keep each cell to one or two short sentences or a short
  bullet list; move extra detail into bullets directly under the table.
- R6 **Raw URLs** do not appear in body tables; cite by name, URL in Appendix F.
- R7 **Bullets inside cells** start with a lower-case letter unless a proper
  noun or abbreviation.

## Agent 1 — title block, §0–§3

- L13–14 split "public documentation, prior research and analyst knowledge".
- L40 → "(Pixel 8 to Pixel 11 in scope; Pixel 8 to 10a supported today; Pixel
  11 not yet supported)".
- L58 add "(§13.4)".
- L72, L112, L118–122 per R1 (short pointers to §8.7 and §5.3).
- L85 → "Google has marked a Pixel modem elevation-of-privilege bug
  (CVE-2026-58704) as under limited, targeted exploitation; the attack vector
  is unpublished."
- L87 "most common zero-click entry point" → "a leading zero-click entry point
  (§7.11)".
- L88 per R2.
- L98 NIAP per R1.
- L99 "It also has no…" → "There is also no device-wide remote wipe."
- L100 → "Wiping a device during a lawful search can lead to prosecution (a
  pending US case, §8.8); refusing to unlock is an offence in the UK in some
  settings and can be in France (§10.6)."
- L103 See column → "§7.8, §7.11, §9.7".
- L327 §2.5 legend: add "'Partial' means some controls apply but key gaps
  remain (see the footnotes); 'No' means the profile is not designed for that
  tier."
- §2.2: add a lead-in sentence before its list; §2.1–§2.6 headings to Title
  Case.
- L404 remove the duplicate tag inside the cell (keep Confidence column).
- L448 selective delivery per R1 (pointer to §9.2).
- L494 NIAP per R1.
- L513/L522 → "the latest regular (non-preview) release".

## Agent 2 — §4–§6

- L558 first GPU use in §4 → "graphics processing unit (GPU)"; plain "GPU" at
  L638.
- L628 → "Auto-reboot (§8.2) returns the device to this state. [Assessed]"
- L653 dense cell per R5.
- L835 dense PowerVR cell per R5.
- L837 add "(Project Zero, November 2025)" to the KASLR bullet in the January
  2026 row.
- L820 and the † on L796: add "(assumption A04)".
- L843 split the three PowerVR CVEs into bullets.
- L860 → "Do not assume obscurity protects the M90: attackers study MediaTek
  basebands heavily, though the M90 itself has little public research."
- L889 §5.2.7 tag → "[Documented] (end dates) / [Assessed] (time remaining,
  calculated from 2026-11-24)".
- L921 row label → "Supported Pixels (6a to 10a)"; kernel bullet → "QPR2
  kernels (Pixel 10 series ported from 6.12 to 6.18)"; add "Pixel 6 and 6 Pro
  moved to legacy extended support in the same release (§3.4)". Remove the raw
  URL (R6).
- L945, L961–969 keep as the canonical §5.3 text (R1).
- L1012 → "It is the only independent evaluation found. [Assessed] (absence —
  searched security conference proceedings and publisher sites, 2026-11)".
- L1036 Scudo per R3.
- L1092 remove raw URL from the cell (R6).

## Agent 3 — §7–§10, §12, §13

- L1224 cell → "sees:<br>• the IP address<br>• device model<br>• release
  channel<br>• installed version".
- L1239 LTE-only cell → "• disables every generation except 4G<br>• cuts
  legacy and new 5G attack surface<br>• cuts fake-base-station exposure<br>• 2G
  can also be turned off on its own"; delete the "documented feature" sentence.
- L1280 three-item prose list → bullets or merge into the list above it.
- L1298 per Agent 1 L87 wording ("a leading zero-click entry point") with tag
  "[Assessed] (§4.8; GTIG 2025 zero-day review)".
- L1323 dense BlastDoor cell per R5.
- L1463 keep as canonical §8.7 Pixel 10a text (R1).
- L1488–1493 keep as canonical §8.8 Tunick text (R1).
- L1553, L1606 selective delivery: keep full text in §9.2 (pick one place in
  §9.2); §9.1 pointer only.
- L1580 dense reproducible-builds cell per R5.
- L1730 → "Carrier-locked units, notably many Verizon Pixels, cannot be used.
  [Documented] (GrapheneOS install guide)"; keep "Buy unlocked devices…" as
  [Assessed].
- L1750 detection wording per R2.
- L1809 four-item list → lead-in with colon + four bullets.
- L1874 Tunick in §10.6 → short form + "(§8.8)" (R1); dense cell per R5.
- §12.2, §12.4 dash convention per R4.
- L2230–2245 §13.1: convert the three "- **Label.** text [Tag]" bullets into an
  Item · Detail · Confidence table; add lead-in before the next table: "The
  table compares the controls on each side."
- L2235–2239 NIAP: canonical home (R1).
- L2272 Pixel 10a gap → pointer to §8.7 (R1).
- L2306 Knox Vault → Favours "Neither (comparable to Titan M2, §4.3)".
- L2310 → "Typically ships Pixel patches within days (§9.3); Samsung flagships
  also patch monthly, mid-range models less often [Assessed]".

## Agent 4 — §11, §14, Appendices

- L1949 split "A duress wipe, a refusal to unlock or the messaging set-up".
- L1950 area 11 keep "little-studied" (consistent with Agent 2's L860 wording).
- L1968 cell split "No bug bounty, disclosure policy or published independent
  audit report found" into bullets.
- L1977, L2378, L3035 Pixel 10a gap → pointer to §8.7 (R1).
- L1978 and Appendix G L3047: Broadpwn → "Broadpwn (Exodus Intelligence, 2017);
  Project Zero Broadcom Wi-Fi research (2017)"; See → "§4.5; Appendix F"
  (BrakTooth and CVE-2026-55330 are not in §7.7).
- L1979, L3056 Scudo per R3.
- L1991 detection wording per R2.
- L2026 → "because Stage 2 Tier 1 work packages 1 and 2 (WP1, WP2; §14.2)
  cover them"; split "Then areas 8, 9 and 13" into a short list.
- L2386 Pixel 10 non-Pro → pointer to §5.3 (R1).
- L2438 WP2 dense cell per R5; selective delivery → one clause + "(§9.2)".
- L2449 WP13 precondition → "comparable to Pixel 8–10a".
- L2506, L2508 per R4 ("— | —").
- L2546 NIAP per R1 (pointer to §13.1).
- L2549 A15 chronology → "Project Zero showed stock Pixel KASLR was effectively
  absent (November 2025). GrapheneOS had already restored linear-map
  randomisation in release 2025091000 for the 6.1, 6.6 and 6.12 kernels, and
  added it back for 6.18 in release 2026102100." How to confirm → "Ask the
  project; inspect kernel configuration and measure randomisation on a release
  build (Stage 2, WP7 scope)". Dense cell per R5.
- Appendix G area 1 (L2933): split tags to match §9.3 (device trees, kernel
  source [Secondary]); "all firmware is closed" as its own row [Documented].
- Appendix G L2957/L2958: See → "§4.5, §5.2.2" and "§4.5".
- Appendix G L2967: "[Documented] (dependency A06)".
- Appendix G L2973 selective delivery → pointer to §9.2.
- Appendix G L2986 → [Assessed].
- Appendix G L2996 → "[Documented] / [Assessed]" with "§9.1, §10.2".
- Appendix G L2998, L3002 → [Assessed]; L3000 → "[Assessed] (absence —
  searched the Auditor and AttestationServer source, 2026-11)"; L3001 →
  "• alerting: [Documented] (§9.4)<br>• drift undetected: [Assessed] (§10.2)".
- Appendix G L3023 Tunick → short form + "(§8.8)".
- L2922 "Areas 6, 9, 11, 12 and 17" → bullet list.
- Appendix D: replace stub heading and body with "Appendix D — Device
  Specification Detail" pointing to §5.1 in one sentence (keep letter) — or
  leave as is if already one sentence.
- Appendix F: split L2868 into two bullets; move key attestation (L2855) to
  "Supply chain and updates"; full month names; "and" instead of "&"; "and"
  instead of " / " in titles we wrote (not in quoted publisher titles).
