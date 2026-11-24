# GrapheneOS Security Assessment — Stage 1

> **Classification:** Client confidential (TLP:AMBER)
> **Version:** 0.1 draft · **Date:** 2026-11-24 · **Author:** Raj · **Reviewer:** _TBD_
>
> **Limitations:** This is a desk-based assessment. It draws on public
> documentation, prior research and analyst knowledge. No hands-on testing, code
> audit or reverse engineering was done in Stage 1. Facts are current as of the
> date above; GrapheneOS and Google change quickly.
>
> **Confidence tags:** **[D]** Documented — stated by GrapheneOS or Google ·
> **[S]** Secondary — press or third-party reporting only · **[A]** Assumed —
> analyst judgement, listed in the assumption register (Appendix A).

---

## 0. Executive Summary

_To be written last (plan task 4.3)._

## 1. Scope, Method & Confidence

_To be written._

## 2. Reference Profiles

_To be transferred from the plan (§2.1–§2.5)._

---

## 3. GrapheneOS Overview

GrapheneOS is a security-hardened mobile operating system based on the Android
Open Source Project (AOSP). It runs Android apps, but changes large parts of the
operating system underneath them to make exploitation and data extraction harder.
It is developed by a small non-profit team and currently runs only on Google Pixel
phones, with a first Motorola device announced.

### 3.1 Project Background, Governance, Funding and Infrastructure

**History**

| Period | Event | Tag |
| --- | --- | --- |
| Late 2014 | Founded by Daniel Micay as a solo project, starting with hardening work such as porting OpenBSD malloc to Android's C library and PaX kernel patches | [D] |
| Late 2015 – 2018 | A company was incorporated and became the main sponsor; the OS was known as **CopperheadOS** during this period. The project says it was agreed GrapheneOS would stay independently owned and controlled by its founder | [D] |
| 2018 | Split from the sponsor. The project's account says the company's CEO seized infrastructure and donations. This is the project's own account of a contested dispute and has not been independently verified | [D] (one-sided) |
| 2018–2019 | Rebranded to AndroidHardening, then to **GrapheneOS** (the site gives no dates; 2019 for the GrapheneOS name is analyst knowledge) | [D] / [A] |
| March 2023 | **GrapheneOS Foundation** created as a Canadian non-profit to receive and distribute donations | [D] |
| November 2025 | Left France and the hosting provider OVH, citing French pressure on encryption and device access | [D] |
| March 2026 | Long-term partnership with **Motorola** announced; the Motorola Signature 27 is to be the first non-Pixel device | [S] |

**Governance and team**

- The GrapheneOS Foundation is a **Canadian non-profit, not a registered
  charity**, based in Toronto. [D]
- The project describes "multiple full-time and part-time developers" plus
  companies that collaborate with it. [D] Public figures put the core development
  team at **roughly 6–10 full-time developers**. [S] [A06]
- Public documentation does not describe a formal governance structure: no board
  composition, decision process or succession plan. [A]
- The founder has historically been the public face of the project. Whether he
  still leads it day to day, and how key decisions are made, is not documented
  on the official site. [A]

**Funding**

- Mostly **donations** (bank transfer, PayPal, cryptocurrency). The FAQ states it
  is "entirely funded by donations" and will remain a non-profit. [D]
- Company collaborations exist. Motorola contributes engineering time to port
  GrapheneOS to its devices but does **not** fund the project. [S]
- There is **no commercial support offering or service-level agreement**. [D]

**Infrastructure and jurisdiction**

- After leaving OVH in November 2025, update mirrors run on **sponsored servers**
  (US; London as a temporary location). DNS runs on anycast networks with Vultr
  and BuyVM. Email, Matrix, the forum, Mastodon and the **attestation service**
  were moving to Netcup (Germany) short term and **colocated servers in Toronto**
  long term. [D] Whether that move is complete is unverified. [A05]
- Updates are verified by signature with downgrade protection at three layers
  (System Updater, update_engine, verified boot), and the project states that "the
  update server isn't a trusted party". **A compromised or seized mirror could
  delay updates, but could not push malicious ones** unless the signing keys were
  also compromised. [D]

