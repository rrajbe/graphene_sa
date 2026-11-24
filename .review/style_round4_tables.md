# Round 4 editorial rules: tables instead of plain lists (internal)

Target: `grapheneos_assessment.md`. Edit ONLY your assigned sections. This is
a formatting pass: **do not change facts, numbers, dates, citations, ratings,
cross-references or the meaning of any confidence tag.** All round-3 rules in
`.review/style_round3.md` still apply (abbreviations expanded in headings and
table headers and at first use per top-level section; no single-line lists —
inside cells use `• item<br>• item`; tags written as words).

Commit on your branch with a message ending:

    Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>

## T1. Convert a list to a table when the items share a structure

Convert when **three or more** items each carry the same kinds of information.
Typical patterns in this document:

| List pattern | Table columns to use |
| --- | --- |
| `- **Label:** explanation [Tag]` | Item · Detail · Confidence |
| `- **Area N, name**, reason…` (rationale) | Area · Band · Why it ranks here |
| Findings or facts each with a source and tag | Finding · Source · Confidence |
| Strengths / weaknesses / gaps | Item · What it means · See (section) |
| Questions with references | Question · Why it matters · Related section |
| Steps with checks or outcomes | Step · Action · Check or outcome |
| Settings and values | Setting · Value · Where set / how verified |
| Timeline or incidents | Date · Event · Effect · Confidence |
| Pros and cons, or "X versus Y" points | Aspect · Option 1 · Option 2 |
| Nested bullets under several parent items | Parent item · Sub-points (`• …<br>• …`) |

Rules:
- Give every table a short lead-in sentence (what the table shows).
- 2–4 columns is ideal; never more than 6. Column headers in full words.
- When items carry confidence tags, put the tag in its own **Confidence**
  column. When items carry cross-references, put them in a **See** column.
- Keep each cell short (one or two sentences). If a cell needs three or more
  items, use `• a<br>• b<br>• c`.
- Numbered steps where order matters may stay a numbered list if each step is
  a single action with nothing else to tabulate; convert when steps have
  checks, owners or outcomes.

## T2. Leave as a list (do not force a table)

- Fewer than three items.
- Simple enumerations of short noun phrases with nothing else attached (for
  example "It has no: commercial support, SLA, fleet console"), unless they sit
  naturally as a column in an adjacent table.
- Blockquote **Assessment notes** with only one or two points.
- Appendix F (references) — keep as a list.
- Lists that would become a one-column table.

## T3. Merge rather than duplicate

If a list repeats the rows of a table right next to it, merge the list into
the table (add a column) instead of keeping both.

## T4. Check before committing

- Every table: header row + separator row + rows with the same number of
  cells; no `|` inside cells except escaped.
- No heading or table header contains an unexpanded abbreviation.
- No list item or cell strings three or more items on one line.
- Facts, tags and cross-references unchanged (compare against `git diff`).
