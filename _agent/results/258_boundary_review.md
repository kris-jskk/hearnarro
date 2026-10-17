# 258 Sentence-boundary truth: candidate review (task m2-sentence-boundary-truth)

Source: `<stem>.expected.jsonl` prose segments (`prose_only`, D12 types), one segment per line, then a scripted candidate pass, then a review of every candidate against the text. Script: scratchpad `sb/cand.py`; decisions (rejects with reasons): scratchpad `sb/decisions.json`. Candidate IDs are content hashes of the 70-char contexts either side.

## Rules

Merge the line into the previous one when (first match wins):
- `abbrev`: the previous line's last token (leading `(`/quote stripped, lowercased) is in the list below, or is a single letter + dot;
- `closer`: the line starts with a closing bracket or quote;
- `lowercase`: the line starts with a lowercase letter;
- `open-bracket`: the previous line has more `(` than `)` and does not end in `. ! ? :` (square brackets ignored: `[0, 1)` intervals);
- `section-number`: the previous line is only a section number such as `2.1.` (added after a residual scan showed academic_01 headings split as `2.1.` | `Experimental Design`).

Split a line at `. ` / `! ` / `? ` (optionally followed by a closing bracket/quote) before a capital when:
- `split`: both halves have >= 4 words, the dot does not follow a listed abbreviation or a single capital letter;
- `letter-split`: the dot follows a one-letter maths variable (`kernel P. Its`), both halves >= 4 words, not inside a run of initials (`J. Zhou, T. Lu`), `et al` or a `[n]` reference (added because the `split` rule excludes single capitals, which is where the M1-noted `...r Z. Under...` sits).

Abbreviation list: "et seq.", "seq.", "natl.", "inst.", "stand.", "technol.", "spec.", "publ.", "eq.", "eqs.",      "fig.", "figs.", "vs.", "e.g.", "i.e.", "no.", "nos.", "cf.", "al.", "dr.", "mr.", "ms.",      "sec.", "ref.", "refs.", "vol.", "pp.", "p.", "ch.", "approx.", "resp.", "tab.", "dept.",      "corp.", "inc.", "ltd.", "u.s.", "jr.", "st.", "rev.", "ed.", "eds.", "co.", "app.", "thm.",      "def.", "prop.", "lem.", "cor.", "sect.", "art.", "par.", "viz.", "etc.", "est.", "min.", "max."

## Per fixture

| fixture | candidates | accepted | rejected |
|---|---|---|---|
| academic_01_seahelm_audio | 18 | 18 | 0 |
| academic_02_memduet | 7 | 6 | 1 |
| academic_03_pruned_reasoning | 6 | 1 | 5 |
| academic_04_legislative_xml | 2 | 2 | 0 |
| academic_05_sparse_autoencoders | 4 | 1 | 3 |
| tables_01_pfn_bayes | 20 | 18 | 2 |
| tables_02_non_gaussian_sem | 5 | 4 | 1 |
| tables_03_copula_subspaces | 18 | 13 | 5 |
| tables_04_markov_kernel | 16 | 15 | 1 |
| tables_05_decomposing_learner | 6 | 3 | 3 |
| report_01_zero_trust | 8 | 7 | 1 |
| report_02_patch_mgmt | 8 | 7 | 1 |
| report_03_ssdf | 8 | 7 | 1 |
| report_04_rmf | 8 | 7 | 1 |
| report_05_controls | 7 | 7 | 0 |
| **total** | 141 | 116 | 25 |

By rule: abbrev 57, letter-split 13, lowercase 52, open-bracket 2, section-number 16, split 1

## Every candidate

Context is the 70 characters either side of the boundary; `||` marks the line break after the change (merge: the break removed; split: the break added).

### academic_01_seahelm_audio

