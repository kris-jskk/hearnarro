# 360 — what misaki's G2P does today with all-caps tokens (KokoroBackend US pipeline, before this change)

Run: `HF_HOME=$HOME/hearnarro-m1/hf HEARNARRO_TTS_BACKEND=kokoro api/.venv/bin/python <scratchpad>/inv.py`
(each token raw in "I read about <TOK> yesterday."; columns read from `g2p.lexicon.golds/silvers`,
the misaki token's `tag`, `phonemes`, `rating`; `fallback.used` empty for every token, so no token
reached the OOV fallback). The "how" column in the raw printout was a first guess; the corrected
reading (from misaki/en.py, below) is in the second table.

## Raw output
| token | in golds (UPPER) | lower in golds | lower in silvers | spaCy tag | phonemes | rating | how |
|---|---|---|---|---|---|---|---|
| TED | False | True ('tˈɛd') | False | NNP | tˈɛd | 4 | spelled by misaki get_NNP |
| NASA | True | True ('nˈæsə') | False | NNP | nˈæsə | 4 | lexicon (uppercase entry) |
| NIST | False | False (None) | True | NN | nˈɪst | 3 | spelled by misaki get_NNP |
| CEO | False | False (None) | False | NNP | sˌiˌiˈO | 3 | spelled by misaki get_NNP |
| PDF | False | False (None) | False | NNP | pˌidˌiˈɛf | 3 | spelled by misaki get_NNP |
| HTML | False | False (None) | False | NNP | ˌAʧtˌiˌɛmˈɛl | 3 | spelled by misaki get_NNP |
| USB | False | False (None) | False | NN | jˌuˌɛsbˈi | 3 | spelled by misaki get_NNP |
| FBI | False | False (None) | False | NNP | ˌɛfbˌiˈI | 3 | spelled by misaki get_NNP |
| AI | True | False (None) | False | NNP | ˈAˌI | 4 | lexicon (uppercase entry) |
| UK | False | False (None) | False | NNP | jˌukˈA | 3 | spelled by misaki get_NNP |
| IBM | False | False (None) | False | NNP | ˌIbˌiˈɛm | 3 | spelled by misaki get_NNP |
| JSON | False | False (None) | False | NNP | ʤˌAˌɛsˌOˈɛn | 3 | spelled by misaki get_NNP |
| SQL | True | True ('sˈikwəl') | False | NNP | sˈikwəl | 4 | lexicon (uppercase entry) |
| GPU | False | False (None) | False | NNP | ʤˌipˌijˈu | 3 | spelled by misaki get_NNP |
| OPEC | True | True ('ˈOpɛk') | False | NNP | ˈOpɛk | 4 | lexicon (uppercase entry) |
| FIFA | True | True ('fˈifə') | False | NNP | fˈifə | 4 | lexicon (uppercase entry) |
| IKEA | False | False (None) | False | NN | ˌIkˌAˌiˈA | 3 | spelled by misaki get_NNP |
| NATO | True | True ('nˈAɾO') | False | NNP | nˈATO | 4 | lexicon (uppercase entry) |
| UNESCO | True | True ('junˈɛskO') | False | NNP | junˈɛskO | 4 | lexicon (uppercase entry) |

## Corrected classification (misaki today)
| token | misaki today | why |
|---|---|---|
| TED | spoken `tˈɛd` | lowercase `ted` is a gold word; NNP but entry has primary stress so get_NNP not used |
| NASA | spoken `nˈæsə` | gold entry `NASA` |
| NIST | spoken `nˈɪst` | silver `nist` (tag NN) |
| CEO | spelled `sˌiˌiˈO` | no entry -> get_NNP |
| PDF | spelled | get_NNP |
| HTML | spelled | get_NNP |
| USB | spelled | get_NNP |
| FBI | spelled | get_NNP |
| AI | spelled `ˈAˌI` | gold entry `AI` is the letters |
| UK | spelled | get_NNP |
| IBM | spelled | get_NNP |
| JSON | spelled `ʤˌAˌɛsˌOˈɛn` | get_NNP |
| SQL | spoken "sequel" `sˈikwəl` | gold entry `SQL` |
| GPU | spelled | get_NNP |
| OPEC | spoken `ˈOpɛk` | gold entry |
| FIFA | spoken `fˈifə` | gold entry |
| IKEA | spelled | get_NNP |
| NATO | spoken `nˈATO` | gold entry |
| UNESCO | spoken | gold entry (19th token, extra) |

## misaki's own uppercase heuristic (site-packages/misaki/en.py, Lexicon)
- `is_known`: an all-caps ASCII word is always "known" (`word[1:] == word[1:].upper()`), so it
  never reaches the OOV fallback.
- `lookup`: if `word == word.upper()` and the uppercase form is not a gold key, the word is
  lowercased and `is_NNP = (tag == 'NNP')`; golds are tried, then silvers (only when not NNP).
- If nothing is found, or the token is NNP and the entry has no primary stress, `get_NNP` spells
  it: each letter's gold phonemes concatenated, all stress secondary, last stress primary, rating 3.
- `get_special_case`: dotted forms like `U.S.` (pieces < 3 letters) also go to get_NNP.
So misaki speaks an all-caps token iff the uppercase form or its lowercase form is a lexicon word;
otherwise it spells it as ONE token. The "T E D" the user heard came from the M1 normalizer
(SPOKEN_ACRONYMS allowlist), not from misaki.
