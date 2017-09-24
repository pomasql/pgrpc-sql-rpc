-- ----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION error_object(
  a_code    TEXT
, a_message TEXT
, a_vars    JSONB DEFAULT NULL
) RETURNS JSON IMMUTABLE LANGUAGE 'sql' AS
$_$
  SELECT json_build_object(
    'code',    a_code
  , 'message', template(a_message, a_vars)
  , 'data',    a_vars
  );
$_$;
