# 90 Prior-art survey: PDF reading order / layout analysis (task m1-prior-art-survey)

Method: WebFetch of PyPI/GitHub/HF pages (summarised by a small model, so quotes are second-hand; items marked UNVERIFIED were not confirmed on the primary license file). No recommendation. Budget 35 calls.

## Claim 1: PyMuPDF license
PyMuPDF is "Dual Licensed - GNU AFFERO GPL 3.0 or Artifex Commercial License". AGPL-3.0 is NOT Apache/MIT/BSD, so it does NOT satisfy the project rule unless a paid Artifex commercial licence is bought. https://pypi.org/project/PyMuPDF/
(Note for supervisor: this affects the current extractor choice in PRD. Raised as a fact, not a recommendation.)

## Table
| Name | Code license | Model license | CPU-only | Needs model download | Output shape | Two-column handling | Benchmark | URL |
|---|---|---|---|---|---|---|---|---|
| PyMuPDF | AGPL-3.0 or Artifex commercial | none | yes | no | text blocks/words/spans with bbox; no types | `sort=True` sorts "top-left to bottom-right"; docs say nothing on multi-column; docs say the "blocks" output is a way to build your own reading order | none | https://pymupdf.readthedocs.io/en/latest/recipes-text.html ; https://pypi.org/project/PyMuPDF/ |
| pymupdf4llm | AGPL-3.0 or commercial | n/a | yes ("No GPU") | layout add-on: UNVERIFIED | Markdown/JSON/TXT; JSON has bbox + layout data per element | feature list: "Reconstructs natural reading order across single and multi-column pages"; forum bug: scrambled two-column paper with pymupdf4llm 0.2.9 + pymupdf-layout 1.26.6, maintainer says fixed in pymupdf4llm 0.3.0 | none | https://pypi.org/project/pymupdf4llm/ ; https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/index.html ; https://forum.mupdf.com/t/bug-double-column-pdfs-text-extracted-in-wrong-order/265 |
| pymupdf-layout | "Other/Proprietary (Dual: AGPL-3.0 or Artifex Commercial)" | GNN models trained on PDF internals; licence not stated | "CPU-only. No GPU required." | not stated | semantic types: title, heading, header, footer, table, image; header/footer detection; Markdown/JSON/TXT | reading order not mentioned on PyPI page | vendor claim of 10x speed vs vision tools only | https://pypi.org/project/pymupdf-layout/ |
| pdfplumber | MIT | none | yes | no | words/chars with bbox; no block types (layout objects only via laparams) | `layout=True` experimental, README does not address columns; `use_text_flow` "order does not always appear to be logical"; README suggests cropping the page | none | https://github.com/jsvine/pdfplumber |
| pdfminer.six | MIT | none | yes | no | LTTextBox/line/char with bbox and font; has automatic layout analysis | README silent on columns (LAParams docs not fetched: UNVERIFIED) | none | https://github.com/pdfminer/pdfminer.six |
| pypdfium2 | Apache-2.0 / BSD-3-Clause (PDFium BSD-style) | none | yes | no | text by region/index, page objects with bounds; README does not mention reading order or char boxes | none (no layout analysis) | none | https://github.com/pypdfium2-team/pypdfium2 |
| pdftext (datalab) | Apache-2.0 | none | yes | no | JSON pages > blocks (~paragraph) > lines > spans, all with bbox; optional chars | `--sort` "will attempt to sort in reading order"; no documented column detection; heuristic block grouping | none | https://github.com/datalab-to/pdftext |
| Docling (IBM) | MIT | layout model docling-layout-heron: Apache-2.0 (HF tag, 42.9M params); docling-models repo tagged cdla-permissive-2.0; TableFormer licence not confirmed (UNVERIFIED) | not stated on PyPI; PyTorch model, small | yes (HF) | DoclingDocument: reading order, layout, tables; 17 label classes; bbox not confirmed on PyPI page | reading order listed as capability; no two-column eval found | tech report arXiv 2509.11720 (heron) not read; Marker README: docling 50.3 overall olmocr-bench (GPU) | https://pypi.org/project/docling/ ; https://huggingface.co/docling-project/docling-layout-heron ; https://arxiv.org/html/2408.09869v5 |
| unstructured | Apache-2.0 | hi_res uses detectron2/yolox: licences UNVERIFIED | fast strategy yes; hi_res UNVERIFIED | hi_res yes | typed elements; coordinates not confirmed | not in README | none | https://github.com/Unstructured-IO/unstructured |
| LayoutParser | Apache-2.0 | model zoo licences UNVERIFIED | needs detectron2 for some models | yes | boxes + classes only; no reading order | none; repo shows no releases, maintenance unclear | none | https://github.com/Layout-Parser/layout-parser |
| PaddleOCR (PP-StructureV3 / PP-DocLayoutV3) | Apache-2.0 | PP-DocLayoutV3 weights Apache-2.0 (HF card); other Paddle models UNVERIFIED | Intel CPU supported | yes | layout boxes, 25 classes, text/table cell coordinates | PP-DocLayoutV3 predicts reading order inside the detector; layout detection only (no text) | PaddleOCR-VL-1.5 94.5%, VL-1.6 96.3% OmniDocBench (overall, not reading order) | https://github.com/PaddlePaddle/PaddleOCR ; https://huggingface.co/PaddlePaddle/PP-DocLayoutV3 |
| MinerU | "MinerU Open Source License": Apache-2.0 plus conditions: licence needed above 100M MAU or USD 20M monthly revenue; online services must display attribution; licence terminates on breach | models: licences not stated on README (UNVERIFIED); uses PaddleOCR, pypdfium2 etc. | yes (ONNX CPU; 8 GB RAM min) | yes | structured blocks | reading order method not described | OmniDocBench Read Order Edit (lower better): MinerU-Pipeline 0.153, Marker 0.243 | https://github.com/opendatalab/MinerU ; https://raw.githubusercontent.com/opendatalab/MinerU/master/LICENSE.md ; https://github.com/opendatalab/OmniDocBench |
| Marker | Apache-2.0 (code) | weights: modified AI Pubs Open RAIL-M, free only for research/personal/startups under $5M funding/revenue | yes (fast mode CPU) | yes | JSON blocks: id, block_type, html, polygon, children; md/html/chunks | olmocr-bench "Multi column": 76.6 balanced, 76.0 fast, 67.0 no-OCR | olmocr-bench overall 76.0 (balanced GPU), 43.6 (fast no OCR CPU) | https://github.com/datalab-to/marker |
| Surya | Apache-2.0 (code) | weights: same modified Open RAIL-M ($5M cap) | CPU/Apple via llama.cpp | yes | layout with `position` = 0-indexed reading order | olmOCR MultCol 82.4 (end-to-end, not reading order) | no standalone layout/RO numbers | https://github.com/datalab-to/surya |
| Nougat | MIT | weights CC-BY-NC | GPU optional | yes | .mmd markup only, no bboxes | n/a | none read | https://github.com/facebookresearch/nougat |
| GROBID | Apache-2.0 | CRF default (trained in repo); DL optional | yes (CRF default); needs Java 21, Linux/macOS | no for CRF | TEI XML with PDF coordinates | README silent on columns | reference extraction F1 about .87 (not reading order) | https://github.com/grobid/grobid |
| Kreuzberg | MIT | PP-DocLayout-V3, RT-DETR, TATR, SLANet named; model licences/download source not stated (UNVERIFIED) | "CPU by default" | probably (UNVERIFIED) | md/JSON/HTML/etc.; "reconstruct reading order" via ML | not evaluated | none | https://github.com/kreuzberg-dev/kreuzberg |
| DocLayout-YOLO | AGPL-3.0 | weights licence not stated | cpu setting supported | yes | boxes + classes, no reading order | none | DocLayNet mAP 77.7-79.7 | https://github.com/opendatalab/DocLayout-YOLO |
| LayoutReader / ReadingBank (Microsoft) | repo licence not named on page (UNVERIFIED) | layoutreader-base on HF; ReadingBank dataset licence not stated | README assumes GPUs | yes | reorders given word boxes (needs OCR boxes as input) | reading-order model for words | Avg page BLEU 0.9819, ARD 1.75 vs heuristic baseline 0.6972 / 8.46 (ReadingBank; not scientific-PDF specific) | https://github.com/microsoft/unilm/tree/master/layoutreader |