- `Mb3ab5fa9` section-number: accept. `…2.1. || Experimental Design…`
- `Me953af38` section-number: accept. `…2.2. || Datasets and Task Selection…`
- `M1219f4f8` section-number: accept. `…2.2.1. || Benchmark Alignment and Active Subset Scope…`
- `M28237512` section-number: accept. `…2.3. || Evaluation Metrics…`
- `M8e3795bb` section-number: accept. `…3.1. || Evaluation Flow…`
- `Md07beebd` section-number: accept. `…3.2. || Spoken Prompt Construction…`
- `M2f1abf37` section-number: accept. `…3.3. || Speech Recognition…`
- `Mbf1be7ff` section-number: accept. `…3.4. || Response Generation…`
- `Mbf667caf` section-number: accept. `…3.5. || Scoring…`
- `Mbab58813` section-number: accept. `…4.1. || Multiple Choice Reasoning (Global-MMLU-Lite)…`
- `M33081c0f` section-number: accept. `…4.2. || Instruction Following (SEA-HELM IFEval)…`
- `M3fb1a60b` section-number: accept. `…5.1. || Linguistic Resilience vs. Vulnerability…`
- `Mc0579810` section-number: accept. `…5.2. || Task Format Sensitivity: MCQ vs. Instruction Following…`
- `M394821c9` section-number: accept. `…5.3. || Commercial vs. Open-Weight…`
- `Mc698ddb9` lowercase: accept. `…[4] J. Zhou, T. Lu, S. Mishra, S. Brahma, S. Basu, Y. Luan, D. Zhou, || and L. Hou, “Instruction-following evaluation for large language model…`
- `M8913588f` abbrev:w.: accept. `…K. Marchisio, W. Q. Leong, Y. Susanto, R. Ng, S. Longpre, S. Ruder, W. || -Y.…`
- `M5cd6ba15` lowercase: accept. `…6] A. Zou, Z. Wang, N. Carlini, M. Nasr, J. Z. Kolter, and M. Fredrik- || son, “Universal and transferable adversarial attacks on aligned langua…`
- `M25287f46` abbrev:q.: accept. `…[9] R. Ng, T. N. Nguyen, Y. Huang, N. C. Tai, W. Y. Leong, W. Q. || Leong, X. Yong, J. G. Ngui, Y. Susanto, N. Cheng et al., “SEA- LION: S…`

### academic_02_memduet

- `Mbf6e15e0` open-bracket: accept. `…A small language model (System || 1) scans raw context in parallel to select candidate chunks for memory…`
- `Mcd6b5d36` open-bracket: accept. `…A large language model (System || 2) verifies whether each selected chunk warrants a memory update under…`
- `M31047fda` lowercase: accept. `…The chunks predicted as Update form the candidate set || which is forwarded to System 2.…`
- `M7217b58f` lowercase: accept. `… accepted chunk in document order and generate its replacement memory: || where i⋆ t = min{i ∈It | ξt,i ≤αt,i}.…`
- `M84d09905` abbrev:c.: **reject** — true sentence end: 'evidence from c.' is a maths variable, next sentence starts 'We retain'. `…, c, m), let m′ be the memory after incorporating the evidence from c. || We retain the original example and add a postupdate negative:…`
- `M517a6592` lowercase: accept. `…We train on the original examples and post-update || negatives using the memory-contrastive objective:…`
- `Sf6762f89` letter-split: accept. `…We consider query-conditioned reasoning over a long document D. || Given a query q, the goal is to generate an answer y using evidence fr…`

### academic_03_pruned_reasoning

