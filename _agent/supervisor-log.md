# Supervisor log
Corrections to things the session told the user: what was assumed, what was true, and what would have caught it earlier. Append-only.

| Date | What the session said | What was true | What would have caught it earlier |
|---|---|---|---|
| 2026-10-16 | The ground truth is consistent across the three reviewers under one rule set, so the golden gate measures parser order only (guide, section 2). | Reviewers differed on inline-math fragments: the tables reviewer joined in-order fragments in tables_03 ("with copula factor … r z)."), the academic reviewer kept them split; the ground-truth rules file had no explicit rule for math fragments. Round-2 tuning showed any inline-fragment rule helps one class and hurts the other (results 57–65). | An explicit rule for inline math and figure-internal text in `_agent/specs/m1-ground-truth-rules.md`, and a cross-class consistency pass (one reviewer re-reading two fixtures from another class) before freezing. |
