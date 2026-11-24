# Round 3 editorial rules (internal; not part of the deliverable)

Target: `grapheneos_assessment.md`. Edit ONLY your assigned sections. This is
an editorial pass: **do not change facts, numbers, dates, citations or the
meaning of any tag.** Commit on your branch with a message ending:

    Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>

## R1. No single-line lists

Any sentence, paragraph or table cell that strings together **three or more
separate items or points** (separated by commas, semicolons, "and", or
sentence after sentence of parallel points) must be split into a list with
**one item per line**.

- In prose: use a short lead-in sentence ending with a colon, then bullets.
  Nested bullets are fine for sub-points.
- Paragraphs that make several separate arguments (like the §11 "Rationale
  for ranking" paragraph) become one bullet per argument. Example — this:

  > High band (1–6). Google dependency (#1) leads because …. GPU and
  > accelerator drivers (#2) and baseband and IMS (#3) are rated likelihood H
  > because …. Supply chain and governance (#4) leads …. Messaging and media
  > parsers (#5) follow …. Detection and IR (#6) is rated …

  becomes:

  > **High band (areas 1–6)**
  > - **Area 1, dependence on Google**, ranks first. Its likelihood is high,
  >   and it decides whether GrapheneOS can be adopted at all:
  >   - every fix below the operating system comes from Google;
  >   - the Pixel 11 wait shows the dependency causing problems now.
  > - **Area 2, GPU and accelerator drivers**, and **area 3, baseband and IMS**,
  >   are rated High likelihood. Both have current in-the-wild exploitation on
  >   Pixel hardware; the modem rating is High because of CVE-2026-58704.
  > - …

- In table cells: if a cell holds three or more items, put each on its own
  line using `<br>• ` between items (start the cell with `• ` too). If a cell
  would need more than about five items or long sentences, keep the cell to a
  short summary and move the detail into a bullet list directly below the
  table, referenced from the cell.
- Two-item phrases ("A and B") are fine on one line.
- Keep sentences short (aim for under 25 words). One idea per sentence.

## R2. Abbreviations

**R2.1 Headings (all `##`, `###`, bold run-in titles such as `**5.2.1 …**`,
and table column headers):** no unexpanded abbreviation. Write the full term;
you may add the abbreviation in brackets after it, e.g.
"Before First Unlock (BFU) versus After First Unlock (AFU)",
"Titan Secure Element", "Hardware Memory Tagging (Memory Tagging Extension, MTE)".
Brand and product names are not abbreviations (GrapheneOS, PowerVR,
MediaTek, WhatsApp, GitHub, Titan M2, Pixel, Vanadium, Auditor, etc.).

**R2.2 Body:** expand every abbreviation at its **first use in each top-level
section** (`## N.`) as "Full term (ABBR)". After that, the abbreviation may be
used in that section. Expand again in the next top-level section. Tables and
blockquote notes count as part of their section.

**R2.3 Remove unnecessary abbreviations — always write in full:**
| Replace | With |
| --- | --- |
| IR | incident response |
| FW, HW, SE (in prose) | firmware, hardware, secure element |
| RE | reverse engineering |
| MTD | mobile threat defence |
| DoS | denial of service |
| RCE / RCEs | remote code execution |
| EoP | elevation of privilege |
| ITW | in the wild |
| e.g. / i.e. / etc. | for example / that is / (rewrite) |
| vs / vs. | versus |
| incl. / approx. / ~ | including / approximately / about |
| H / M / L (ratings) | High / Medium / Low |
| L / I (column headers) | Likelihood / Impact |
| "#5" (an §11 area) | "area 5" (keep the §11 link: "§11 area 5") |
| Q2 / Q4 | second quarter / fourth quarter |
| KiB | kilobytes |
| fn² / fn | footnote 2 |
| T1–T4, P1–P5, D1–D4 used alone | keep the code but add the name the first time in each section, e.g. "T3 (commercial spyware)" |
| WPn | "work package n (WPn)" at first use per section; headers say "Work package" |

**R2.4 Confidence tags — replace the letter codes with words everywhere:**
`[D]` → `[Documented]`, `[S]` → `[Secondary]`, `[A]` → `[Assessed]`,
`[O]` → `[Observed]`. Combined tags: `[D] / [A]` → `[Documented] / [Assessed]`.
Assumption references: `[A] (A05)` → `[Assessed] (assumption A05)`.
Update the legend in the title block and §1.4 accordingly (Agent 1 only).

**R2.5 Canonical expansions** (use exactly these):

| Abbreviation | Expansion |
| --- | --- |
| ACM | Association for Computing Machinery |
| AFU | After First Unlock |
| AOSP | Android Open Source Project |
| API | application programming interface |
| ART | Android Runtime |
| ASLR | address space layout randomisation |
| AVB | Android Verified Boot |
| BFU | Before First Unlock |
| BTI | Branch Target Identification |
| BYOD | bring your own device |
| CBP | US Customs and Border Protection |
| CC | Common Criteria |
| CFI | control-flow integrity |
| CISA | US Cybersecurity and Infrastructure Security Agency |
| CVE | Common Vulnerabilities and Exposures (identifier) |
| DE | Device Encrypted (storage) |
| DMA | direct memory access |
| DNS | Domain Name System |
| FAQ | frequently asked questions |
| FBE | file-based encryption |
| FCA | UK Financial Conduct Authority |
| FINRA / SEC | US Financial Industry Regulatory Authority / Securities and Exchange Commission |
| FIPS | Federal Information Processing Standards |
| GPU | graphics processing unit |
| GTIG | Google Threat Intelligence Group |
| IEEE | Institute of Electrical and Electronics Engineers |
| IMS | IP Multimedia Subsystem (carries VoLTE and Wi-Fi calling) |
| IOMMU / SMMU | input–output memory management unit / system memory management unit |
| IPC | inter-process communication |
| JIT | just-in-time (compilation) |
| KASLR | kernel address space layout randomisation |
| KEV | Known Exploited Vulnerabilities (catalogue) |
| LTE | Long-Term Evolution (4G) |
| MAC (address) | media access control address |
| MDM | mobile device management |
| MiFID II | EU Markets in Financial Instruments Directive II |
| MTE | Memory Tagging Extension |
| MVT | Mobile Verification Toolkit |
| NDSS | Network and Distributed System Security Symposium |
| NFC | near-field communication |
| NIAP | US National Information Assurance Partnership |
| NVD | US National Vulnerability Database |
| OEM | original equipment manufacturer |
| OS | operating system |
| PAC | Pointer Authentication Code |
| PIN | personal identification number |
| PUK | PIN unlock key |
| QPR | Quarterly Platform Release (e.g. QPR2) |
| RAM | random-access memory |
| RCS | Rich Communication Services |
| RIPA | UK Regulation of Investigatory Powers Act 2000 |
| SDR | software-defined radio |
| SIM | subscriber identity module |
| SLA | service-level agreement |
| SoC | system on a chip |
| SUPL | Secure User Plane Location |
| TLP | Traffic Light Protocol |
| TUF | The Update Framework |
| USB | Universal Serial Bus |
| USENIX | (name of the Advanced Computing Systems Association; write "USENIX Security Symposium" / "USENIX WOOT (Workshop on Offensive Technologies)") |
| UWB | ultra-wideband |
| VoLTE | Voice over LTE |
| VPN | virtual private network |
| VPU | video processing unit |
| WEP | Wired Equivalent Privacy |

For any abbreviation not in this table, expand it at first use per section,
and list it (abbreviation + expansion) in your final reply so the coordinator
can add it to the glossary.

## R3. Avoid ambiguity

- Replace vague words ("this", "it", "the feature") where the referent is
  unclear with the noun.
- Do not use "/" to mean "or" or "and" in prose; write the word.
- Keep cross-references exact ("§9.4", "§11 area 7").
- Do not use the Mermaid node IDs (HW, SE, FW, APPS, NET, UPD, GO) in prose;
  leave the code block itself alone except expanding visible labels.
