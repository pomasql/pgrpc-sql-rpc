-- ----------------------------------------------------------------------------
-- test_end

\set QUIET on

ROLLBACK TO SAVEPOINT package_test;
\set ERRORS `cat build/errors.diff`
\pset t on
SELECT pg_temp.raise_on_errors(:'ERRORS');
\pset t off
\set QUIET off

-- test_end
-- ----------------------------------------------------------------------------
