-- ----------------------------------------------------------------------------
-- test_begin

\set QUIET on
-- ----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION pg_temp.raise_on_errors(errors TEXT)
  RETURNS void LANGUAGE plpgsql AS
$_$
BEGIN
  IF errors <> '' THEN
    RAISE EXCEPTION E'\n%', errors;
  END IF;
END
$_$;
-- ----------------------------------------------------------------------------

\set OUTW '| echo ''```sql'' >> ':TESTOUT' ; cat >> ':TESTOUT' ; echo '';\n```'' >> ':TESTOUT
\set OUTT '| echo -n ''##'' >> ':TESTOUT' ; cat >> ':TESTOUT
-- TODO: use $(AWK)
\set OUTG '| awk ''{ gsub(/--\\+--/, "--|--"); gsub(/^[ |-]/, "|"); print }'' >> ':TESTOUT

\o :TESTOUT
\qecho '# ' :TEST
\o
\pset footer

-- ----------------------------------------------------------------------------
SAVEPOINT package_test;
\set QUIET off
\qecho '# ----------------------------------------------------------------------------'
\qecho '#' :TEST

-- test_begin
-- ----------------------------------------------------------------------------
