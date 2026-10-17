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

## Review 2 — 2026-10-17, M3 phases 0–3 (ledger as of the 08:19 row; tally `_agent/results/454_m3_cost_tally.md`)

Figures (ledger lines quoted in the tally). Workers: 11 rows dated after the M2 close, $6.36 (M2 workers were
$19.58; M1 $27.71). Supervisor: one row at 07:38, $9.34 at a 215k final prompt, 38 calls; the session was
still running, so the final supervisor figure is written in at the M3 close (the hook regenerates it).
Project total at that point $160.85.

Mapping of the six unnamed rows (by time and call count against the task list; unverified): line 79 unit-red,
80 e2e-red with its two follow-ups (32 calls accumulated), 81 build-core, 82 build-ui, 84 first-audio with
its addendum, 85 docs.

The ten most expensive M3 tasks and what drove them:
1. docs (line 85, $1.42, 23 calls, 145k prompt): read every web/src file plus four docs; the biggest prompt of the milestone.
2. e2e-red + follow-ups (80, $1.23, 32 calls): three resumptions on one transcript; each resume re-reads the whole prefix.
3. build-ui (82, $1.09, 29 calls, 127k prompt): seven source files plus three gate runs with two fix cycles.
4. unit-red (79, $0.63): 9k output tokens, the test files.
5. build-core (81, $0.45). 6. first-audio + addendum (84, $0.44). 7. web-scaffold (78, $0.42). 8. prefetch-order (86, $0.34).
9. licence-npm (83, $0.15, Sonnet). 10. node-install (77, $0.11, Sonnet).

What the numbers say. Rule 8 worked: no task passed 33 calls, Sonnet tasks cost a tenth of Opus ones, and the
supervisor prefix stayed at about a quarter of the M2 session's. The milestone's worker spend is a third of M2's.

Actions for M4:
1. **Pointer briefs carry the slug.** The ledger keys a row by the first line of the prompt; "Your brief is the
   file ..." lost the slug on six rows and the milestone table undercounts M3 ($1.10 of $6.36). Every pointer
   prompt starts with `TASK <slug>` on its own line.
2. **Resume for small follow-ups only.** Resuming an agent costs its whole prefix again; a follow-up over ~10
   calls goes to a fresh Sonnet worker with a file pointer instead.
3. **Split the docs task.** Code map in one task (reads code), PRD/design sync in another (reads docs); hand the
   first the deviations list from the build reports so it does not rediscover them.
4. **Keep the measurement scripts committed and parameterised** (`HN_SPEEDS`, `HN_PER_SPEED`, `HN_WARM`,
   `HN_REQLOG` exist now); an A/B measures the same segments, which needs a per-row cache purge option in M4.
