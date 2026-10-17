# 279 Kokoro-82M licence spike: summary

Scratch venv only (`scratchpad/kokoro_spike/.venv`, Python 3.11, macOS Apple M5 Pro, CPU). `api/.venv` and `api/pyproject.toml` were not touched. Evidence: 273–278.

## Recipe (273)
```
uv venv --python 3.11 .venv
uv pip install torch
uv pip install --no-deps kokoro==0.9.4 misaki            # misaki base 0.9.4, NO [en] extra
uv pip install transformers huggingface-hub loguru numpy addict regex spacy soundfile attrs
uv pip install "en_core_web_sm @ https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-3.8.0/en_core_web_sm-3.8.0-py3-none-any.whl"
uv pip install opuscodec audiotsm                         # encoder + stretch
```
- `attrs` is an undeclared kokoro dependency (`kokoro/custom_stft.py`: `from attr import attr`).
- `misaki.en.G2P.__init__` calls `spacy.cli.download("en_core_web_sm")` if the model is missing (it runs pip at runtime), so pin the wheel in the install instead.
- **Licence verdict (273):** 71 distributions, 0 GPL/LGPL/AGPL, 0 unknown. phonemizer, phonemizer-fork, espeakng-loader and num2words are all absent. These permissive licences are outside Apache/MIT/BSD and need a policy decision: certifi (MPL-2.0), tqdm (MPL-2.0 AND MIT), typing_extensions (PSF-2.0), shellingham (ISC), torch (includes BSL-1.0 and LLVM-exception parts), numpy (includes Zlib/CC0 parts).

## Import (claim 2, 274): does NOT work out of the box; works with a shim we can ship
Two top-level imports block it:
1. `misaki/en.py` line 4: `from num2words import num2words`. **num2words is LGPL** (PyPI classifier, 273). The brief's survey did not flag this. Pulling in only `misaki[en]` minus phonemizer would still ship LGPL.
2. `kokoro/pipeline.py` line 5: `from misaki import en, espeak`. `misaki/espeak.py` line 1 imports `phonemizer` (GPL-3), and then `espeakng_loader`.

Workaround that works without patching installed files: an own module (`hn_shims.install()`, called before `import kokoro`) registers `sys.modules["num2words"]` with our own ~50-line English cardinal/ordinal/year/decimal implementation, plus a stub `sys.modules["misaki.espeak"]` whose `EspeakFallback.__init__` raises. KPipeline already catches that exception and continues with `fallback=None`. With this in place, `from kokoro import KPipeline` succeeds. The cleaner long-term options are an upstream PR that makes these imports lazy, or calling `KModel` together with `misaki.en.G2P` directly. Option (b) still needs the num2words shim, and it would mean re-implementing kokoro's `join_timestamps` and chunking.

