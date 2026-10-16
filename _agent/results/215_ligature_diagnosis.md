# 215 Ligature diagnosis (The 3 Alarms, user PDF)

Raw runs: _agent/results/215_ligature_diag_raw.txt

- Page 3 (contents) "Ful!lled": the "!" char is font OWWTZB+Fanwood, a TrueType subset with
  FirstChar=LastChar=33 and a ToUnicode CMap `<21><21><0021>`, i.e. the PDF itself maps the glyph to "!".
- PDFium (`get_text_range`) reads the same "Ful!lled"; on the 77 pages with in-word suspicious
  chars it returns 143 in-word "[!#$%&]" hits. So approach (a), aligning against PDFium, gains nothing.
- Approach (b) with a fixed table ("#"->ff, "$"->fl) is wrong: the mapping differs per font.
  Contexts per (font, char) show e.g. VJDUTB "!"=fl ("!ight"), "#"=fi ("#rst"), "$"=ff ("o$er"),
  "%"=ffi ("o%ce"); IOZYJT "!"=ffi, "#"=ff, "$"=fl, "%"=fi; DEJGMZ "%"=fl, "$"=ffb ("o$eat" = offbeat).
- The embedded font programs (FontFile2) keep glyph names in a format-2 post table:
  OWWTZB [.notdef, f_i]; VJDUTB [.notdef, uni2010, f_i, f_l, f_f, f_f_i]; DEJGMZ codes
  {33: f_i, 34: uni2010, 35: f_f, 36: f_f_b, 37: f_l}.

Chosen fix (neither (a) nor (b)): in stage 1, per simple TrueType font, map char code -> glyph id
through the font program's cmap, glyph id -> name through post; a ligature glyph name whose
ToUnicode text is one ASCII punctuation char replaces that char's text. Exact, no guessing between
fi and ffi; real "!" glyphs (width 0.26 em, other fonts) are untouched.
Result on the book's segments: 106 in-word artifacts before, 0 after (219_alarms_after.txt).
