# 42 — report fixtures: ground-truth edit tally (D11, ING-4)

Draft = `python -m hearnarro dump <pdf> --jsonl --no-ocr` (counts: 40_gt_reports_draft.txt).
Edits are reproducible from the scratchpad script gt_reports_edit.py (explicit drop/move lists per fixture).
Pages checked against 100-dpi renders of all 4 pages per fixture. Golden scores after freezing: 41_gt_reports_golden.txt.

| fixture | draft | final | moved | dropped | joined | golden score | main parser error |
|---|---|---|---|---|---|---|---|
| report_01_zero_trust | 71 | 58 | 0 | 13 | 0 | 0.7759 | Boilerplate not filtered: running header, vertical margin stamp, page number "ii", and the cover DOI/availability/signature lines are all emitted as segments. |
| report_02_patch_mgmt | 78 | 65 | 0 | 13 | 0 | 0.8000 | Same: header/margin-stamp/page-number/cover boilerplate emitted; cover signature block mis-typed as footnote. |
| report_03_ssdf | 71 | 58 | 0 | 13 | 0 | 0.7759 | Same as report_01. |
| report_04_rmf | 76 | 60 | 1 | 16 | 0 | 0.7000 | Boilerplate emitted, plus the next page's running header merged into the cover signature line (seg 22) and header rule typed "equation"; cover summary box read before the "JOINT TASK FORCE" author line. |
| report_05_controls | 69 | 54 | 0 | 15 | 0 | 0.7222 | Boilerplate emitted; running header (with underscore rule) typed "equation" and "PAGE i"/"i" page numbers typed footnote. |

Drop categories (all fixtures): cover "This publication is available free of charge from:" + DOI URL (both cover pages and the Authority page), cover department/agency signature block, running headers, vertical margin stamp ("This publication is available free of charge from: https://doi.org/..."), page numbers. Kept: series line, title, subtitle, authors, affiliations, date, "JOINT TASK FORCE", the report_05 "INCLUDES UPDATES..." line, all Authority/ITL/Abstract/Keywords body text, comment-submission address lines (not email-only).

Not changed (rule: keep draft sentence boundaries): ", Public Law (P.L.) 113-283." split from the previous sentence at "et seq." and "Natl." / "Inst." / "Stand." / "Technol." / "Spec." / "Publ." split into one-word segments — sentence-splitter errors, not order errors.
