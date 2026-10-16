# 82 inline-math joins (D12 rule 2)

Indices are 0-based line indices in the file after figure removal (80), before joins. Groups list pieces in reading order; joined text uses single spaces; the segment keeps the first piece's page/type and sits at the smallest index.

| fixture | joins | lines before -> after |
|---|---|---|
| academic_01_seahelm_audio | none needed (0) | 217 -> 217 |
| academic_02_memduet | 2 | 141 -> 138 |
| academic_03_pruned_reasoning | none needed (0) | 144 -> 144 |
| academic_04_legislative_xml | none needed (0) | 121 -> 121 |
| academic_05_sparse_autoencoders | none needed (0) | 145 -> 145 |
| report_01_zero_trust | none needed (0) | 56 -> 56 |
| report_02_patch_mgmt | none needed (0) | 63 -> 63 |
| report_03_ssdf | none needed (0) | 56 -> 56 |
| report_04_rmf | none needed (0) | 47 -> 47 |
| report_05_controls | none needed (0) | 46 -> 46 |
| tables_01_pfn_bayes | 8 | 232 -> 216 |
| tables_02_non_gaussian_sem | 7 | 162 -> 149 |
| tables_03_copula_subspaces | 18 | 225 -> 193 |
| tables_04_markov_kernel | 5 | 191 -> 183 |
| tables_05_decomposing_learner | 1 | 120 -> 119 |

## Join detail

### academic_02_memduet [77, 78, 79]
- before [77] body: "Under the memory prompt, πmem"
- before [78] body: "θ is the autoregressive product of System 2’s next-token policy πgen"
- before [79] body: "θ ."
- after [77] body: "Under the memory prompt, πmem θ is the autoregressive product of System 2’s next-token policy πgen θ ."

### academic_02_memduet [107, 108]
- before [107] body: "where i⋆"
- before [108] body: "t = min{i ∈It | ξt,i ≤αt,i}."
- after [107] body: "where i⋆ t = min{i ∈It | ξt,i ≤αt,i}."

### tables_01_pfn_bayes [49, 50]
- before [49] body: "Following Nagler (2023), a task is a law p over (X, Y ) ∈ X × Y with covariate law pX and conditional p(y | x), and a dataset Dn = {(Xi, Yi)}n"
- before [50] body: "i=1 consisting of n independent and identically distributed (iid) draws from it."
- after [49] body: "Following Nagler (2023), a task is a law p over (X, Y ) ∈ X × Y with covariate law pX and conditional p(y | x), and a dataset Dn = {(Xi, Yi)}n i=1 consisting of n independent and identically distributed (iid) draws from it."

### tables_01_pfn_bayes [57, 58]
- before [57] body: "At deployment, pairs follow a different distribution Π′"
- before [58] body: "with size marginal Ψ′."
- after [57] body: "At deployment, pairs follow a different distribution Π′ with size marginal Ψ′."

### tables_01_pfn_bayes [82, 83]
- before [82] body: "with equality if and only if q = πΠ′ almost surely under"
- before [83] body: "Π′."
- after [82] body: "with equality if and only if q = πΠ′ almost surely under Π′."

### tables_01_pfn_bayes [171, 174, 172, 173]
- before [171] body: "For any distribution p on Y and predictors q1, . . . , qK with mixture ¯q = 1"
- before [174] equation: "K"
- before [172] equation: "PK"
- before [173] equation: "k=1 qk,"
- after [171] body: "For any distribution p on Y and predictors q1, . . . , qK with mixture ¯q = 1 K PK k=1 qk,"

### tables_01_pfn_bayes [179, 181, 180, 178, 184, 182, 183]
- before [179] body: "where ∆p := Ey∼p"
- before [181] equation: "\u0002"
- before [180] body: "log ¯q(y) −1"
- before [178] equation: "PK"
- before [184] body: "k=1 log qk(y)"
- before [182] equation: "\u0003"
- before [183] body: "≥0, with equality if and only if all qk agree p-almost everywhere."
- after [178] body: "where ∆p := Ey∼p \u0002 log ¯q(y) −1 PK k=1 log qk(y) \u0003 ≥0, with equality if and only if all qk agree p-almost everywhere."