## Claim 3: permissive end to end (code AND models, as far as verified)
- pdfplumber (MIT, no models)
- pdfminer.six (MIT, no models)
- pypdfium2 (Apache-2.0 / BSD-3, no models)
- pdftext (Apache-2.0, built on pypdfium2, no models)
- GROBID (Apache-2.0; CRF models ship with it; Java 21 service)
- PP-DocLayoutV3 via PaddleOCR (Apache-2.0 code and Apache-2.0 weights per HF card; layout+reading order only)
- Docling layout path: MIT code + docling-layout-heron Apache-2.0 (TableFormer / docling-models cdla-permissive-2.0 is permissive-style but not Apache/MIT/BSD by name: supervisor to judge)
- Kreuzberg (MIT code; model licences UNVERIFIED)
- unstructured / LayoutParser (Apache-2.0 code; model licences UNVERIFIED)

## Not allowed (as verified) and why
- PyMuPDF, pymupdf4llm, pymupdf-layout: AGPL-3.0 / Artifex commercial (copyleft). 
- DocLayout-YOLO: AGPL-3.0.
- Marker and Surya weights: modified Open RAIL-M, commercial use restricted above $5M (code is Apache-2.0 but weights fail).
- Nougat: weights CC-BY-NC.
- MinerU: Apache-2.0 plus extra conditions (revenue/MAU thresholds, attribution, auto-termination); not plain Apache-2.0, supervisor to judge.
- OmniDocBench dataset: README says research purposes only, not commercial (benchmark use only, not shipped).