- `M1aa450a9` abbrev:b.: **reject** — true sentence end at 'Appendix B.'; next is a run-in heading. `… al., 2025; Xiang et al., 2025), detailed preliminaries in Appendix B. || Related Works.…`
- `M9d2dd2dc` abbrev:c.: **reject** — true sentence end at 'Appendix C.'; next is a section heading. `… correct only if it commits to a final answer, detailed in Appendix C. || 3.1 Do Pruned Models Lose the Ability to Reason?…`
- `Mcb93fa62` lowercase: **reject** — caption sentence ends; next caption sentence starts with the variable 'n'. `…ining the gold answer and the median position of its first occurrence. || n denotes the number of non-terminating samples.…`
- `M8c394d75` lowercase: **reject** — caption sentence ends; next caption sentence starts with the variable 'n:'. `…en cyclic and progressive continuations at decision points on AIME-25. || n: number of decision points; Entropy: predictive entropy at the decis…`
- `M13e1d9da` lowercase: accept. `…decision points that are followed by a PROGRESS paragraph, and define: || where a larger ∆cyc indicates a stronger relative preference for CYCLI…`
- `S4b9b5175` letter-split: **reject** — author line: 'Nguyen T. Ha' is a name initial, not a sentence end. `…Minh-Anh Nguyen1 Nguyen T. || Ha Lan2 Xiyan Fu1 Dung D. Le2 Wei Lu1…`

### academic_04_legislative_xml

- `M4943b3a5` lowercase: accept. `…We measure it instead as one dimension of a full || pipeline, split into localization and normalization (§5).…`
- `M183238e2` lowercase: accept. `…We use that term for three coupled changes T3 || introduces together: decomposition into specialized agents, the persis…`

### academic_05_sparse_autoencoders

- `Mac83543d` lowercase: accept. `…RQ1: Which design assumptions change what an SAE || can recover?…`
- `M6a7682bb` abbrev:a.: **reject** — true sentence end at 'Appendix A.'. `…Corpus selection and coding are detailed in Appendix A. || Three facets and their qualifiers.…`
- `M6fa8c3a0` abbrev:b.: **reject** — true sentence end at 'Appendix B.'; next is a heading. `…ssignments, and cross-dimensional analyses are provided in Appendix B. || 3 Dictionary Design and Recoverability…`
- `M6e5e49da` abbrev:c.: **reject** — true sentence end at 'Appendix C.'; next is a heading. `…Technical comparisons and assumptions are detailed in Appendix C. || 4 From Features to Explanations and Mechanisms…`

### tables_01_pfn_bayes

