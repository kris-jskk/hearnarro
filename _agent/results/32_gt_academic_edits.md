# Ground-truth edit tally, academic fixtures (ING-4, D11)

Counts come from the edit scripts in the scratchpad (gtlib.py + edit_0N.py); moved = kept lines minus the longest run already in draft order; joined = fragments merged into another line; trimmed = email text removed from an otherwise kept line, or a misattached fragment moved to its sentence.

| fixture | draft | final | moved | dropped | joined | trimmed | dropped draft idx | main parser error |
|---|---|---|---|---|---|---|---|---|
| academic_01_seahelm_audio | 221 | 217 | 18 | 1 | 3 | 1 | [5] | Order: on page 1 the parser read the right column's top block (end of Introduction, Section 2 opening) before the left column's Introduction, so 'na-/tively' was split across the abstract; on page 3 cells of Tables 3 and 4 were interleaved across the two tables and Table 4 cut a body sentence in two. |
| academic_02_memduet | 279 | 273 | 40 | 1 | 5 | 3 | [4] | Order + merge: right-column text around full-width and column figures (pages 1, 3, 4) was emitted out of column order, and one merge glued the page-3 fragment 'ev' to the page-4 continuation of a different sentence ('evto select candidate chunks'). |
| academic_03_pruned_reasoning | 230 | 223 | 3 | 1 | 6 | 0 | [3] | Merge: order is almost right; the errors are sentences cut at column and page breaks (5 cross-break fragments) plus the affiliation line emitted after the abstract. |
| academic_04_legislative_xml | 128 | 121 | 0 | 3 | 4 | 1 | [11, 59, 60] | Merge: order is correct; sentences continuing across a column break or past Table 1 are left as two fragments, and an affiliation keeps its email. |
| academic_05_sparse_autoencoders | 158 | 152 | 3 | 2 | 4 | 1 | [10, 32] | Merge: order is correct apart from Figure 1 box labels; three sentences split at column breaks were not joined. |