> **Assessment note — why this matters to the client**
> - **Concentration risk.** A team of about ten, funded by donations, with no
>   published governance or succession plan, maintains an OS the client may build
>   a security programme on. Signing-key custody sits with this team (§9.2).
> - **No commercial recourse.** No support contract, SLA or indemnity. An
>   organization would carry the operational risk itself.
> - **Jurisdiction.** The legal entity and long-term infrastructure are in
>   Canada. The 2025 move shows the project will relocate under legal pressure,
>   which is reassuring on intent but shows that service availability can be
>   disrupted (it delayed early Pixel 10 support).
> - **Public disputes.** The project is involved in public conflicts (the
>   CopperheadOS split; disputes with press and other projects). This is a
>   reputational factor for an organization adopting it, not a technical flaw.
>
> Feeds §11 area #2 (Supply chain, governance & infrastructure).

### 3.2 Design Philosophy

- **Security first, then privacy.** GrapheneOS treats strong exploit
  mitigation and sandboxing as the foundation; privacy features are built on top
  of that, not in place of it. [D]
- **Harden AOSP, don't replace it.** It keeps the Android security model (app
  sandbox, verified boot, permission system) and makes it stronger: hardened
  memory allocator, hardware memory tagging, stricter app sandbox, extra
  permissions and reduced attack surface (§6, §7). [D]
- **Hardware requirements are non-negotiable.** Devices must offer, among other
  things, hardware memory tagging (ARM MTE or equivalent), a secure element with
  StrongBox and Weaver, verified boot with user-installed keys, and long-term
  firmware updates. This is why only Pixels qualify today, and why Pixel 11
  support waited for MTE enablement (§4.1, §5). [D]
- **No Google apps or services by default.** Like AOSP, GrapheneOS ships without
  them and says they will never be bundled. Users who need them can install Google
  Play as ordinary sandboxed apps with no special privileges (§7.4). [D]
- **No root access.** GrapheneOS does not provide a way to run apps as root,
  because it would break the verified boot and sandbox guarantees the design
  depends on. [A] — confirm wording in plan task 4.1.
- **App compatibility is preserved where possible.** Hardening that breaks apps is
  offered as per-app toggles rather than removed, which creates opt-outs worth
  examining (§6.7, §11). [D]

### 3.3 What GrapheneOS Is Not

| Common assumption | Reality | Tag |
| --- | --- | --- |
| A "de-Googled privacy ROM" like /e/OS or CalyxOS | It is a hardening project first; privacy follows from sandboxing. It also allows sandboxed Google Play, which pure de-Googled ROMs don't | [D] |
| Runs on many devices, like LineageOS | Runs only on devices that meet its hardware requirements: currently Pixel 6 and newer (Pixel 6/6 Pro on legacy extended support), with Motorola to follow | [D] |
| Can be rooted or customized freely | No root access; the bootloader is re-locked with GrapheneOS keys after install | [A] / [D] |
| An anonymity tool | It does not hide your identity from the mobile network, carrier or the services you sign into. Anonymity needs separate measures (e.g. Tor, careful account use) | [A] |
| A certified or accredited product | No known Common Criteria, FIPS 140 or government accreditation. The FAQ discusses external review, not certification | [A] |
| An enterprise product with vendor support | No commercial support, SLA, fleet console or management service. It supports Android Enterprise work profiles via standard MDM (§10) | [D] / [A] |
| Independent of Google | It depends on Google for hardware, firmware, security patches and AOSP source releases (§4, §9.3) | [D] |

> **Assessment note.** For regulated clients, the lack of certification may rule
> GrapheneOS out for some uses regardless of its technical strength. Confirm the
> client's compliance needs (assumption A12).

### 3.4 Release Channels and Versioning

**Channels**

| Channel | Purpose | Tag |
| --- | --- | --- |
| **Alpha** | First public push, after developer testing | [D] |
| **Beta** | Pushed shortly after Alpha. Releases with problems are aborted and replaced by a new Beta release | [D] |
| **Stable** | Promoted after users on Beta have tested it. The project advises Stable for anyone who "cannot tolerate dealing with temporary issues" | [D] |
| **Legacy extended support** | Stopgap releases for end-of-life devices (currently Pixel 6 and 6 Pro). Patch level is frozen; the project advises these are a last resort | [D] |

