# 195 Diagnosis: paragraphs split at line ends (The Almanack of Naval Ravikant, 242 pp)

Evidence: `195_blocks_pages_118_119.txt` (stage-1 blocks + per-line x0/y0/y1 after classify,
pages 118-119 = the former segment orders 1795-1830), `195_join_rates.txt` (candidate same-page
joins per document), `199_book_after.txt` (before/after counts, same counting script).

## Which rule opened the blocks
- The PDF is untagged (0 of 1419 chars on page 118 carry an MCID) and was set in InDesign
  with optical margin alignment: line starts jitter between x0 = 62.3 and 63.4 pt (a line
  beginning with T, W, Y, "(" protrudes ~0.5-0.9 pt into the margin).
- Stage 1 `group_blocks`: the untagged small-indent rule (round 3, `INDENT_NEW_BLOCK` = 0.5 pt <
  move <= `UNTAGGED_INDENT_MAX` = 2 pt) opens a new block whenever a line starts 0.5-2 pt right
  of the previous one. Example p.118: block [8] ends with the line at x0=62.6 "They started out
  reading ... things,"; the next line at x0=63.3 "and those formed ..." opens block [9]. Same
  for "con-" (62.5) / "fusion" (63.3), "very," (62.5) / "very high quality." (63.0), "(you may
  not" (62.6) / "love this answer)" (63.2). The vertical gap is the normal 5 pt line gap; real
  paragraph breaks here have a 20 pt gap.
- The tagged-PDF, centred-line and reference-entry openers are not involved.

## Why merge_blocks did not rejoin them
- Both blocks are `body`, consecutive, nothing between them. `merge_blocks` only joins body
  text across a *flow break* (`_is_flow_break`: next page, or the next block starts above the
  previous one, i.e. a column break). Same-page, same-column consecutive blocks were never
  candidates, by design (`test_ing5_merge_blocks_does_not_join_within_a_column`).

## Count of the pattern (consecutive body segments, A ends without [.!?:;"”’)], B starts
lowercase or bracket/quote + lowercase), whole book
- before: 354 (337 on the same page) of 4134 segments
- after: 19 (all on page 2, the off-page back-cover blurb, see report) of 3747 segments

## What was changed (and what was not)
- Grouper NOT changed: the small-indent rule is round-3 golden tuning and its unit test
  (`test_ing4_untagged_small_indent_opens_block`) encodes exactly this split ("...a question" /
  "uncertainty. ..."); the golden ground truth contains such splits. Geometry cannot tell the
  book's optical-margin jitter from LaTeX microtype protrusion.
- merge_blocks gains a same-page paragraph join (A directly before B, B within 1 font size
  below A, A ends with a line-end hyphen or without terminal punctuation, B starts lowercase or
  with an opening bracket/quote then lowercase). Applied to every document it changed the
  golden (sentence means 0.9203 -> 0.9105; 16 joins across 7 fixtures, e.g. pfn_bayes 8 joins),
  so it is gated per document: on only when >= 10 candidate pairs and >= 15% of body blocks
  (book 350 pairs / 1498 body blocks = 0.234; max golden 8 / 62 = 0.129; IoT 1 / 135).