## Claim 4: benchmark numbers (URLs)
- OmniDocBench Read Order Edit distance: MinerU-Pipeline 0.153, Marker 0.243; Docling not listed. https://github.com/opendatalab/OmniDocBench
- olmocr-bench (Marker README), overall / born-digital / "Multi column": Marker balanced GPU 76.0/83.5/76.6; MinerU pipeline GPU 72.7/83.3 (no multi-col given); docling GPU 50.3/64.0; Marker fast no OCR CPU 43.6/55.8/67.0. https://github.com/datalab-to/marker
- Surya olmOCR-bench: MultCol 82.4, Hdr/Ftr 92.5. https://github.com/datalab-to/surya
- ReadingBank/LayoutReader: BLEU 0.9819, ARD 1.75. https://github.com/microsoft/unilm/tree/master/layoutreader
- No reading-order number found specifically for two-column scientific PDFs for pdfplumber, pdfminer, PyMuPDF, pdftext, GROBID. Docling reading-order eval not found (tech report evaluation section not read).

## Claim 5: sort / layout modes on two-column papers
- PyMuPDF `get_text(sort=True)`: docs only say it sorts "top-left to bottom-right"; docs do not mention multi-column; the recipe page tells users to build ordering from "blocks" themselves. https://pymupdf.readthedocs.io/en/latest/recipes-text.html . Search snippets (secondary, UNVERIFIED) say position sorting interleaves columns.
- pymupdf4llm: lists multi-column support; a forum bug shows a scrambled two-column paper with the layout add-on (plain pymupdf reportedly fine, options unspecified); a maintainer said fixed in pymupdf4llm 0.3.0. https://forum.mupdf.com/t/bug-double-column-pdfs-text-extracted-in-wrong-order/265
- pdfplumber `layout=True`: experimental, no column handling documented; recommends cropping. https://github.com/jsvine/pdfplumber
- PyMuPDF discussion 2259 is about header/footer removal, not columns (checked, not useful).

## Not done / unverified
- Primary LICENSE files not fetched for most rows (PyPI/README summaries used).
- Docling TableFormer licence, unstructured hi_res model licences, Kreuzberg model licences, pdfminer LAParams column behaviour, LayoutReader repo licence, Docling reading-order numbers.