### tables_01_pfn_bayes [205, 206, 207]
- before [205] body: "It equals the log-loss gain 1 K"
- before [206] equation: "P"
- before [207] body: "k RΠ(qk) −RΠ(¯q) of the mixture over its average member, which can be estimated on datasets drawn from the prior, and it vanishes if and only if the members agree."
- after [205] body: "It equals the log-loss gain 1 K P k RΠ(qk) −RΠ(¯q) of the mixture over its average member, which can be estimated on datasets drawn from the prior, and it vanishes if and only if the members agree."

### tables_01_pfn_bayes [220, 221]
- before [220] body: "splits the deployment distribution uniquely into a part the prior can express ˜Π, and a part Π′"
- before [221] body: "⊥it cannot,"
- after [220] body: "splits the deployment distribution uniquely into a part the prior can express ˜Π, and a part Π′ ⊥it cannot,"

### tables_01_pfn_bayes [227, 228]
- before [227] body: "The singular part Π′"
- before [228] body: "⊥lives on pairs to which Π assigns probability zero, and no reweighting reaches it."
- after [227] body: "The singular part Π′ ⊥lives on pairs to which Π assigns probability zero, and no reweighting reaches it."

### tables_02_non_gaussian_sem [98, 99]
- before [98] body: "We consider a directed acyclic graph G = (V, E) with vertex set V = [d], where each vertex i is associated with a random variable Xi, and an edge set E ⊂V × V , where (j,"
- before [99] body: "i) ∈E denotes the directed edge j →i."
- after [98] body: "We consider a directed acyclic graph G = (V, E) with vertex set V = [d], where each vertex i is associated with a random variable Xi, and an edge set E ⊂V × V , where (j, i) ∈E denotes the directed edge j →i."

### tables_02_non_gaussian_sem [100, 101, 102, 103, 104]
- before [100] body: "For a vertex i, we write PA"
- before [101] body: "(i), CH"
- before [102] body: "(i), AN"
- before [103] body: "(i), and DE"
- before [104] body: "(i) for its sets of parents, children, ancestors, and descendants in G, respectively."
- after [100] body: "For a vertex i, we write PA (i), CH (i), AN (i), and DE (i) for its sets of parents, children, ancestors, and descendants in G, respectively."

### tables_02_non_gaussian_sem [105, 106]
- before [105] body: "The non-descendants of i are V \\ (DE"
- before [106] body: "(i) ∪{i}), i.e., the vertices other than i that cannot be reached from i by a directed path."
- after [105] body: "The non-descendants of i are V \\ (DE (i) ∪{i}), i.e., the vertices other than i that cannot be reached from i by a directed path."

### tables_02_non_gaussian_sem [108, 109, 110, 111, 112]
- before [108] body: "A permutation t = (t1, . . . , td) of [d] is a topological ordering of G if every parent precedes its child: writing t−1"
- before [109] body: "(i) for the position of vertex i, t−1"
- before [110] body: "(j) < t−1"
- before [111] body: "(i) whenever j ∈PA"
- before [112] body: "(i)."
- after [108] body: "A permutation t = (t1, . . . , td) of [d] is a topological ordering of G if every parent precedes its child: writing t−1 (i) for the position of vertex i, t−1 (j) < t−1 (i) whenever j ∈PA (i)."

### tables_02_non_gaussian_sem [114, 115]
- before [114] body: "We study the linear structural equation model (1) where X = (X1, . . . , Xd)⊤, the matrix Λ ∈Rd×d"
- before [115] body: "has Λij̸ = 0 if and only if j ∈PA(i), and N = (N1, . . . , Nd)⊤is a vector of i.i.d. noise variables with location zero."
- after [114] body: "We study the linear structural equation model (1) where X = (X1, . . . , Xd)⊤, the matrix Λ ∈Rd×d has Λij̸ = 0 if and only if j ∈PA(i), and N = (N1, . . . , Nd)⊤is a vector of i.i.d. noise variables with location zero."

### tables_02_non_gaussian_sem [116, 117]
- before [116] body: "Acyclicity of G is equivalent to the existence of a permutation matrix P such that P ΛP ⊤"
- before [117] body: "is strictly lower triangular."
- after [116] body: "Acyclicity of G is equivalent to the existence of a permutation matrix P such that P ΛP ⊤ is strictly lower triangular."

