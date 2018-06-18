/*
  Tables for stored proc documenting

*/

-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS func_anno(
  code      TEXT PRIMARY KEY
, nspname   NAME NOT NULL
, proname   NAME NOT NULL
, sample    TEXT
);
COMMENT ON TABLE func_anno IS 'Function annotation';

-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS func_arg_anno(
  func_code  TEXT REFERENCES func_anno ON DELETE CASCADE
, is_in BOOL
, code   TEXT
, anno  TEXT
, CONSTRAINT func_arg_anno_pkey PRIMARY KEY (func_code, is_in, code)
);
COMMENT ON TABLE func_arg_anno IS 'Function in/out argument annotation';

-- -----------------------------------------------------------------------------
