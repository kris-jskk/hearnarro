# 253 M2 dependency survey (sourced, no recommendation)

Method: WebFetch of PyPI JSON, GitHub raw files, HF API; WebSearch. No installs. Page-summaries came from a small model reading the page, so anything quoting code is a reading, not a run. Date of survey: 2026-10-16.
Items marked UNVERIFIED were not confirmed from a primary page.

## Claim 1: Kokoro runtimes and model

| Name | Licence | Runtime deps | macOS arm64 | Phonemization / espeak | Timestamps | Speed | URL |
|---|---|---|---|---|---|---|---|
| `kokoro` 0.9.4 (hexgrad) | Apache-2.0 | huggingface-hub, loguru, `misaki[en]>=0.9.4`, numpy, **torch**, transformers; Python `>=3.10,<3.13` | pure Python; torch wheels are separate | misaki G2P; `EspeakFallback` built in `KPipeline.__init__`; if it fails to construct, logs a warning and sets fallback=None ("OOD words will be skipped") | Yes: `MToken.start_ts/end_ts` per token, computed in `join_timestamps(tokens, pred_dur)` from model `pred_dur` (frames / 80); English branch only | `speed` is passed positionally to `KModel.forward(ps, ref_s, speed)` (inside the model; torch .pth) | https://pypi.org/pypi/kokoro/json ; https://raw.githubusercontent.com/hexgrad/kokoro/main/kokoro/pipeline.py ; README: https://raw.githubusercontent.com/hexgrad/kokoro/main/README.md ("Install espeak, used for English OOD fallback and some non-English languages") |
| `kokoro-onnx` 0.6.1 (thewh1teagle) | MIT (LICENSE file) | `espeakng-loader>=0.2.4`, numpy>=2.0.2, onnxruntime>=1.20.1, `phonemizer>=3.4.0`; Python `>=3.10,<3.14`; no torch | pure Python + onnxruntime wheels | `Tokenizer.phonemize` calls `phonemizer.phonemize` (espeak backend) and filters to vocab; **espeak-ng REQUIRED** in this code (raises RuntimeError if no library); no non-espeak path (README recommends misaki from v1.0; `create(is_phonemes=True)` accepts pre-made phonemes) | `create_timed()` returns `list[Timing]` per **phoneme** (phoneme, start, end) only when the model has a `duration` output; `create()` discards timings. Per-token/word times would have to be aggregated by the caller (UNVERIFIED how well phoneme-to-word mapping works) | `speed` IS a model input named "speed"; range 0.5-2.0 enforced; integer speed input rounded | https://pypi.org/pypi/kokoro-onnx/json ; https://raw.githubusercontent.com/thewh1teagle/kokoro-onnx/main/src/kokoro_onnx/__init__.py ; .../tokenizer.py ; .../sliding.py ; https://raw.githubusercontent.com/thewh1teagle/kokoro-onnx/main/LICENSE |
| `misaki` 0.9.4 | Apache-2.0 | see claim 2 | pure Python | see claim 2 | MToken carries start_ts/end_ts, filled by kokoro | n/a | https://pypi.org/pypi/misaki/json |
| other maintained runtimes | UNVERIFIED: not searched beyond the two above (e.g. onnx-community / transformers.js use) | | | | | | |

Models
| Model | Licence | Revision | Notes | URL |
|---|---|---|---|---|
| `hexgrad/Kokoro-82M` (PyTorch `kokoro-v1_0.pth`, 54 voice `.pt`) | apache-2.0 (tag and cardData) | `f3ff3571791e39611d31c381e3a41a3af07b4987` (lastModified 2025-04-10) | no ONNX files in this repo | https://huggingface.co/api/models/hexgrad/Kokoro-82M |
| `onnx-community/Kokoro-82M-v1.0-ONNX` | apache-2.0 (tag and cardData) | `1939ad2a8e416c0acfeecc08a694d14ef25f2231` (lastModified 2025-02-08) | onnx/model.onnx, model_fp16, model_q4, model_q4f16, model_q8f16, model_quantized, model_uint8, model_uint8f16. NOTE: dated 2025-02-08, before hexgrad's v1.0 repo update of 2025-04-10; whether weights are identical to current hexgrad v1.0 is UNVERIFIED. Voices are shipped separately in that repo (UNVERIFIED, file list not read) | https://huggingface.co/api/models/onnx-community/Kokoro-82M-v1.0-ONNX |
| kokoro-onnx release assets `kokoro-v1.0.onnx`, `voices-v1.0.bin` | README says Apache-2.0 | GitHub release `model-files-v1.1`, not an HF revision (cannot pin by HF hash; pin by sha256 of file) | ~300 MB (quantized ~80 MB) | https://github.com/thewh1teagle/kokoro-onnx/releases/download/model-files-v1.1/kokoro-v1.0.onnx |