### tables_02_non_gaussian_sem [148, 149]
- before [148] body: "so that Varlin(Xi | X−i) = σ2 if i is a sink and Varlin(Xi | X−i) ≤σ2/(1 + b2"
- before [149] body: "min) < σ2 otherwise, where bmin = min(i,j)∈E |Λji|."
- after [148] body: "so that Varlin(Xi | X−i) = σ2 if i is a sink and Varlin(Xi | X−i) ≤σ2/(1 + b2 min) < σ2 otherwise, where bmin = min(i,j)∈E |Λji|."

### tables_03_copula_subspaces [57, 58, 59]
- before [57] list: "For marginal densities πi with CDFs Fi, the componentwise map Z"
- before [58] list: "(x)i := Φ−1(Fi"
- before [59] list: "(xi)) produces standard Gaussian marginals (2.1), with Φ the standard normal CDF."
- after [57] list: "For marginal densities πi with CDFs Fi, the componentwise map Z (x)i := Φ−1(Fi (xi)) produces standard Gaussian marginals (2.1), with Φ the standard normal CDF."

### tables_03_copula_subspaces [65, 66]
- before [65] body: "With eigenvalues ordered as λ1(C) ≥· · · ≥λd(C), a top-r eigenbasis V C"
- before [66] body: "r spans the copula active subspace."
- after [65] body: "With eigenvalues ordered as λ1(C) ≥· · · ≥λd(C), a top-r eigenbasis V C r spans the copula active subspace."

### tables_03_copula_subspaces [70, 71, 72, 73]
- before [70] body: "This fit defines bS := ∇P"
- before [71] equation: "α∈Λ bθd"
- before [72] body: "αHα (3.3), with coefficient vector bθd := (bθd"
- before [73] body: "α)α∈Λ."
- after [70] body: "This fit defines bS := ∇P α∈Λ bθd αHα (3.3), with coefficient vector bθd := (bθd α)α∈Λ."

### tables_03_copula_subspaces [74, 75]
- before [74] body: "From the empirical second-moment matrix b C of bS (3.5), we choose a top-r eigenbasis bV C"
- before [75] body: "r ."
- after [74] body: "From the empirical second-moment matrix b C of bS (3.5), we choose a top-r eigenbasis bV C r ."

### tables_03_copula_subspaces [77, 78, 79]
- before [77] body: "A basis Vr ∈St(r, Rd) and its orthonormal completion V⊥separate the retained coordinates U := V ⊤"
- before [78] body: "r Z from the discarded coordinates W := V ⊤"
- before [79] body: "⊥Z."
- after [77] body: "A basis Vr ∈St(r, Rd) and its orthonormal completion V⊥separate the retained coordinates U := V ⊤ r Z from the discarded coordinates W := V ⊤ ⊥Z."

### tables_03_copula_subspaces [81, 82, 83]
- before [81] body: "Define the reduced factor cU"
- before [82] body: "r := πU/γr and its logarithm Lr := log cU"
- before [83] body: "r ."
- after [81] body: "Define the reduced factor cU r := πU/γr and its logarithm Lr := log cU r ."

### tables_03_copula_subspaces [84, 85, 86, 87]
- before [84] body: "Part I (Subsection 2.1) uses this factor to define the reduced model πn(x; Vr) := cU"
- before [85] equation: "r (V ⊤"
- before [86] equation: "r Z(x)) Q"
- before [87] body: "i πi(xi) (2.4)."
- after [84] body: "Part I (Subsection 2.1) uses this factor to define the reduced model πn(x; Vr) := cU r (V ⊤ r Z(x)) Q i πi(xi) (2.4)."

### tables_03_copula_subspaces [88, 89]
- before [88] body: "For the fitted estimator, we use Vr = bV C"
- before [89] body: "r in these definitions."
- after [88] body: "For the fitted estimator, we use Vr = bV C r in these definitions."

### tables_03_copula_subspaces [90, 91, 92]
- before [90] body: "Stage 2 uses the multi-index set Λr := ΛK2,q2 in r variables to fit Lr(u; bθr) := P"
- before [91] equation: "α∈Λr bθr"
- before [92] body: "αHα(u)."
- after [90] body: "Stage 2 uses the multi-index set Λr := ΛK2,q2 in r variables to fit Lr(u; bθr) := P α∈Λr bθr αHα(u)."