- `M02bba3b3` lowercase: accept. `…This paper studies the amortization error, || the only term controlled by pretraining, which splits into optimizatio…`
- `M85f4d6dd` abbrev:(eq.: accept. `…ich splits into optimization, estimation, and approximation error (Eq. || (8)).…`
- `M9968dbb3` lowercase: accept. `…Whether this holds is a question about amortization || uncertainty.…`
- `M60371e64` lowercase: accept. `…ainty in PFNs (Nagler and Rügamer, 2025; Fortini et al., 2026) studies || the uncertainty that remains for a fixed network at inference time and…`
- `M1a85f88e` lowercase: accept. `…Then for every predictor q, || with equality if and only if q = πΠ′ almost surely under Π′.…`
- `M987d08d4` abbrev:eq.: accept. `…In practice, Eq. || (4) is approximated by empirical risk minimization over M datasets D(j…`
- `M05a71ff4` lowercase: accept. `…M datasets D(j) whose task and size (pj, nj) are drawn from the prior, || optimized with first-order stochastic gradient methods such that, in g…`
- `Mee044696` abbrev:c.: **reject** — true sentence end at 'Appendix C.'. `…Details are given in Appendix C. || While this approach is sufficient to study the general…`
- `M06864f3a` lowercase: accept. `…While this approach is sufficient to study the general || capabilities of transformers to approximate the PPD and measure quanti…`
- `M7e2c9ab8` lowercase: accept. `…The following studies these problems || in more detail.…`
- `M58c9904d` lowercase: accept. `…risk minimization, the amortization error splits into three components || where ˜θM minimizes the empirical risk for M training samples and θ∗= …`
- `M29470ca3` lowercase: accept. `…seed and training data, at several scales M1 < · · · < ML, and compute || where θref is a reference checkpoint with Mref ≫ML.…`
- `Mda5681bf` lowercase: accept. `… p on Y and predictors q1, . . . , qK with mixture ¯q = 1 K PK k=1 qk, || where ∆p := Ey∼p  log ¯q(y) −1 PK k=1 log qk(y)  ≥0, with equality i…`
- `M8a35be9a` lowercase: accept. `…∆p is the averaging gain, i.e., the amount by which the || mixture improves on its average member in expected log loss under p.…`
- `M0a26d0bc` abbrev:p.: **reject** — true sentence end at 'under p.' (variable). `…e mixture improves on its average member in expected log loss under p. || Applied with p = πΠ, Lemma 1 splits the amortization error itself:…`
- `Mf1d55235` abbrev:eq.: accept. `…Revisiting Eq. || (8), if the estimation error vanishes at the expected rate while disag…`
- `M16793e56` lowercase: accept. `…The next result makes its cost || explicit and reconciles in what sense model averaging can be beneficia…`
- `Mda80c240` lowercase: accept. `…loyment pairs (p, n) relative to the prior, the Lebesgue decomposition || splits the deployment distribution uniquely into a part the prior can …`
- `Mcd038afb` lowercase: accept. `…iquely into a part the prior can express ˜Π, and a part Π′ ⊥it cannot, || with density ˜rΠ = d˜Π/dΠ on the absolutely continuous part.…`
- `S44fb01b0` letter-split: accept. `…asurable map qθ : (x, Dn) 7→qθ(· | x, Dn) into the distributions on Y. || Deployed on Π′, its risk under the log loss is…`

### tables_02_non_gaussian_sem

- `Mb6408864` lowercase: accept. `…uctural equation model (SEM) as a collection of equations of the form: || where PA(i) ⊂{1, . . . , d} \ {i} indexes the parents of Xi, and Ni is…`
- `Maa736552` lowercase: accept. `…h variable is a linear function of its parents plus independent noise: || where Λ ∈Rd×d encodes the linear dependence of each variable on its pa…`
- `Mbb69aa02` abbrev:x.: **reject** — true sentence end at 'samples of X.'; next is a heading. `…s to recover G (equivalently, the support of Λ) from the samples of X. || 4 GENERALIZED ORDERING-BASED LEARNING VIA CONDITIONAL RISKS…`
- `Mff51d052` lowercase: accept. `…For every i ∈[d], || so that Varlin(Xi | X−i) = σ2 if i is a sink and Varlin(Xi | X−i) ≤σ2/…`
- `S289d70e8` letter-split: accept. `…For proofs, see Appendix A. || This fact uses just two properties of the variance functional:…`

### tables_03_copula_subspaces

- `Md1dbf8c3` lowercase: **reject** — 'Key words.' is a label line; the keyword list is its own unit (same as reports' 'Keywords' heading). `…Key words. || copula, active subspace, score matching, dimension reduction, Hermite …`
- `M59cb7788` lowercase: accept. `…We therefore consider the error || of the Cas estimate bπn, estimating its individual contributions from …`
- `M20c114e2` abbrev:d.: **reject** — true sentence end at 'dimension d.'. `… of (1.1) would involve the differential entropy of πn in dimension d. || For densities supported on [0, 1]d in Lipschitz balls of smoothness s …`
- `Md67d91b3` abbrev:r.: **reject** — true sentence end at 'dimensions 1 and r.'. `…ition reduces the required entropy calculations to dimensions 1 and r. || No entropy estimate is needed for the bound on Eproj.…`
- `M82abb0f7` abbrev:z.: **reject** — true sentence end at 'basis of Z.'. `…script distinguishes this basis from a principal-component basis of Z. || A basis Vr ∈St(r, Rd) and its orthonormal completion V⊥separate the re…`
- `Mb22f25e8` lowercase: accept. `…Thus the joint estimate (3.1) takes the form || with copula factor bcZ(z) := bcU r ( bV C⊤ r z).…`
- `Mef94d338` lowercase: accept. `…ow is finite and, for each realization of the estimation sample, (2.1) || where RN := Eπn[log bcZ(Z)]−Eπn[log bcZ( b Z)] is the difference betwe…`
- `M72606216` section-number: accept. `…3.1. || The marginals.…`
- `M86b1d197` lowercase: accept. `…a fixed dictionary of degree K2 we assume the moment bounds (T), (3.1) || where the outer expectation is over the estimation sample and the inne…`
- `M7d3e95cd` lowercase: accept. `…Combining this with (M) gives || and Emarg −log bZcomp = Op( √ d (log N)K2/2N −1/2).…`
- `M3baa3e7b` section-number: accept. `…3.2. || The subspace.…`
- `M8e6f96ba` lowercase: accept. `… at this projector separates the rank and suboptimality contributions: || where the rank term is fixed by C and r.…`
- `M4972f9a0` abbrev:r.: **reject** — true sentence end at 'C and r.'. `… suboptimality contributions: where the rank term is fixed by C and r. || The remaining term ∆subopt is of order ∥sin Θ( bV C r , V C r )∥2 F .…`
- `Sb66678dd` letter-split: accept. `…on 3 depend on the rank r, the multi-index sets and the sample size N. || Normalizing the fitted joint density introduces a correction in the ma…`
- `S80c35409` letter-split: accept. `…Replacing Fi by the rank-based bFi of Part I defines b Z. || The marginal densities are estimated separately by Gaussian-kernel est…`
- `Se6527cce` letter-split: accept. `…Let bπn be the estimator above, with U := bV C⊤ r Z. || Under Assumption 2.1 of Part I and the integrability condition of (M),…`
- `S6771a9c2` letter-split: accept. `…mposition at the estimated basis bV C r , without the eigenbasis of C. || Neither RN nor log bZcomp has a prescribed sign, so Emarg can be negat…`
- `Safb46e84` letter-split: accept. `…son, let P C r := V C r V C⊤ r project onto the top-r eigenspace of C. || Subtracting and adding the trace at this projector separates the rank …`

### tables_04_markov_kernel

- `M46ba9549` lowercase: accept. `…common law π, the empirical law of large numbers gives, almost surely, || for every bounded continuous test function f. For general Markov chain…`
- `M772c8281` lowercase: accept. `…cal conditions ensuring almost-sure convergence of bµT as in (2), see, || e.g.…`
- `Mdf836bf6` abbrev:e.g.: accept. `…onditions ensuring almost-sure convergence of bµT as in (2), see, e.g. || , Meyn and Tweedie (2012).…`
- `M08b00186` lowercase: accept. `…flexible framework is provided by integral probability metrics (IPMs), || dF(µ, ν) := sup where F is a class of measurable test functions integr…`
- `M51920b1c` lowercase: accept. `…Taking F to be the unit ball of H in (3), Hilbert-space duality gives || whenever the two Bochner integrals exist; see, e.g., Smola et al. (200…`
- `M60318350` lowercase: accept. `…0, and satisfies the following uniform geometric relaxation condition: || for some C < ∞and θ ∈[0, 1).…`
- `Mf6d8880c` lowercase: accept. `…l ridge regression (KRR) for learning the one-step prediction function || of a real-valued Markov chain from a single trajectory.…`
- `Ma18c5532` lowercase: accept. `…and empirical covariance operators, and denoting Σλ := Σ + λI, we have || where Φλ(x) := Σ−1/2 λ λ [ϕ(x) ⊗ϕ(x)]Σ−1/2 λ .…`
- `M38d4b8a4` lowercase: accept. `…Recall that for a fixed T > 0, || denotes empirical occupation measure.…`
- `M6aeb28de` lowercase: accept. `…Its predictable quadratic variation is || where Ej[·] := E[· | Fj].…`
- `Medf402d4` lowercase: accept. `…In particular, for the class || the corresponding IPM is the total variation distance:…`
- `S03c6265b` letter-split: accept. `…Let (Xt)t≥0 be a Markov chain on X with transition kernel P. || Its empirical occupation measure up to time T is…`
- `Sbc03c3e9` letter-split: accept. `…rs gives, almost surely, for every bounded continuous test function f. || For general Markov chains, however, convergence to a deterministic lim…`
- `S4d938166` letter-split: accept. `…ble choices of F, with explicit dependence on the trajectory length T. || Such bounds are useful in sampling, where they quantify the error incu…`
- `Sbe7ca5a0` split: **reject** — 'i.i.d.' is an abbreviation; the sentence continues 'KRR (Caponnetto ...)'. `…The rate matches the classical source–capacity exponent for i.i.d. || KRR (Caponnetto and De Vito, 2007), with explicit dependence on the ch…`
- `S44fe33bc` letter-split: accept. `…Let F be a class of measurable real-valued functions on X. || For µ, ν ∈P(X) such that the integrals below are well defined, the int…`

### tables_05_decomposing_learner

- `M85e6f2b9` abbrev:f.: **reject** — true sentence end at 'function f.'; next is a figure sub-caption. `…er can be viewed as learning to approximate the underlying function f. || (a) Heterogeneous feature space…`
- `M8aab2afa` abbrev:x.: **reject** — true sentence end at 'function of x.'. `…as w(x) = p(z = 1 | x), which is assumed to be a smooth function of x. || By interpreting z as an indicator of predictability, the conditional d…`
- `Mfae8adf7` lowercase: accept. `…predictability, the conditional distribution of y can be decomposed as || where prand(y) := p(y | x, z = 0), since y is independent of x when z …`
- `M35a5186a` abbrev:y.: **reject** — true sentence end at 'distribution of y.'. `…ion of the predictable component within the overall distribution of y. || Although assigning different weights to instances during training is c…`
- `M0418af41` lowercase: accept. `…r, we further model these conditional distributions as Gaussian, i.e., || where f, µ0, σ2 0 and σ2 1 are unknown functions and parameters.…`
- `M416c0e1c` lowercase: accept. `…(y)1−z, (3) hence, the joint log-density of y and z can be obtained as || which is naturally decomposed into three components corresponding to t…`

### report_01_zero_trust

- `Mf4d27225` abbrev:seq.: accept. `…n Security Modernization Act (FISMA) of 2014, 44 U.S.C. § 3551 et seq. || , Public Law (P.L.) 113-283.…`
- `M15c90443` abbrev:natl.: accept. `…Natl. || Inst.…`
- `Md11b1731` abbrev:inst.: accept. `…Natl. Inst. || Stand.…`
- `M03c5b1b4` abbrev:stand.: accept. `…Natl. Inst. Stand. || Technol.…`
- `M768cc127` abbrev:technol.: accept. `…Natl. Inst. Stand. Technol. || Spec.…`
- `M5ed338aa` abbrev:spec.: accept. `…Natl. Inst. Stand. Technol. Spec. || Publ.…`
- `Mc66a87a9` abbrev:publ.: accept. `…Natl. Inst. Stand. Technol. Spec. Publ. || 800-207, 59 pages (August 2020)…`
- `Me231e77c` lowercase: **reject** — 'Keywords' is a heading; the keyword list is its own unit. `…Keywords || architecture; cybersecurity; enterprise; network security; zero trust.…`

### report_02_patch_mgmt

- `Mf4d27225` abbrev:seq.: accept. `…n Security Modernization Act (FISMA) of 2014, 44 U.S.C. § 3551 et seq. || , Public Law (P.L.) 113-283.…`
- `M15c90443` abbrev:natl.: accept. `…Natl. || Inst.…`
- `Md11b1731` abbrev:inst.: accept. `…Natl. Inst. || Stand.…`
- `M03c5b1b4` abbrev:stand.: accept. `…Natl. Inst. Stand. || Technol.…`
- `M768cc127` abbrev:technol.: accept. `…Natl. Inst. Stand. Technol. || Spec.…`
- `M5ed338aa` abbrev:spec.: accept. `…Natl. Inst. Stand. Technol. Spec. || Publ.…`
- `M9bf3e06d` abbrev:publ.: accept. `…Natl. Inst. Stand. Technol. Spec. Publ. || 800-40r4, 28 pages (April 2022)…`
- `M5dc5286c` lowercase: **reject** — 'Keywords' is a heading; the keyword list is its own unit. `…Keywords || enterprise patch management; patch; risk management; update; upgrade; …`

### report_03_ssdf

- `Mf4d27225` abbrev:seq.: accept. `…n Security Modernization Act (FISMA) of 2014, 44 U.S.C. § 3551 et seq. || , Public Law (P.L.) 113-283.…`
- `M15c90443` abbrev:natl.: accept. `…Natl. || Inst.…`
- `Md11b1731` abbrev:inst.: accept. `…Natl. Inst. || Stand.…`
- `M03c5b1b4` abbrev:stand.: accept. `…Natl. Inst. Stand. || Technol.…`
- `M768cc127` abbrev:technol.: accept. `…Natl. Inst. Stand. Technol. || Spec.…`
- `M5ed338aa` abbrev:spec.: accept. `…Natl. Inst. Stand. Technol. Spec. || Publ.…`
- `Me6e63a1c` abbrev:publ.: accept. `…Natl. Inst. Stand. Technol. Spec. Publ. || 800-218, 36 pages (February 2022)…`
- `M5f3e84b2` lowercase: **reject** — 'Keywords' is a heading; the keyword list is its own unit. `…Keywords || secure software development; Secure Software Development Framework (SS…`

### report_04_rmf

- `M31aa2b0f` abbrev:seq.: accept. `…formation Security Modernization Act (FISMA), 44 U.S.C. § 3551 et seq. || , Public Law (P.L.) 113-283.…`
- `M15c90443` abbrev:natl.: accept. `…Natl. || Inst.…`
- `Md11b1731` abbrev:inst.: accept. `…Natl. Inst. || Stand.…`
- `M03c5b1b4` abbrev:stand.: accept. `…Natl. Inst. Stand. || Technol.…`
- `M768cc127` abbrev:technol.: accept. `…Natl. Inst. Stand. Technol. || Spec.…`
- `M5ed338aa` abbrev:spec.: accept. `…Natl. Inst. Stand. Technol. Spec. || Publ.…`
- `M9657f0cb` abbrev:publ.: accept. `…Natl. Inst. Stand. Technol. Spec. Publ. || 800-37, Rev. 2, 183 pages (December 2018)…`
- `M4b81729d` lowercase: **reject** — 'Keywords' is a heading; the keyword list is its own unit. `…Keywords || assess; authorization to operate; authorization to use; authorizing of…`

### report_05_controls

- `M31aa2b0f` abbrev:seq.: accept. `…formation Security Modernization Act (FISMA), 44 U.S.C. § 3551 et seq. || , Public Law (P.L.) 113-283.…`
- `M15c90443` abbrev:natl.: accept. `…Natl. || Inst.…`
- `Md11b1731` abbrev:inst.: accept. `…Natl. Inst. || Stand.…`
- `M03c5b1b4` abbrev:stand.: accept. `…Natl. Inst. Stand. || Technol.…`
- `M768cc127` abbrev:technol.: accept. `…Natl. Inst. Stand. Technol. || Spec.…`
- `M5ed338aa` abbrev:spec.: accept. `…Natl. Inst. Stand. Technol. Spec. || Publ.…`
- `Me8ef7e58` abbrev:publ.: accept. `…Natl. Inst. Stand. Technol. Spec. Publ. || 800-53, Rev. 5, 492 pages (September 2020)…`

## Residual scan after the pass

Lines that still end in a listed abbreviation, start lowercase or with a closer, or are one word long were listed; the remaining one-word lines are headings (`Abstract`, `Keywords`, `Authority`, `Setting.`, `Definition.`) and the remaining lowercase starts are the two academic_03 caption sentences that begin with the variable `n` and the five keyword lists after a `Keywords`/`Key words.` label (all rejected merges above). No `vs.`/`e.g.`/`Fig.` line ends remain.
