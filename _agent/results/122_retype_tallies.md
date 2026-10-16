# Retype tallies (HEAD vs working tree), 15 text fixtures

| fixture | before (type counts) | after (type counts) | ->equation | ->table | table/equation->body | other changes | excluded before -> after |
|---|---|---|---|---|---|---|---|
| academic_01_seahelm_audio | {'body': 157, 'heading': 50, 'list': 10} | {'body': 121, 'heading': 45, 'list': 10, 'table': 41} | 0 | 41 | 0 | 0 | 0 -> 41 |
| academic_02_memduet | {'body': 97, 'caption': 9, 'equation': 13, 'footnote': 2, 'heading': 13, 'list': 4} | {'body': 84, 'caption': 9, 'equation': 26, 'footnote': 2, 'heading': 13, 'list': 4} | 13 | 0 | 0 | 0 | 13 -> 26 |
| academic_03_pruned_reasoning | {'body': 120, 'caption': 4, 'equation': 5, 'footnote': 4, 'heading': 11} | {'body': 100, 'caption': 4, 'equation': 16, 'footnote': 1, 'heading': 7, 'table': 16} | 11 | 16 | 0 | 0 | 5 -> 32 |
| academic_04_legislative_xml | {'body': 108, 'caption': 2, 'footnote': 3, 'heading': 8} | {'body': 105, 'caption': 2, 'footnote': 3, 'heading': 8, 'table': 3} | 0 | 3 | 0 | 0 | 0 -> 3 |
| academic_05_sparse_autoencoders | {'body': 123, 'caption': 3, 'equation': 3, 'heading': 14, 'table': 2} | {'body': 121, 'caption': 3, 'equation': 5, 'heading': 14, 'table': 2} | 2 | 0 | 0 | 0 | 5 -> 7 |
| report_01_zero_trust | {'body': 38, 'heading': 18} | {'body': 38, 'heading': 18} | 0 | 0 | 0 | 0 | 0 -> 0 |
| report_02_patch_mgmt | {'body': 41, 'heading': 22} | {'body': 41, 'heading': 22} | 0 | 0 | 0 | 0 | 0 -> 0 |
| report_03_ssdf | {'body': 37, 'heading': 19} | {'body': 37, 'heading': 19} | 0 | 0 | 0 | 0 | 0 -> 0 |
| report_04_rmf | {'body': 33, 'heading': 14} | {'body': 33, 'heading': 14} | 0 | 0 | 0 | 0 | 0 -> 0 |
| report_05_controls | {'body': 32, 'heading': 14} | {'body': 32, 'heading': 14} | 0 | 0 | 0 | 0 | 0 -> 0 |
| tables_01_pfn_bayes | {'body': 157, 'caption': 4, 'equation': 34, 'footnote': 3, 'heading': 14, 'list': 4} | {'body': 125, 'caption': 4, 'equation': 69, 'heading': 14, 'list': 4} | 35 | 0 | 0 | 0 | 34 -> 69 |
| tables_02_non_gaussian_sem | {'body': 117, 'caption': 3, 'equation': 15, 'heading': 14} | {'body': 111, 'caption': 3, 'equation': 21, 'heading': 14} | 6 | 0 | 0 | 0 | 15 -> 21 |
| tables_03_copula_subspaces | {'body': 131, 'equation': 45, 'footnote': 5, 'list': 12} | {'body': 110, 'equation': 66, 'footnote': 5, 'list': 12} | 21 | 0 | 0 | 0 | 45 -> 66 |
| tables_04_markov_kernel | {'body': 126, 'equation': 50, 'footnote': 2, 'heading': 5} | {'body': 100, 'equation': 78, 'heading': 5} | 28 | 0 | 0 | 0 | 50 -> 78 |
| tables_05_decomposing_learner | {'body': 83, 'caption': 5, 'equation': 14, 'heading': 9, 'list': 8} | {'body': 69, 'caption': 5, 'equation': 28, 'heading': 9, 'list': 8} | 14 | 0 | 0 | 0 | 14 -> 28 |