**Versioning and cadence**

- Builds are numbered as 10-digit values such as **2026111800** (latest as of
  2026-11-24, based on Android 17 QPR2 with the 2026-11-05 Pixel security patch
  level). The number reads as date (YYYYMMDD) plus a two-digit counter; the site
  does not define the format. [D] / [A]
- Releases are frequent: about two dozen between early July and 18 November 2026,
  roughly one a week. [A] (count of changelog entries)

**How updates are delivered**

- Automatic background updates, checking about **every six hours** when
  connected. [D]
- Updates install to a **secondary copy of the OS**, which becomes active only
  after the update completes; if the new version fails to boot, the device rolls
  back. [D]
- Uses **incremental (delta) updates** when available; a full package can upgrade
  from any past version. [D]
- Works while the device is **locked and idle, including before first unlock**,
  so devices kept in the most secure state still get patched. [D]
- Every package is **signed and checked, with downgrade protection**; updates
  carrying a serial-number constraint (i.e. targeted at one device) are
  rejected. [D]
- Users can restrict updates to non-roaming or unmetered networks, require
  charging or a minimum battery level, and opt in to automatic reboot. There is
  **no setting to delay updates**; the only way to stop them is to disable the
  System Updater app, which the project strongly advises against. [D]
- Updates can also be sideloaded from recovery with adb, without enabling adb in
  the OS. [D]

> **Assessment note.** The update design is strong: signed, rollback-protected,
> works before first unlock, and resistant to targeted (per-device) updates.
> The gaps for an organization are:
> - **No staged rollout control.** A fleet cannot pin or defer a version, so a
>   bad Stable release reaches all devices at roughly the same time. The
>   compensating control is to run a few devices on Beta as early warning.
> - **Patch timing depends on Google.** GrapheneOS says it can only fully deliver
>   security updates while the OEM releases them, and Google's switch to
>   quarterly full bulletins and twice-yearly AOSP source drops affects when fixes
>   arrive (§9.3, §11 area #1).

---

## 4. Platform Foundations & Trust Model

_To be written (plan task 2.2)._

## 5. Device Generation Analysis (Pixel 8 → Latest)

_To be written (plan task 2.3)._

## 6. Exploit Mitigations

_To be written (plan task 2.4)._

## 7. Privacy, Network & App Model

_To be written (plan task 2.5)._

## 8. Physical & Forensic Resistance

_To be written (plan task 2.6)._

## 9. Operations & Lifecycle

_To be written (plan task 2.7)._

## 10. Enterprise & Compatibility

_To be written (plan task 2.8)._

## 11. Areas to Examine First (Ranked)

_To be written (plan task 3.1)._

## 12. Reference Secure-Phone Configurations

_To be written (plan task 3.3)._

## 13. Comparative Positioning

_To be written (plan task 2.9)._

## 14. Recommendations & Proposed Stage 2

_To be written (plan task 3.4)._

---

## Appendices

- **A.** Assumption register — see plan; to be transferred at delivery
- **B.** Persona, threat-tier and deployment-model definitions
- **C.** Glossary
- **D.** Device specification detail
- **E.** Hardening settings reference
- **F.** References and sources

### Sources used in §3

- GrapheneOS history: https://grapheneos.org/history/
- GrapheneOS releases: https://grapheneos.org/releases
- GrapheneOS usage guide (Updates): https://grapheneos.org/usage
- GrapheneOS FAQ: https://grapheneos.org/faq
- GrapheneOS infrastructure post, November 2025: https://xcancel.com/GrapheneOS/status/1993035936800584103
- The Register, GrapheneOS leaves OVH: https://www.theregister.com/2025/11/28/grapheneos_ovhcloud/
- 9to5Google, Motorola partnership: https://9to5google.com/2026/03/01/motorola-confirms-grapheneos-partnership-for-a-future-smartphone-porting-features/
- Notebookcheck, Motorola plans: https://www.notebookcheck.net/GrapheneOS-reveals-full-Motorola-plans-7-year-updates-Razr-support-more.1375825.0.html
- GrapheneOS forum, Foundation: https://discuss.grapheneos.org/d/4047-grapheneos-foundation
