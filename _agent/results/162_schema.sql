-- sqlite_master dump after alembic upgrade head on an empty file (/private/tmp/claude-502/-Users-sowmyajonnalagadda-Documents-Projects-hearnarro/356b510a-3d2c-414f-9d2b-5b7933bf0436/scratchpad/alembic_empty/hearnarro.db)
-- table alembic_version ON alembic_version
CREATE TABLE alembic_version (
	version_num VARCHAR(32) NOT NULL, 
	CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);
-- index sqlite_autoindex_alembic_version_1 ON alembic_version
-- (implicit autoindex);
-- table documents ON documents
CREATE TABLE documents (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  filename TEXT NOT NULL,
  sha256 TEXT NOT NULL UNIQUE,            -- dedupe re-uploads
  page_count INTEGER,
  status TEXT NOT NULL CHECK (status IN ('uploaded','parsing','ready','failed')),
  fail_reason TEXT,
  voice_id TEXT, speed REAL,              -- per-document settings, NULL = use global
  position_segment_id INTEGER, position_offset_ms INTEGER DEFAULT 0,
  created_at TEXT NOT NULL, last_opened_at TEXT
);
-- index sqlite_autoindex_documents_1 ON documents
-- (implicit autoindex);
-- table blocks ON blocks
CREATE TABLE blocks (
  id INTEGER PRIMARY KEY,
  document_id INTEGER NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  page INTEGER NOT NULL, "order" INTEGER NOT NULL,
  type TEXT NOT NULL,
  x0 REAL, y0 REAL, x1 REAL, y1 REAL,
  merged_text TEXT NOT NULL
);
-- table sections ON sections
CREATE TABLE sections (
  id INTEGER PRIMARY KEY,
  document_id INTEGER NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  title TEXT NOT NULL, level INTEGER NOT NULL, first_segment_id INTEGER
);
-- table segments ON segments
CREATE TABLE segments (
  id INTEGER PRIMARY KEY,
  document_id INTEGER NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  block_id INTEGER NOT NULL REFERENCES blocks(id),
  section_id INTEGER REFERENCES sections(id),
  "order" INTEGER NOT NULL,
  text TEXT NOT NULL, normalized_text TEXT NOT NULL,
  char_start INTEGER NOT NULL, char_end INTEGER NOT NULL,
  char_map BLOB NOT NULL                  -- packed uint16 array
);
-- index segments_doc_order ON segments
CREATE UNIQUE INDEX segments_doc_order ON segments(document_id, "order");
-- table audio_cache ON audio_cache
CREATE TABLE audio_cache (
  segment_id INTEGER NOT NULL REFERENCES segments(id) ON DELETE CASCADE,
  voice_id TEXT NOT NULL, speed REAL NOT NULL, backend TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('ready','failed')),
  path TEXT, duration_ms INTEGER, timestamps_json TEXT,
  created_at TEXT NOT NULL,
  PRIMARY KEY (segment_id, voice_id, speed, backend)
);
-- index sqlite_autoindex_audio_cache_1 ON audio_cache
-- (implicit autoindex);
-- table settings ON settings
CREATE TABLE settings (key TEXT PRIMARY KEY, value TEXT NOT NULL);
-- index sqlite_autoindex_settings_1 ON settings
-- (implicit autoindex);