### tables_03_copula_subspaces [93, 94]
- before [93] body: "The coefficient vector bθr := (bθr"
- before [94] body: "α)α∈Λr solves the regularized and constrained score-matching problem (3.9)."
- after [93] body: "The coefficient vector bθr := (bθr α)α∈Λr solves the regularized and constrained score-matching problem (3.9)."

### tables_03_copula_subspaces [96, 97, 98]
- before [96] body: "Dividing the exponential by bZr := Eγr[eLr(·;bθr)] produces the reduced factor bcU"
- before [97] body: "r := eLr(·;bθr)/ bZr and the normalized density bπU := bcU"
- before [98] body: "r γr."
- after [96] body: "Dividing the exponential by bZr := Eγr[eLr(·;bθr)] produces the reduced factor bcU r := eLr(·;bθr)/ bZr and the normalized density bπU := bcU r γr."

### tables_03_copula_subspaces [119, 120, 121]
- before [119] body: "In the notation of Part I, bZcomp = bZn/ bZr, since bcU"
- before [120] body: "r already includes the factor bZ−1"
- before [121] body: "r ."
- after [119] body: "In the notation of Part I, bZcomp = bZn/ bZr, since bcU r already includes the factor bZ−1 r ."

### tables_03_copula_subspaces [131, 132]
- before [131] body: "Let bπn be the estimator above, with U := bV C⊤"
- before [132] body: "r Z. Under Assumption 2.1 of Part I and the integrability condition of (M), every term below is finite and, for each realization of the estimation sample, (2.1)"
- after [131] body: "Let bπn be the estimator above, with U := bV C⊤ r Z. Under Assumption 2.1 of Part I and the integrability condition of (M), every term below is finite and, for each realization of the estimation sample, (2.1)"

### tables_03_copula_subspaces [149, 150]
- before [149] body: "Appendix A proves this decomposition at the estimated basis bV C"
- before [150] body: "r , without the eigenbasis of C. Neither RN nor log bZcomp has a prescribed sign, so Emarg can be negative."
- after [149] body: "Appendix A proves this decomposition at the estimated basis bV C r , without the eigenbasis of C. Neither RN nor log bZcomp has a prescribed sign, so Emarg can be negative."

### tables_03_copula_subspaces [164, 165, 166]
- before [164] body: "A mean-value bound for the polynomial bLr and the Cauchy–Schwarz inequality give E|RN| = O("
- before [165] equation: "√"
- before [166] body: "d (log N)K2/2N −1/2) (Appendix A)."
- after [164] body: "A mean-value bound for the polynomial bLr and the Cauchy–Schwarz inequality give E|RN| = O( √ d (log N)K2/2N −1/2) (Appendix A)."

### tables_03_copula_subspaces [179, 180, 181, 182]
- before [179] body: "Let bV C"
- before [180] body: "r be the estimated Stage-1 basis of (3.5) and b Pr := bV C"
- before [181] equation: "r bV C⊤"
- before [182] body: "r ."
- after [179] body: "Let bV C r be the estimated Stage-1 basis of (3.5) and b Pr := bV C r bV C⊤ r ."

### tables_03_copula_subspaces [214, 215, 216]
- before [214] body: "It is zero whenever span( bV C"
- before [215] body: "r ) = span(V C"
- before [216] body: "r ), and only in this case if λr(C) > λr+1(C)."
- after [214] body: "It is zero whenever span( bV C r ) = span(V C r ), and only in this case if λr(C) > λr+1(C)."

### tables_03_copula_subspaces [222, 223]
- before [222] body: "Projecting S onto the gradient space FΛ in L2(πZ) defines SΛ, its second-moment matrix CΛ, and the top-r projector P Λ⋆"
- before [223] body: "r ."
- after [222] body: "Projecting S onto the gradient space FΛ in L2(πZ) defines SΛ, its second-moment matrix CΛ, and the top-r projector P Λ⋆ r ."

### tables_04_markov_kernel [32, 33]
- before [32] body: "for every bounded continuous test function"
- before [33] body: "f. For general Markov chains, however, convergence to a deterministic limiting measure is not automatic."
- after [32] body: "for every bounded continuous test function f. For general Markov chains, however, convergence to a deterministic limiting measure is not automatic."

