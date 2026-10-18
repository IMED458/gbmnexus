# GBMN Manuscript Submission & Generator

A single-file, offline-capable manuscript submission tool for the
**Georgian Biomedical and Medical Nexus (GBMN)** — Tbilisi State Medical University.

Authors fill in structured fields; the application compiles a complete,
print-ready article in the exact GBMN printed layout (A4, two columns,
masthead and footer on every page), plus a separate title page and a
web version of the same article.

## Live

Served from GitHub Pages: open `index.html`.

## What it does

**Submission workflow** — the 17-step author workflow used in
`gbmnsubmit`, ported field for field:

1. Getting Started
2. Journal Policies
3. Manuscript Checklist
4. Title & Metadata
5. Authors
6. Article Type
7. Abstract
8. Keywords
9. Manuscript Sections
10. References (AMA)
11. Supplementary Files
12. Ethics Statement
13. Conflict Disclosures
14. Funding Info
15. Files for Editorial Office
16. Manuscript Preview
17. Summary & Submit

Each step carries its own completion state (complete / warning / empty) and
feeds an overall readiness meter.

**Live document preview** — real A4 pages, laid out to the measurements of a
published GBMN article and printed from the same DOM, so the PDF is exactly
what the proof shows:

| | |
|---|---|
| Page | A4, text block 40→556 pt (14.1 / 13.9 mm side margins) |
| Columns | two, 240.3 pt wide, 35.3 pt (12.45 mm) gutter |
| Body | Calibri 11 pt on a 14.3 pt baseline, justified, 5 mm first-line indent |
| Title | Calibri Bold 19.6 pt, #006F68, centred |
| Authors | Calibri 12 pt #686868, superscripts Bold 8 pt #006F68 |
| Abstract | heading Bold 11 pt #B9353A, labels Bold 10 pt #006F68, body 10 pt |
| DOI | Bold 11 pt #008080, underlined |
| Section headings | Bold 11 pt #B9353A, uppercase |
| Rules | 2.25 pt + 0.75 pt, #006666, full measure |
| Footer | Bahnschrift SemiLight 8 pt, four lines |

The masthead, issue line and footer repeat on every page; the body is
paginated into page boxes so nothing ever runs over the footer. Figures,
tables and diagrams sit inline and can be set to **two-column** or **full
article width**; the article ends with the author affiliations, the
corresponding author, acknowledgements, declarations and the AMA reference
list, all in the same two-column flow.

Three preview modes: **PDF** (the A4 proof), **Title page** (the separate,
anonymisable title page) and **Web** (the exported HTML article, shown in a
frame, so what you see is the file you get).

**Editorial access** — the sidebar has a role switch. As **Editor** or
**Journal manager** you can open any exported submission file, every step is
open regardless of validation, and the proof itself becomes editable: click a
paragraph, heading or caption in the A4 page and correct it. Changes are
written back into the manuscript and recorded in an edit log. (Per-user
accounts and permissions live in the journal's Firebase application; this file
carries the editing capability, not the authentication.)

**Exports**

| Format | What it is |
|---|---|
| **PDF** | Print-to-PDF straight from the browser, in the paginated A4 journal layout |
| **Word (.docx)** | Real OOXML carrying the same layout and the same measurements: running header with the masthead and issue line, single-column front matter, then a continuous two-column section (706 twips gutter) for the body, running footer, A4 with 794-twip side margins. Built by a built-in ZIP writer; no library, no server |
| **HTML** | Standalone editorial article page — sticky masthead, metadata strip, contents rail, full-width figures, dark mode, Highwire citation meta tags |
| **JATS XML package (.zip)** | NISO JATS (Z39.96) Journal Publishing DTD v1.3, plus every figure as a separate file and a deposit README |
| **PubMed citation XML** | PubMed 3.0 DTD (`ArticleSet`) |
| **JSON** | Full metadata package for the editorial office |

### Indexing

The JATS package is the full-text format PubMed Central recommends, and the
same format Scopus and Web of Science ingest from publishers. It carries the
journal ISSNs and publisher, the DOI, article type and specialty, the running
head, structured contributors with ORCID iDs and `aff` cross-references, the
corresponding-author note, publication date, volume, issue and pagination,
a CC BY 4.0 `permissions` block, the abstract, author keywords, the funding
group, element counts, sectioned body with `fig` and `table-wrap`, and a
`ref-list` of `element-citation` entries.

Before depositing to PMC: add the article PDF under the same base name as the
XML, replace the PNG figures with the original high-resolution TIFF or EPS and
update the `graphic/@xlink:href` extensions, then run the file through the PMC
Style Checker.

PubMed citation deposit uses a different schema from PMC full text, which is
why both files are produced separately.

## Structure

```
index.html        built, self-contained application — no network needed
build.sh          rebuilds index.html from src/
src/part1.html    design tokens, application shell, form styles
src/part2.html    document stylesheet (A4 print layout)
src/part3.html    page markup
src/part4.html    icons, article types, manuscript model, steps, sidebar
src/part5.html    rich-text editor (figures, tables, diagrams)
src/part6.html    steps 1–9
src/part7.html    steps 10–17
src/part9.html    ZIP writer, HTML block parser, DOM-to-DOCX builder
src/part10.html   JATS 1.3 and PubMed 3.0 XML builders
src/part11.html   the public HTML article page
src/part8.html    proof builders, editorial proof editing, validation, exports
assets/           GBMN masthead artwork
```

Everything is plain HTML, CSS and ES5-compatible JavaScript — no build
toolchain, no dependencies, no runtime network calls. Drafts are kept in
`localStorage`. The only outbound requests are optional and user-initiated:
ORCID author lookup and Crossref DOI lookup.

## Rebuilding

```bash
./build.sh
```

Edit the files under `src/`, run the script, commit the regenerated
`index.html`.

## License

© Georgian Biomedical and Medical Nexus. All rights reserved.
