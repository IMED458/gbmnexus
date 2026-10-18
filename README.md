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

**Live document preview** — rendered next to the form, paginated into real
A4 pages:

- two-column body, 11 pt Calibri/Carlito on a 14.3 pt baseline
- GBMN masthead, double rule and volume line on every page
- full-width title, author line with affiliation, ORCID and corresponding
  superscripts, abstract, DOI
- figures, tables and diagrams inserted inline in the text, in either
  two-column or full-width layout
- declarations block assembled from the ethics, conflict and funding steps
- AMA reference list
- journal footer with ISSN and copyright line on every page

Three preview modes: **PDF** (paginated A4), **Title page** (the separate,
anonymisable title page) and **Web** (how the article looks on the site).

**Exports** — print-to-PDF straight from the browser, a standalone HTML
version of the article, and a JSON metadata package for the editorial
office.

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
src/part8.html    document builders, validation, pagination, exports
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
