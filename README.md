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

**Import from Word or PDF** — *Import Word / PDF* in the sidebar (or drop a file on
the window) reads a finished manuscript in the browser and fills every step: masthead
(volume, issue, period), article type, title, authors with affiliation numbers, ORCID
links and the corresponding-author mark, affiliations, received/accepted/published
dates, DOI, structured abstract, keywords, body sections with their own headings,
sub-headings, figures (images included), tables (merged cells, continued tables
rejoined, notes kept), and the reference list. A review dialog lists what was found
and what to check. Word (.docx) is read completely; PDF text is read with pdf.js
(loaded from cdnjs on first use), figures must then be re-inserted.

**New article** clears the open manuscript (with a JSON backup offered first).

**Live document preview** — real A4 pages in the GBMN article template (the M222
reference article), printed from the same DOM, so the PDF is exactly what the proof shows:

| | |
|---|---|
| Page | A4, margins 12.4 / 14.0 / 17.2 mm, footer 8.5 mm from the edge |
| Masthead | first page only: logo 50.3 × 13.0 mm, *VOLUME · ISSUE* and period Bold 8.5 pt #3C514C, 2.5 pt #006F68 rule |
| Article type | Bold 8 pt #006F68, letter-spaced, centred |
| Title | Calibri Bold 19.5 pt, #006F68, centred |
| Authors | Bold 9.5 pt #53625D; superscript affiliation number, linked **ID** (ORCID) and `*` in #006F68 |
| Affiliations | 8.5 pt #697774, centred, under the authors |
| Dates | *Received · Revised · Accepted · Published*, 7.5 pt #6C7C78 — each printed once it is filled in (step 16) |
| Abstract | box #F2F8F6 with 2.75 pt #006F68 left rule; labels Bold #008080, 10 pt; Keywords |
| DOI | Bold 10 pt #008080, full `https://doi.org/…` link |
| Body | two columns, 20.25 pt gutter, Calibri 11 pt single, justified, blank line between paragraphs, teal drop cap |
| Section headings | Bold 11 pt #A84950, uppercase |
| Figures / tables | caption above (*FIGURE 1.* / *TABLE 1.* Bold #008080 10 pt); table in green grid style (#A8D08D rules, #E2EFD9 rows), italic note below |
| References | 10 pt, numbered, hanging indent |
| Footer | three lines, 6.5 pt #687773, thin #CFDAD6 rule, every page |

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
| **Word (.docx)** | Real OOXML built part for part like the template: masthead table, single-column front matter with the abstract box, then a continuous two-column section (405-twip gutter), full-width sections for wide tables, drop cap, numbered references, three-line footer, A4 with 705/795/975-twip margins. Built by a built-in ZIP writer; no library, no server |
| **HTML** | Standalone editorial article page — sticky masthead, metadata strip, contents rail, full-width figures, dark mode, Highwire citation meta tags |
| **JATS XML package (.zip)** | NISO JATS (Z39.96) Journal Publishing DTD v1.3, the article PDF under the same base name, every figure as a separate file and a deposit README. A pre-flight dialog checks what PMC rejects. Citations are linked (`xref bibr`), Figure/Table mentions are cross-referenced, structured abstracts become `<sec>`s, article history and `self-uri` are included |
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

Step-by-step OJS upload and PMC application guide (Georgian): [docs/PMC-OJS-GUIDE.md](docs/PMC-OJS-GUIDE.md).

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
src/part12.html   Word/PDF import, New article
src/part8.html    proof builders, editorial proof editing, validation, exports
assets/           GBMN artwork (gbmn-masthead.* is the article masthead)
```

Everything is plain HTML, CSS and JavaScript — no build toolchain, no
dependencies. The only network use is optional: pdf.js for PDF import. Drafts are kept in
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
