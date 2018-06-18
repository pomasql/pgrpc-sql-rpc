/*
    Ф-и, используемые в представлениях
*/
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION pg_type_name(a_oid oid) RETURNS TEXT STABLE LANGUAGE 'sql' AS
$_$
  --    Ф-я аналогична format_type, но не обрезает схему когда она в пути поиска
  --    TODO: сравнить с вариантом `set local search_path=''; select format_type();`
  SELECT CASE WHEN nspname = 'pg_catalog' THEN pg_catalog.format_type($1, NULL) ELSE  nspname || '.' || typname END
    FROM (
      SELECT (SELECT nspname FROM pg_namespace WHERE oid = typnamespace) as nspname, typname FROM pg_type WHERE oid = $1
    ) AS pg_type_name_temp
$_$;
