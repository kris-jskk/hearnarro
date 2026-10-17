# 368 — pronunciation tier coverage on 200 names/terms (US pipeline, final code)

Tier = what the final pipeline uses for the word in 'I like <w> a lot.' (misaki = gold/silver lexicon hit, no fallback call; cmudict = whole word found in vendored cmudict; fallback = misaki pieces / g2p_en / letters).

| brand/company/tech | 100 | misaki 47 | +cmudict 30 | neural/other fallback 23 |
| person/place | 100 | misaki 60 | +cmudict 23 | neural/other fallback 17 |
| total | 200 | misaki 107 | +cmudict 53 | fallback 40 |

Words reaching the fallback (method): Lyft (g2p_en), Airbnb (g2p_en), Huawei (g2p_en), Xiaomi (g2p_en), Shopify (g2p_en), Venmo (g2p_en), TikTok (lexicon+g2p_en), Kubernetes (g2p_en), Golang (g2p_en), Django (g2p_en), PyTorch (g2p_en+lexicon), Redis (g2p_en), Postgres (g2p_en), Nginx (g2p_en), Bitbucket (g2p_en), Jira (g2p_en), Figma (g2p_en), Canva (g2p_en), Trello (g2p_en), Roomba (g2p_en), Fitbit (g2p_en), Garmin (g2p_en), Lenovo (g2p_en), Zelensky (g2p_en), Torvalds (g2p_en), Bezos (g2p_en), Nadella (g2p_en), Pichai (g2p_en), Bengio (g2p_en), LeCun (cmudict+g2p_en), Schmidhuber (g2p_en), Karpathy (g2p_en), Sutskever (g2p_en), Sibelius (g2p_en), Gaudi (g2p_en), Kahlo (g2p_en), Seurat (g2p_en), Botticelli (g2p_en), Kharkiv (g2p_en), Busan (g2p_en) 

Words served by cmudict: Microsoft, Spotify, Uber, Samsung, Sony, Nokia, Dropbox, Snapchat, Pinterest, Reddit, Debian, Haskell, Kafka, Jenkins, Asus, Toshiba, Panasonic, Bosch, Volkswagen, Toyota, Honda, Hyundai, Kia, Subaru, Mazda, Nissan, Porsche, Ferrari, Lamborghini, Bugatti, Merkel, Trudeau, Modi, Putin, Darwin, Lovelace, Knuth, Wozniak, Zuckerberg, Altman, Hinton, Goethe, Dostoevsky, Tolstoy, Cervantes, Beethoven, Mozart, Tchaikovsky, Rachmaninoff, Debussy, Dvorak, Monet, Vermeer 

## g2p_en fallback vs cmudict on 30 words cmudict has and misaki lacks (30 from the list above, 0 random cmudict-only words, seed 0)

| word | cmudict | g2p_en | edits | PER |
|---|---|---|---|---|
| Microsoft | M AY K R OW S AO F T | M AY K R OW S AA F T | 1 | 0.11 |
| Spotify | S P AO T AH F AY | S P AA T AH F AY | 1 | 0.14 |
| Uber | Y UW B ER | Y UW B ER | 0 | 0.00 |
| Samsung | S AE M S AH NG | S AE M S AH NG | 0 | 0.00 |
| Sony | S OW N IY | S OW N IY | 0 | 0.00 |
| Nokia | N OW K IY AH | N OW K Y AH | 1 | 0.20 |
| Dropbox | D R AA P B AA K S | D R AA P B AA K S | 0 | 0.00 |
| Snapchat | S N AE P CH AE T | S N AE P CH AE T | 0 | 0.00 |
| Pinterest | P IH N T R AH S T | P IH N T ER AH S T | 1 | 0.12 |
| Reddit | R EH D IH T | R EH D AH T | 1 | 0.20 |
| Debian | D EH B IY AH N | D EH B IY AH N | 0 | 0.00 |
| Haskell | HH AE S K AH L | HH AE S K AH L | 0 | 0.00 |
| Kafka | K AA F K AH | K AA F K AH | 0 | 0.00 |
| Jenkins | JH EH NG K AH N Z | JH EH NG K AH N Z | 0 | 0.00 |
| Asus | EY S AH S | AH S UW Z | 3 | 0.75 |
| Toshiba | T OW SH IY B AH | T OW SH IY B AH | 0 | 0.00 |
| Panasonic | P AE N AH S AA N IH K | P AE N AH S AA N IH K | 0 | 0.00 |
| Bosch | B AO SH | B AO SH | 0 | 0.00 |
| Volkswagen | V OW L K S W AE G AH N | V OW L K S W AE G AH N | 0 | 0.00 |
| Toyota | T OW Y OW T AH | T OW Y OW T AH | 0 | 0.00 |
| Honda | HH AO N D AH | HH AA N D AH | 1 | 0.20 |
| Hyundai | HH Y AH N D EY | HH Y AH N D EY | 0 | 0.00 |
| Kia | K IY ER | K IY AH | 1 | 0.33 |
| Subaru | S UW B ER UW | S UW B ER UW | 0 | 0.00 |
| Mazda | M AA Z D AH | M AE Z D AH | 1 | 0.20 |
| Nissan | N IY S AA N | N IH S AH N | 2 | 0.40 |
| Porsche | P AO R SH AH | P AO R SH AH | 0 | 0.00 |
| Ferrari | F ER AA R IY | F ER AA R IY | 0 | 0.00 |
| Lamborghini | L AE M B ER G IY N IY | L AA M B AO R G IY N IY | 3 | 0.33 |
| Bugatti | B AH G AA T IY | B UW G AA T IY | 1 | 0.17 |

Phoneme error rate (stress ignored, sum edits / sum ref phonemes): 17/179 = 0.095; exact match 18/30

## ARPAbet->Kokoro mapping (arpabet_to_kokoro) vs misaki gold strings

- about: cmudict AH0 B AW1 T -> `əbˈWt`; misaki gold `əbˈWt`
- computer: cmudict K AH0 M P Y UW1 T ER0 -> `kəmpjˈutəɹ`; misaki gold `kəmpjˈuɾəɹ`
- through: cmudict TH R UW1 -> `θɹˈu`; misaki gold `{'DEFAULT': 'θɹu', 'None': 'θɹˈu'}`
- uber: cmudict Y UW1 B ER0 -> `jˈubəɹ`; misaki gold `ˈubəɹ`

2000 random words in both: identical string 1108/2000; identical ignoring stress marks 1224/2000
Not measured: which differences dominate. Visible in the examples above: misaki writes a flap ɾ for intervocalic T (computer) and its own stress placement; misaki "uber" is the override injected by this branch.
