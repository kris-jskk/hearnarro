# m1-gt-tables: edit tally per fixture (rules: _agent/specs/m1-ground-truth-rules.md)

Draft = `python -m hearnarro dump <pdf> --jsonl --no-ocr` (counts: 35_gt_tables_draft.txt).
Edits are reproducible from explicit plans in the scratchpad: tbl_gtlib.py + tbl_ed_0[1-5].py
(/private/tmp/claude-502/-Users-sowmyajonnalagadda-Documents-Projects-hearnarro/356b510a-3d2c-414f-9d2b-5b7933bf0436/scratchpad/).
Counts are printed by tbl_gtlib.apply (stats json per fixture in the same folder).
"moved" = segments outside the longest in-order subsequence of the final sequence (minimum number of moves);
"joined" = join operations (fragments merged in brackets); "hdr-strip" = joins where a running header the parser
had glued into a segment was removed via explicit text. Golden score from 36_gt_tables_golden.txt.

| fixture | draft | final | moved | dropped | joined (fragments) | hdr-strip | golden score | main parser error |
|---|---|---|---|---|---|---|---|---|
| tables_01_pfn_bayes (2-col) | 269 | 256 | 32 | 4 | 8 (17) | 0 | 0.6797 | order: right-column blocks on p1 (Proposition 1, eq 3-6 and their prose) are interleaved with left-column text, and the full-width Figure 2 on p2 splits a page-crossing sentence; equation (11) pieces were classified as footnotes at page end. |
| tables_02_non_gaussian_sem (2-col) | 179 | 173 | 9 | 3 | 3 (6) | 1 | 0.8497 | order: on p2 under the full-width figure the right column's first paragraph is read before the left column, and the p3 running header was merged into the last left-column segment; column-break sentences left split. |
| tables_03_copula_subspaces (1-col) | 245 | 225 | 2 | 3 | 7 (24) | 1 | 0.8800 | merge/order inside inline maths: superscript/subscript fragments of sentences land out of order (e.g. "E[P" ... "√" ... "= O("), and the p2 running header was glued into the last p1 sentence. |
| tables_04_markov_kernel (1-col) | 208 | 191 | 4 | 2 | 5 (20) | 0 | 0.8534 | order of inline-math fragments (e.g. "π :=", integral sign "R") detached from their sentence; eq (2)/(3) sub/superscripts typed as footnotes; sentences across page breaks split. |
| tables_05_decomposing_learner (1-col) | 123 | 120 | 1 | 3 | 0 (0) | 0 | 0.9583 | classify/order: arXiv stamp and "1 Introduction" heading emitted before the title; "Preprint." footer and author email kept. |

Dropped segments (all): arXiv margin stamps (5), running headers (01: 3, 02: 2, 03: 2), email-only/correspondence lines (04: 1, 05: 1), footer "Preprint." (05: 1).

Assumptions applied uniformly:
- Title kept as the draft split it (rule 1, "one segment each, as the draft splits them"), even when a title wraps over two segments.
- Draft sentence splits inside one column whose order is already right (e.g. "Eq." / "(8))." or "vs.") are kept; joins were made only for (a) sentences across a column or page break, (b) fragments separated by a wrong order, (c) a hyphen-broken word ("dur-"/"ing").
- A joined page/column-crossing sentence sits at its first fragment's position; a float (figure) between the fragments follows it.
- Equation-internal piece order is kept as extracted; only the block position is corrected.
- Figure-internal labels (figure text, typed body/heading/table) kept in place in draft order.

Format validation (run after freezing): every file parses, keys exactly order/page/type/text, order 0..N-1, no empty text:
tables_01 256 valid; tables_02 173 valid; tables_03 225 valid; tables_04 191 valid; tables_05 120 valid.