### tables_04_markov_kernel [68, 69, 70, 71]
- before [68] body: "The resulting discrepancy is the MMD associated with the kernel k(x,"
- before [69] body: "y) = ⟨ϕ"
- before [70] body: "(x), ϕ"
- before [71] body: "(y)⟩H."
- after [68] body: "The resulting discrepancy is the MMD associated with the kernel k(x, y) = ⟨ϕ (x), ϕ (y)⟩H."

### tables_04_markov_kernel [113, 114]
- before [113] body: "By incorporating source and capacity information, this sharpens the T −1/2"
- before [114] body: "excess-risk rate of Kachaiev et al. (2026), however, under different assumptions."
- after [113] body: "By incorporating source and capacity information, this sharpens the T −1/2 excess-risk rate of Kachaiev et al. (2026), however, under different assumptions."

### tables_04_markov_kernel [142, 143, 144]
- before [142] body: "For a measure µ and a measurable function f : X →R, let µ(f) :="
- before [143] equation: "R"
- before [144] equation: "f dµ."
- after [142] body: "For a measure µ and a measurable function f : X →R, let µ(f) := R f dµ."

### tables_04_markov_kernel [162, 163]
- before [162] body: "Setting M0 := 0 and MT := PT"
- before [163] body: "t=1 dt define an H-valued martingale."
- after [162] body: "Setting M0 := 0 and MT := PT t=1 dt define an H-valued martingale."

### tables_05_decomposing_learner [96, 97]
- before [96] body: "where f, µ0, σ2"
- before [97] body: "0 and σ2 1 are unknown functions and parameters."
- after [96] body: "where f, µ0, σ2 0 and σ2 1 are unknown functions and parameters."


## Fixtures with no joins: what was checked

Candidates are from 81 (ws-collapsed text <= 12 chars, or ASCII letters < 50% of non-space chars; equation/table/heading excluded), plus a scan of consecutive body/list/footnote/caption lines where the first lacks end punctuation and the second starts lower-case or with a symbol (run inline in this session, not saved separately).

- academic_01_seahelm_audio: candidates are table rows typed body (p2 Tables), "2.2.1." section number, "-Y." name piece; no inline math. None needed.
- academic_03_pruned_reasoning: candidates are table cells (p2 Table, p3 Table 3), "Setting."/"Definition." run-in heads, and p3 [126]-[141], the pieces of the display definition of ∆cyc (its own block; left as is). None needed.
- academic_04_legislative_xml: "It does not.", "Dataset.", "T1 T2 T3" (table header); no inline math. None needed.
- academic_05_sparse_autoencoders: [63] "2 + λΩ(z)]." and [64] "(1)" are pieces of display equation (1); [32] "can recover?" is a plain line split, not math. None needed.
- report_01..05: candidates are the citation line split at abbreviations ("Natl." "Inst." "Stand." ...), ", Public Law ...", "Clifton, VA", "Revision 2"; no math. None needed.

## Joined fixtures: display-equation candidates left unjoined

- academic_02: [89]-[90], [98]-[101], [125]-[127], [130]-[136] are display equations (2), (4), (6), (7).
- tables_01: [18]-[27] Figure 1 box labels (not in the 56 removal list; left), [53]-[56], [64]-[69], [74]-[81], [86]-[88], [90]-[97], [101]-[107], [126]-[132], [146]-[150], [156]-[159], [175]-[177], [189]-[201], [222]-[224] are display equations (1)-(12); "Eq." / "(8))." abbreviation splits kept per the original rule.
- tables_02: [125]-[130], [136]-[147] display equations (2), (3).
- tables_03: [22]-[23] display (1.1); [100]-[115], [133]-[146], [154]-[162], [167]-[172], [183]-[190], [192]-[201], [203]-[211] display (3.1 joint estimate), (2.1), (3.1)-(3.5).
- tables_04: [22]-[31], [38]-[45], [59]-[65], [80]-[88], [93]-[95], [99]-[101], [105]-[109], [129]-[132], [136]-[140], [148]-[154], [165]-[168], [172]-[176] display equations (2)-(14); "e.g." splits kept.
- tables_05: [32]-[36], [87]-[95], [100]-[107] display equations (1)-(4).
