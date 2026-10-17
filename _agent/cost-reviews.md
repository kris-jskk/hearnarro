# Cost reviews (supervisor-owned; the ledger's review table is regenerated, this file is not)

## Review 1 — 2026-10-17, after M1 and M2 (ledger commit 5ad7e70)

Totals: project $141.10; supervisor session (Fable 5.1) $93.26 (66 %); workers $47.84 (34 %):
M1 $27.71 over 30 tasks, M2 $19.58 over 20 tasks. Old ledger numbers were ~2x inflated (usage
counted once per content line instead of once per message); fixed in the script.

Driver: cache re-reads of a growing prefix. The supervisor's prefix reached ~894k tokens; 322 tool
calls re-read it at $0.25/MTok (~$0.22 per call, 154.6M cache-read tokens, 41 % of its cost). The
longest worker tasks show the same shape (55–72 % of cost in cache reads).

Actions:
1. Start each milestone (M3 onward) in a fresh session. Handoff = CLAUDE.md, docs/guide/*, docs/CODE_MAP_*.md,
   the memory files, this file, the ledger. (Rule added to CLAUDE.md.)
2. Supervisor: one guide republish per phase, independent tool calls batched, no re-verification of a
   worker's saved evidence unless it is missing. Target: under 150 supervisor tool calls per milestone.
3. Worker budgets default 40, cap 50 unless the brief justifies more; the two tasks over 100 turns were
   the two most expensive worker tasks.
4. Sonnet for Opus tasks under ~15 calls (small: ~$0.45 so far).
Re-check at the M3 close: supervisor share, cost per worker task, and calls per milestone.
