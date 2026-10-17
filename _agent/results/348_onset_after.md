# 348 onset before/after the fix (BOS floored at its speed-1.0 duration)

Script: /private/tmp/claude-502/-Users-sowmyajonnalagadda-Documents-Projects-hearnarro/356b510a-3d2c-414f-9d2b-5b7933bf0436/scratchpad/onset/resynth.py (raw rows resynth.jsonl). 'before' = git-stashed kokoro_backend.py (main), 'after' = branch m2-fix-first-word. torch.manual_seed(0) before each call. 2.5 = native 2.0 + stretch_pcm(1.25) + scale_timestamps, as service._render does. w0_rms = RMS dBFS over the first word's timestamp window; vs_1x = minus the same sentence's 1.0 value.

| sent | first word | speed | before len | before onset | before word0 | before onset-start | before vs_1x dB | after len | after onset | after word0 | after onset-start | after vs_1x dB |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | On | 1.0 | 4450 | 316.7 | 325-425 | -8.3 | +0.0 | 4450 | 316.7 | 325-425 | -8.3 | +0.0 |
| 0 | On | 1.5 | 2925 | 255.7 | 225-300 | +30.7 | -9.7 | 3025 | 304.1 | 325-400 | -20.9 | -1.1 |
| 0 | On | 2.0 | 2475 | 248.5 | 175-250 | +73.5 | -35.1 | 2625 | 303.6 | 325-400 | -21.4 | -1.0 |
| 0 | On | 2.5 | 1980 | 195.9 | 140-200 | +55.9 | -33.2 | 2100 | 244.6 | 260-320 | -15.4 | -1.5 |
| 1 | We | 1.0 | 11350 | 314.8 | 325-450 | -10.2 | +0.0 | 11350 | 314.8 | 325-450 | -10.2 | +0.0 |
| 1 | We | 1.5 | 7250 | 249.3 | 225-300 | +24.3 | -8.8 | 7350 | 310.4 | 325-400 | -14.6 | +0.0 |
| 1 | We | 2.0 | 6250 | 287.4 | 175-250 | +112.4 | -46.4 | 6400 | 312.9 | 325-400 | -12.1 | -0.2 |
| 1 | We | 2.5 | 5000 | 231.8 | 140-200 | +91.8 | -52.4 | 5120 | 246.3 | 260-320 | -13.7 | +0.6 |
| 2 | Xi’an | 1.0 | 10000 | 314.6 | 375-675 | -60.4 | +0.0 | 10000 | 314.6 | 375-675 | -60.4 | +0.0 |
| 2 | Xi’an | 1.5 | 6425 | 282.1 | 250-450 | +32.1 | -2.8 | 6550 | 313.1 | 375-575 | -61.9 | +0.9 |
| 2 | Xi’an | 2.0 | 5175 | 283.4 | 200-325 | +83.4 | -19.4 | 5350 | 327.0 | 375-500 | -48.0 | +0.7 |
| 2 | Xi’an | 2.5 | 4140 | 231.3 | 160-260 | +71.3 | -26.2 | 4280 | 258.0 | 300-400 | -42.0 | +1.3 |
| 3 | Weight | 1.0 | 8950 | 334.5 | 375-600 | -40.5 | +0.0 | 8950 | 334.5 | 375-600 | -40.5 | +0.0 |
| 3 | Weight | 1.5 | 5725 | 257.5 | 250-400 | +7.5 | -5.5 | 5850 | 329.6 | 375-525 | -45.4 | -0.6 |
| 3 | Weight | 2.0 | 4850 | 271.5 | 175-275 | +96.5 | -32.9 | 5050 | 337.5 | 375-475 | -37.5 | -3.6 |
| 3 | Weight | 2.5 | 3880 | 220.1 | 140-220 | +80.1 | -48.2 | 4040 | 269.2 | 300-380 | -30.8 | -2.0 |
| 4 | That | 1.0 | 8100 | 334.0 | 350-575 | -16.0 | +0.0 | 8100 | 334.0 | 350-575 | -16.0 | +0.0 |
| 4 | That | 1.5 | 5125 | 237.6 | 225-350 | +12.6 | -10.2 | 5250 | 324.5 | 350-475 | -25.5 | +0.8 |
| 4 | That | 2.0 | 4325 | 277.1 | 175-300 | +102.1 | -21.4 | 4500 | 324.5 | 350-475 | -25.5 | -0.1 |
| 4 | That | 2.5 | 3460 | 229.5 | 140-240 | +89.5 | -23.6 | 3600 | 255.4 | 280-380 | -24.6 | +0.7 |

Written files (re-read from disk):
- /Users/sowmyajonnalagadda/hearnarro-m1/audio_samples/almanack_axioms_2.0x_fixed.wav: sr 24000, {'len_ms': 2625, 'rms50': np.float64(-180.0), 'rms100': np.float64(-180.0), 'rms200': np.float64(-180.0), 'onset_ms': np.float64(303.6)}
- /Users/sowmyajonnalagadda/hearnarro-m1/audio_samples/almanack_axioms_2.5x_fixed.wav: sr 24000, {'len_ms': 2100, 'rms50': np.float64(-180.0), 'rms100': np.float64(-180.0), 'rms200': np.float64(-83.5), 'onset_ms': np.float64(244.6)}