Direct answers
- Is `speed` a model input: yes in both (kokoro: third arg to KModel; kokoro-onnx: ONNX input "speed").
- Per-token timestamps: only the `kokoro` package exposes per-token start/end (needs torch). kokoro-onnx exposes per-phoneme timings.
- Is espeak-ng required: `kokoro`: optional, used only as OOD fallback (see claim 2 for what happens when absent). `kokoro-onnx` (its own tokenizer): required.
- Hidden problem: `misaki[en]` extras pull `phonemizer-fork` (GPLv3+, PyPI) and `espeakng-loader`, even if the fallback is unused. `kokoro-onnx` pulls `phonemizer` (licence not read; UNVERIFIED, upstream is GPL-3). Licence of `espeakng-loader` is null on PyPI (UNVERIFIED; it bundles espeak-ng, GPL-3).

## Claim 2: misaki

| Item | Finding | URL |
|---|---|---|
| Licence | Apache-2.0 | https://pypi.org/pypi/misaki/json |
| `[en]` extra deps | espeakng-loader, num2words, **phonemizer-fork**, spacy, spacy-curated-transformers (plus base addict, regex). kokoro requires `misaki[en]`, so these install | same |
| phonemizer-fork 3.3.2 licence | **GPLv3+** | https://pypi.org/pypi/phonemizer-fork/json |
| espeakng-loader 0.2.4 | licence null on PyPI; macOS arm64 wheel `espeakng_loader-0.2.4-py3-none-macosx_11_0_arm64.whl` (~9.9 MB, bundles the shared lib and data, inferred from size) | https://pypi.org/pypi/espeakng-loader/json |
| Behaviour for OOD words with no espeak | `en.py` (as read): lexicon first, then fallback. If `fallback` is None, `G2P.__init__` sets `FallbackNetwork(british)` (BART seq2seq loaded from Hugging Face, needs transformers and torch), so words are NOT left unspelled by default. In `KPipeline` the espeak fallback is tried first; on failure `fallback=None` is passed to G2P (so the BART network applies per the code as read), with `unk=''`. The unk placeholder is applied only if phonemes are still None. Net: absent espeak does not raise; OOD handled by the BART neural fallback (extra model download; licence of that checkpoint UNVERIFIED). Not run, reading of source only | https://raw.githubusercontent.com/hexgrad/misaki/main/misaki/en.py ; https://raw.githubusercontent.com/hexgrad/misaki/main/misaki/espeak.py ; kokoro pipeline.py above |
| espeak use | `misaki/espeak.py` imports `phonemizer` (EspeakWrapper) and `espeakng_loader`; `EspeakFallback` "last resort for English" | espeak.py URL above |

Caveat: the above comes from main-branch source via a summarizer; the installed 0.9.4 release may differ. A test run in a scratch venv would settle it (not done: read-only task).

## Claim 3: espeak-ng and alternatives

| Name | Licence | Native deps | arm64 wheel | Notes | URL |
|---|---|---|---|---|---|
| espeak-ng | GPL-3 (COPYING is GPLv3) | itself native | via espeakng-loader wheel | not allowed as shipped component under the rule | https://raw.githubusercontent.com/espeak-ng/espeak-ng/master/COPYING |
| g2p_en 2.1.0 | Apache Software License (classifier) | numpy, nltk>=3.2.4, inflect, distance; needs nltk data (averaged_perceptron_tagger, cmudict) downloaded at runtime; model (checkpoint20.npz) licence UNVERIFIED | pure Python | outputs ARPAbet, NOT the IPA that Kokoro's vocab uses; needs an ARPAbet-to-Kokoro-phoneme mapping (not a drop-in) | https://pypi.org/pypi/g2p-en/json |
| gruut 2.4.0 | MIT (classifier; licence field null) | Babel, dateparser, gruut-ipa, gruut_lang_en, jsonlines, networkx, num2words, numpy, python-crfsuite; language data packages | python-crfsuite has arm64 wheels (UNVERIFIED) | outputs IPA; compat with Kokoro's token set unverified; maintenance: UNVERIFIED | https://pypi.org/pypi/gruut/json |
| deep-phonemizer | UNVERIFIED (not fetched) | | | | |
| misaki lexicon (gold/silver dicts, derived from CMUdict/Wiktionary) | Apache-2.0 package | | | lexicon licence UNVERIFIED | https://pypi.org/pypi/misaki/json |

