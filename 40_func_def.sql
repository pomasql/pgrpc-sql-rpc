/*
  Stored function attributes

*/

CREATE OR REPLACE VIEW func_def AS
  SELECT fa.*
-- TODO: use func comment as anno (TODO2: i18n)
		, p.proretset AS is_set
		, p.provolatile <> 'v' AS is_ro
		, true AS is_struct
		, NULLIF(pg_type_name(p.prorettype),'record') AS result
	  FROM func_anno fa
	  JOIN pg_namespace n ON (n.nspname = fa.nspname)
	  JOIN pg_catalog.pg_proc p ON (p.pronamespace = n.oid AND p.proname = fa.proname)
	  ORDER BY 1
;