## Synthesis (274)
- S1 (80 chars): 5.750 s of audio at 24000 Hz, PCM16 276000 bytes, 0.48 s wall (first call after load). 17 tokens, all 17 with timestamps. For example: The 250–325 ms [0:3], quick 325–575 [4:9], brown 575–962 [10:15]. "3.2" → "θɹˈi pYnt tˈu" via the shim num2words.
- Model load: weights 327 MB (`kokoro-v1_0.pth`), first download about 6.7 s. KModel + G2P load takes 0.5–0.7 s and `import` takes about 1.4 s. The model is pinned by passing `config=`/`model=` paths from `hf_hub_download(..., revision=f3ff357…)`, and the voice is passed as a pinned `.pt` path. KModel's own download ignores revision.
- **OOV without a fallback:** "Kubernetes" and "Zygalski" get empty phonemes and are **silently skipped** (not spoken). "HearNarro's" became "hˈɪɹs". No BART model was loaded. misaki 0.9.4 has no non-espeak fallback (grep of en.py found no BART). **Timestamps break too:** only 4 of 8 tokens are timed, and "nodes" and "." get none. kokoro's `join_timestamps` advances 2 duration slots for an empty-phoneme token that contributed only 1 (a space), so everything after it misaligns or drops.
- **With our own permissive fallback** (look up camel-case pieces in misaki's gold/silver lexicon, otherwise spell the letters; `pipe.g2p.fallback = fn`): all 8 tokens are timed, 6.775 s audio. The unknown words are spelled out letter by letter ("K-U-B-E-R-…"). That is intelligible but poor for long words. A better G2P for OOV words is an open item.

## Speed (275), native `speed=`
| speed | audio s | last token end ms | dur(1.0)/dur(s) |
|---|---|---|---|
| 0.5 | 11.550 | 11425 | 0.498 (ideal 0.5) |
| 1.0 | 5.750 | 5650 | — |
| 2.0 | 3.325 | 3225 | 1.729 (ideal 2.0) |
Timestamps scale with the audio (last-end ratio 0.495 / 1.752). Speed 2.0 comes out about 14% slower than nominal. Pauses and leading silence do not shrink linearly. Kokoro also accepts other speeds (no range enforced in code). The spec's (0.5, 2.0) native range plus WSOLA above 2.0 is consistent with this.

## RTF / first audio (276)
10 unique body sentences, 111–157 chars, speed 1.0, warm model, CPU: **mean RTF 0.078, max RTF 0.079, mean wall 0.705 s, max wall 0.830 s**. Each sentence was a single chunk, so time to first audio equals wall time. **Gate implication:** with a warm model, first audio for a ~150-char sentence takes about 0.83 s, well under the PRD M2 limit of 2 s on this machine. Cold start adds about 1.4 s import plus about 0.6 s load (plus about 6.7 s one-time download), so the backend must be loaded at server start, not on the first request. At 0.5x speed a 150-char sentence would take about 2x the wall time (S1 measured 0.90 s at 0.5x vs 0.46 s at 1.0x, 275), so roughly 1.7 s on the worst sentence: below 2 s, but with less margin. This is not measured on the 150-char set at 0.5x and is **unverified**.

## Opus (277)
`opuscodec` 0.1.3 (Apache-2.0, bundles libopus 1.6.1 and libogg). `OpusBufferedEncoder(24000, 1).write(int16[samples,1]) + flush()` returns a complete **Ogg Opus** stream (OggS magic, OpusHead, OpusTags, 9 pages), not WebM. For the 5.75 s sentence: 42,441 bytes (qext=False) vs 276,044 bytes WAV, **6.5x smaller**. Encoding takes about 95 ms. The round-trip decode gives 48 kHz output (276000 samples = 5.75 s). The default is QEXT on (an Opus 1.6 extension). Browser `decodeAudioData` support for these Ogg files, with or without QEXT, is **unverified**. Use `qext=False` and media type `audio/ogg`. The wheel also installs top-level `opusenc.py`/`opusdec.py` modules (namespace pollution).

## Stretch (278)
`audiotsm` 0.1.2 WSOLA, ratio 1.5, on the 5.75 s PCM: 3.776 s output vs 3.833 s expected (**−1.50%**, within 2%). Wall time is about 20 ms. Takes float (channels, samples) via `ArrayReader`/`ArrayWriter`.

## Open risks
1. **num2words is LGPL.** This is new and not in survey 253. Shipping Kokoro needs our own num2words shim. Number normalisation quality then depends on our code (currencies, years, decimals).
2. **The shim relies on misaki/kokoro internals** (module names, `fallback` hook, the exception path in KPipeline). Pin `kokoro==0.9.4` and `misaki==0.9.4` exactly, and keep a smoke test.
3. **OOV words**: no espeak means they are dropped silently, and timestamps degrade unless we supply a fallback. Letter spelling works but sounds poor. The licence and quality of misaki's lexicon data (us_gold/us_silver JSON, shipped inside the Apache-2.0 wheel) have not been audited separately: **unverified**.
4. Footprint: the venv is 839 MB, of which torch is 558 MB. The model cache is 313 MB (327 MB `.pth`). spaCy plus en_core_web_sm add 40 MB.
5. Non-Apache/MIT/BSD permissive licences in the tree (MPL-2.0 certifi/tqdm, PSF, ISC, BSL-1.0 inside torch) need an explicit policy statement in the PRD.
6. `en.G2P` silently runs `spacy.cli.download` (network plus pip) if the spaCy model is missing.
7. Upstream timestamp bug for empty-phoneme tokens (274). Our fallback avoids it, but any token that still gets `None` phonemes (unk='') misaligns the rest of the chunk. The backend should assert that every word token is timed, or else fall back to proportional timing.

## Shim code used (scratchpad/kokoro_spike/scripts/hn_shims.py, verbatim)
```python
"""Shims that let `kokoro` + `misaki` (base, Apache-2.0) import without GPL/LGPL packages.

- `misaki.espeak` imports phonemizer (GPL-3) + espeakng_loader at module top; kokoro.pipeline does
  `from misaki import en, espeak` at top level. We register a stub module whose EspeakFallback raises,
  so KPipeline logs "EspeakFallback not Enabled" and uses fallback=None.
- `misaki.en` does `from num2words import num2words` (LGPL) at top level. We register our own
  minimal English implementation under that name.
No installed file is modified; must be called before `import kokoro`.
"""
import sys, types

ONES = "zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen".split()
TENS = "_ _ twenty thirty forty fifty sixty seventy eighty ninety".split()
SCALES = [(10**12, "trillion"), (10**9, "billion"), (10**6, "million"), (1000, "thousand"), (100, "hundred")]
ORD = {"one": "first", "two": "second", "three": "third", "five": "fifth", "eight": "eighth",
       "nine": "ninth", "twelve": "twelfth"}

def _card(n: int) -> str:
    if n < 0:
        return "minus " + _card(-n)
    if n < 20:
        return ONES[n]
    if n < 100:
        return TENS[n // 10] + ("-" + ONES[n % 10] if n % 10 else "")
    for v, w in SCALES:
        if n >= v:
            q, r = divmod(n, v)
            return _card(q) + " " + w + ((" and " if v == 100 else " ") + _card(r) if r else "")
    raise ValueError(n)

def _ordinal(n: int) -> str:
    c = _card(n)
    head, sep, last = c.rpartition(" ") if "-" not in c.split(" ")[-1] else c.rpartition("-")
    if last in ORD:
        last = ORD[last]
    elif last.endswith("y"):
        last = last[:-1] + "ieth"
    else:
        last += "th"
    return head + sep + last

def _year(n: int) -> str:
    if 1000 <= n <= 9999 and not (2000 <= n <= 2009) and n % 100:
        hi, lo = divmod(n, 100)
        return _card(hi) + " " + ("oh " + ONES[lo] if lo < 10 else _card(lo))
    if 1000 <= n <= 9999 and n % 1000 and n % 100 == 0:
        return _card(n // 100) + " hundred"
    return _card(n)

def num2words(number, to: str = "cardinal", **_):
    if isinstance(number, float) and to == "cardinal":
        s = repr(number)
        if "e" in s:
            s = f"{number:f}"
        ip, _, fp = s.partition(".")
        out = _card(int(ip))
        if fp and fp != "0":
            out += " point " + " ".join(ONES[int(d)] for d in fp)
        return out
    n = int(number)
    return {"cardinal": _card, "ordinal": _ordinal, "year": _year}[to](n)

def install() -> None:
    m = types.ModuleType("num2words")
    m.num2words = num2words
    sys.modules["num2words"] = m
    esp = types.ModuleType("misaki.espeak")
    class EspeakFallback:
        def __init__(self, *a, **k):
            raise ImportError("espeak disabled by HearNarro licence policy (GPL)")
    class EspeakG2P(EspeakFallback):
        pass
    esp.EspeakFallback, esp.EspeakG2P = EspeakFallback, EspeakG2P
    sys.modules["misaki.espeak"] = esp
    import misaki
    misaki.espeak = esp
```

## OOV fallback used (scripts/fb_patch.py, verbatim)
```python
# appended mode: a permissive OOV fallback (own code) — split camel case / possessive, look up pieces in
# misaki's gold+silver lexicon, else spell the letters. Returns (phonemes, rating) as misaki expects.
import re
def make_fallback(lex):
    def look(w):
        for k in (w, w.lower(), w.capitalize(), w.upper()):
            for d in (lex.golds, lex.silvers):
                v = d.get(k)
                if isinstance(v, dict): v = v.get("DEFAULT") or next(iter(v.values()))
                if v: return v
        return None
    def spell(w):
        return "".join(look(c.upper()) or "" for c in w if c.isalpha())
    def fb(tk):
        w = tk.text; tail = ""
        if w.endswith("'s"): w, tail = w[:-2], "z"
        parts = re.findall(r"[A-Z]?[a-z]+|[A-Z]+(?![a-z])|\d+", w) or [w]
        ps = "".join(look(p) or spell(p) for p in parts)
        return (ps + tail if ps else None), 1
    return fb
```
