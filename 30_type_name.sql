-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION pg_type_name(a_oid oid) RETURNS TEXT STABLE LANGUAGE 'sql' AS
$_$
  -- a_oid:  OID
  SELECT CASE WHEN nspname = 'pg_catalog' THEN pg_catalog.format_type($1, NULL) ELSE  nspname || '.' || typname END
    FROM (
      SELECT (SELECT nspname FROM pg_namespace WHERE oid = typnamespace) as nspname, typname FROM pg_type WHERE oid = $1
    ) AS pg_type_name_temp
$_$;
