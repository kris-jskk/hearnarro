# Supervisor log
Corrections to things the session told the user: what was assumed, what was true, and what would have caught it earlier. Append-only.

| Date | What the session said | What was true | What would have caught it earlier |
|---|---|---|---|
| 2026-10-16 | The ground truth is consistent across the three reviewers under one rule set, so the golden gate measures parser order only (guide, section 2). | Reviewers differed on inline-math fragments: the tables reviewer joined in-order fragments in tables_03 ("with copula factor … r z)."), the academic reviewer kept them split; the ground-truth rules file had no explicit rule for math fragments. Round-2 tuning showed any inline-fragment rule helps one class and hurts the other (results 57–65). | An explicit rule for inline math and figure-internal text in `_agent/specs/m1-ground-truth-rules.md`, and a cross-class consistency pass (one reviewer re-reading two fixtures from another class) before freezing. |
| 2026-10-16 | "The truth is now frozen for good; every number from here is the parser moving" (guide, after commit db9425c). | The truth's segment boundaries, equation-piece granularity and intra-word spacing were drawn from PyMuPDF's block grouping. After the D13 extractor swap the golden penalizes grouping differences that change no reading order (one equation block vs several pieces; "PA (i)" vs "PA(i)"; sentence fragments at old block edges). Round 3 (results 130–145) spent part of its budget reproducing MuPDF splits. | A segmentation-independent comparison from the start (word-sequence edit distance over the ordered prose text, which is what a listener hears), or storing the truth as ordered text rather than segments. Being measured in result 146. |
| 2026-10-16 | Guide header box: "Score = 1 − edit distance between the parser's sentence sequence and the expected sequence" (still shown after D14). | Since D14 the gate is word-level over ordered prose with a char-mass guard, 15 fixtures scored; thresholds 0.95/0.97 unchanged. The user caught the stale sentence. | A checklist item in the phase-close routine: re-read the header gate box whenever a D-decision changes the test; or render the gate definition from one place in the page. |
| 2026-10-16 | "The 2.0x file is the same bytes as before, so the audio did not change; the most likely explanation is the player, not the file." | The audio was defective: at 2.0x the first word was 35 dB below its 1.0x level (result 348), because Kokoro divides the leading BOS token's duration by speed and renders its first ~300 ms near-silent; the first word fell inside that window. The user's first report was correct. | Measure before speculating: an onset/first-word energy check (now a model test, 345) would have shown it in one run; the file being byte-identical said nothing about whether it was right. |

## 2026-10-17 — M3 phase 3: first-audio attribution

Assumed (interim message to the user): the 0.5x cold waits of 6.0 s and 7.2 s in `_agent/results/445_first_audio_kokoro.txt`
were caused by the reader's parallel prefetch pushing the target behind two other sentences on the single
synthesis thread (a worker's correlation from the server log). Worded as "suggests", not as fact.
True: the ordering effect is real (`453_before_reqlog.txt`: three GETs in the same millisecond; `452`: prefetch
after the target) and the change is right by design, but a before-run on the old code gave 1.7 s at 0.5x with
the parallel GETs, so contention does not explain the 445 outliers; the first 0.5x row was also the server's
first synthesis after start (warm-up), and the A/B measured different segments (n=3 each), so it is indicative only.
Would have caught it earlier: a before/after on the same segments (cache purge per row) and a server warm-up
request before the first measurement, both written into the measurement brief.
