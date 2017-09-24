

-- ----------------------------------------------------------------------------

DO $$
BEGIN
	IF package_version() < 0.1 THEN
		CREATE OR REPLACE FUNCTION package_version() RETURNS DECIMAL IMMUTABLE LANGUAGE 'sql' AS
		$_$
		  SELECT 0.1;
		$_$;

	END IF;
END;
$$;