No confirmed drop-in. The only path that avoids phonemizer-fork/espeak entirely is: use misaki's lexicon+BART fallback with the GPL packages not installed (needs `pip install misaki` without `[en]` plus spacy, num2words by hand; UNVERIFIED that import works without phonemizer, since espeak.py imports it at top level, and kokoro pipeline imports `from misaki import en, espeak`).

## Claim 4: Opus without ffmpeg

| Name | Package licence | Native lib bundled and its licence | macOS arm64 from wheel, no system libs | Writes Ogg Opus / WebM | URL |
|---|---|---|---|---|---|
| `opuscodec` 0.1.3 (fishaudio) | Apache-2.0 | self-contained builds; libogg, libopusenc listed as deps (BSD-3 / BSD-3 / BSD-3, UNVERIFIED for libopusenc) ; QEXT build | yes: `cp311-cp311-macosx_11_0_universal2.whl`, cp312; requires numpy>=1.24 | `.opus` (Ogg Opus) via bundled `opusenc` CLI is inferred; README shows raw packets via OpusBufferedEncoder. Ogg writing from the Python API UNVERIFIED | https://pypi.org/pypi/opuscodec/json ; https://github.com/fishaudio/opuscodec |
| `soundfile` 0.14.0 | BSD-3-Clause | bundles libsndfile (v1.2.2 as of 0.13.0) in macOS wheels; libsndfile is **LGPL-2.1** (https://github.com/libsndfile/libsndfile/blob/master/COPYING); it links libopus/libogg/libvorbis in 1.2.x | yes: `soundfile-0.14.0-py2.py3-none-macosx_11_0_arm64.whl` (~1.1 MB; the README says this size means libsndfile is bundled) | Ogg Opus write: UNVERIFIED (libsndfile >=1.0.29 supports Opus subtype in Ogg; not confirmed from a fetched page); WebM no | https://pypi.org/pypi/soundfile/json |
| `PyOgg` 0.6.14a1 | BSD-3-Clause | Windows wheels only bundle DLLs; no macOS wheel; docs say macOS needs Homebrew libs (opus, opusfile, libopusenc, ...) | **no** | has OggOpusWriter | https://pypi.org/pypi/PyOgg/json ; https://pyogg.readthedocs.io/en/latest/installation.html |
| `opuslib` 3.0.1 | BSD-3-Clause | does NOT bundle libopus (UNVERIFIED, page silent); sdist only, ctypes-style binding | **no wheel** | raw Opus packets only; no Ogg | https://pypi.org/pypi/opuslib/json |
| `av` (PyAV) 19.0.1 | BSD-3-Clause (license_expression) | bundles FFmpeg libs in binary wheels; FFmpeg is LGPL-2.1+ unless built with GPL parts; which build PyAV ships is UNVERIFIED | arm64 wheels exist for older versions (e.g. `av-12.1.0-cp312-cp312-macosx_11_0_arm64.whl`); 19.0.1 list not read | Ogg Opus and WebM Opus (libopus encoder inclusion in the wheel UNVERIFIED); gives muxing in-process, no subprocess | https://pypi.org/pypi/av/json |
| `sphn` 0.2.1 (Kyutai) | licence null on PyPI (UNVERIFIED; repo claims not read) | Rust, wheels | cp38-cp313 macosx_11_0_arm64 for 0.1.12; 0.2.1 list not read | purpose is audio read/write incl. opus (description empty, UNVERIFIED) | https://pypi.org/pypi/sphn/json |
| `python-opus`, `pyopus`, `opus-encoder` | UNVERIFIED: not found in searches | | | | https://www.google.com (no hit; search returned none) |

Direct answer: the only candidate found with a permissive licence on the package AND a macOS arm64 wheel AND plausible Ogg Opus output without system libs is `opuscodec` (Apache-2.0, universal2 wheel), with Ogg output UNVERIFIED. `soundfile` is BSD but ships LGPL libsndfile. PyAV is BSD but ships LGPL (or GPL) FFmpeg. WebM/Opus muxing: none of the pure-Python options writes WebM (UNVERIFIED); Ogg Opus is the container reachable without ffmpeg.

## Claim 5: ffmpeg

| Item | Finding | URL |
|---|---|---|
| FFmpeg licence | LGPL-2.1+ by default; GPL-2+ applies to whole build if GPL parts enabled (e.g. libx264, `--enable-gpl`); `--enable-nonfree` makes it non-redistributable. LGPL checklist: no --enable-gpl, link dynamically, provide source | https://ffmpeg.org/legal.html |
| Typical static macOS builds | licence depends on configure flags; common static builds enable `--enable-gpl` (x264/x265): UNVERIFIED for evermeet.cx / johnvansickle / imageio-ffmpeg builds (not fetched) | |
| `imageio-ffmpeg` 0.6.0 | wrapper BSD-2-Clause; wheel `imageio_ffmpeg-0.6.0-py3-none-macosx_11_0_arm64.whl` contains the ffmpeg executable (~60 MiB); the binary's configure flags/licence UNVERIFIED | https://pypi.org/pypi/imageio-ffmpeg/json |
| `static-ffmpeg` 3.0 | wrapper MIT; ffmpeg/ffprobe 8.0 downloaded at FIRST USE from github.com/zackees/ffmpeg_bins (not at pip install; needs network at runtime); `darwin_arm64` supported; binary licence UNVERIFIED | https://pypi.org/pypi/static-ffmpeg/json |

Two readings of the project rule (supervisor decides):
- Reading A (strict: every dependency incl. executables we ship or invoke must be Apache/MIT/BSD): an LGPL or GPL ffmpeg subprocess fails.
- Reading B (rule is about linked/imported code and models shipped in the product; ffmpeg as a separately invoked, unmodified executable the user installs or that arrives under its own licence is an external tool, "mere aggregation"; LGPL build without --enable-gpl is the lower-risk case). Needs the LGPL notice and source-offer obligations if we redistribute the binary. Not legal advice.

## Claim 6: browser decode matrix (AudioContext.decodeAudioData)

Primary pages (MDN, caniuse) report `<audio>` element support, not decodeAudioData per container. Rows below combine them with developer reports; treat Safari rows as secondary-source.

| Format | Chrome | Firefox | Safari macOS | Safari iOS | Sources |
|---|---|---|---|---|---|
| Opus in `<audio>` (any container, per caniuse) | 33 | 15 | 11 partial (CAF only) through 18.3; full from 18.4 | 11 partial; full from 18.4 | https://caniuse.com/opus ; https://developer.mozilla.org/en-US/docs/Web/Media/Guides/Formats/Audio_codecs |
| Ogg/Opus via decodeAudioData | supported since the same versions (UNVERIFIED for decodeAudioData specifically) | same (UNVERIFIED) | fails with "Decoding failed" on 17.6 per a developer report; works from 18.4 per secondary sources | not before 18.4 (secondary) | https://github.com/bricedupuy/Songverse/issues/185 ; https://github.com/infinityfreeworld/infinity-broadcast-scheduler/pull/20 ; https://www.testmuai.com/learning-hub/mediarecorder-browser-support/ |
| WebM/Opus via decodeAudioData | Chrome (UNVERIFIED version for decodeAudioData) | Firefox (UNVERIFIED) | reported working; "consistently supported across iOS and macOS in Safari 17.4"; one report decoded on iOS 17 | same | https://bugs.webkit.org/show_bug.cgi?id=238546 ; PR #20 above |
| WAV (PCM) | UNVERIFIED by fetched page: not cited. MDN codec page does not list WAV decoding tables (page fetched only mentions WAV for G.711) | | | | https://developer.mozilla.org/en-US/docs/Web/Media/Guides/Formats/Audio_codecs . Claim 6 WAV statement "decoded everywhere" is UNVERIFIED here (no primary page fetched; budget) |

Direct answer: WebM/Opus is the safer Opus container for Safari before 18.4 (works from about 17.4 per WebKit bug thread); Ogg/Opus needs Safari/iOS 18.4+. Official WebKit release notes were not found (UNVERIFIED).

## Claim 7: time-stretch without ffmpeg

| Name | Licence | Needs installed | Python 3.11 | Quality / notes | URL |
|---|---|---|---|---|---|
| `audiotsm` 0.1.2 | MIT | numpy only; pure Python wheel | yes (py2.py3-none-any) | OLA, WSOLA, phase vocoder; last release 2017-09-21 (unmaintained) | https://pypi.org/pypi/audiotsm/json |
| `librosa` 1.0.0 `effects.time_stretch` | ISC | numba, scipy, scikit-learn, soundfile (libsndfile LGPL bundled), soxr, etc. (heavy) | **No: 1.0.0 requires Python >=3.12**; older librosa (0.10/0.11) not checked | phase vocoder, audible phasiness on speech (caveat from brief; not run) | https://pypi.org/pypi/librosa/json |
| `pyrubberband` 0.4.0 | ISC wrapper | needs the Rubber Band CLI/library installed separately (GPL-2+ / commercial; page silent, general knowledge, UNVERIFIED); also soundfile | yes | good quality but GPL binary | https://pypi.org/pypi/pyrubberband/json |
| ffmpeg `atempo` | see claim 5 | ffmpeg | n/a | | https://ffmpeg.org/legal.html |
| hand-written WSOLA (numpy/scipy) | own code | numpy | yes | not surveyed | |
| Kokoro `speed` model input | n/a | | | native speed control (claim 1), avoids stretch | |

## Permissive end to end (package, native libs, models; as far as confirmed)

- `kokoro-onnx` 0.6.1 (MIT) + `onnxruntime` + Kokoro-82M ONNX weights (Apache-2.0): permissive except its required `phonemizer` + `espeakng-loader` (GPL-3 / espeak-ng GPL-3). NOT permissive end to end as installed.
- `misaki` 0.9.4 (Apache-2.0) base package: permissive; the `[en]` extra is not (phonemizer-fork GPLv3+, espeakng-loader/espeak-ng GPL-3).
- `hexgrad/Kokoro-82M` @ f3ff3571791e39611d31c381e3a41a3af07b4987 (Apache-2.0); `onnx-community/Kokoro-82M-v1.0-ONNX` @ 1939ad2a8e416c0acfeecc08a694d14ef25f2231 (Apache-2.0): models.
- `kokoro` 0.9.4 (Apache-2.0) itself and torch/transformers (BSD / Apache): permissive, but depends on misaki[en] (GPL pieces above).
- `g2p_en` 2.1.0 (Apache), `gruut` 2.4.0 (MIT): permissive packages, not drop-in for Kokoro's IPA vocab.
- `opuscodec` 0.1.3 (Apache-2.0) with self-contained builds: the only Opus encoder wheel found that is permissive with a macOS wheel; bundled-lib licences (libopus BSD-3, libogg BSD-3, libopusenc BSD-3) are from background knowledge, UNVERIFIED here.
- `audiotsm` 0.1.2 (MIT, numpy-only), `soundfile` wrapper BSD-3 (but bundled libsndfile is LGPL, see below).
- WAV output (stdlib `wave` or `soundfile`).

## Not allowed as-is

- espeak-ng: GPL-3 (https://raw.githubusercontent.com/espeak-ng/espeak-ng/master/COPYING).
- `phonemizer-fork` 3.3.2: GPLv3+ (pulled by `misaki[en]`, which `kokoro` requires).
- `phonemizer` (kokoro-onnx dependency): upstream GPL-3, UNVERIFIED on PyPI page, not fetched.
- `espeakng-loader`: bundles espeak-ng (GPL-3); PyPI licence null.
- `soundfile` libsndfile bundle: LGPL-2.1 (wrapper itself BSD).
- `av` bundled FFmpeg: LGPL-2.1+ or GPL depending on build (UNVERIFIED which).
- ffmpeg binaries (imageio-ffmpeg, static-ffmpeg, any static build): LGPL-2.1+ or GPL; depends on reading in claim 5.
- Rubber Band (pyrubberband): GPL-2+ binary (UNVERIFIED on a fetched page).
- `PyOgg`, `opuslib`: permissive but no macOS wheel / no bundled libopus; need Homebrew libs, which this machine lacks.
- `librosa` 1.0.0: ISC but requires Python >=3.12; project venv is 3.11.

## Budget

40 tool calls used. Left unsettled: WAV decode citation, libsndfile Opus support citation, deep-phonemizer, python-opus/pyopus/opus-encoder, ffmpeg binary build flags, whether opuscodec writes Ogg from Python, behaviour with installed misaki 0.9.4 without espeak (needs a run).
