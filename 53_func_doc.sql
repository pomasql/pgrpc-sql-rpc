/*
  Functions for stored proc documentation fetching

  TODO: if search_path contains i18n_?? and exists i18n_??.rpc_func_?? - get anno from there
*/

-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION index(a_nsp TEXT DEFAULT NULL) RETURNS TABLE (
  code TEXT
, nspname TEXT
, proname TEXT
, max_age INTEGER
, anno    TEXT
, sample  TEXT
, is_ro   BOOL
) STABLE LANGUAGE 'sql'
SET SEARCH_PATH FROM CURRENT AS
$_$
  SELECT
    code
  , nspname::TEXT
  , proname::TEXT
  , max_age
  , anno
  , sample
  , pg_func_is_ro(nspname, proname) AS is_ro
    FROM func_def
    WHERE a_nsp IS NULL OR nspname = a_nsp
    ORDER BY code
$_$;

SELECT add('index'
, 'Список описаний процедур'
, '{"a_nsp":   "Схема БД"}'
, '{
    "code":    "Имя процедуры"
  , "nspname": "Имя схемы хранимой функции"
  , "proname": "Имя хранимой функции"
  , "max_age": "Время хранения в кэше(сек)"
  , "anno":    "Описание"
  , "sample":  "Пример вызова"
  , "is_ro":   "Метод Read-only"
  }'
,'{}'
);

-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION func_args(a_code TEXT) RETURNS TABLE (
  arg  TEXT
, type TEXT
, required BOOL
, def_val  TEXT
, anno TEXT
) STABLE LANGUAGE 'sql'
SET SEARCH_PATH FROM CURRENT AS
$_$
  WITH q_def (n, p) AS (
    SELECT nspname, proname FROM func_def where code = $1
  )
  SELECT f.arg, type, required, def_val, d.anno
   FROM q_def q, pg_func_args(q.n, q.p) f
   LEFT OUTER JOIN func_arg_def d ON (d.arg = f.arg AND d.code = $1 AND d.is_in)
$_$;

SELECT add('func_args'
, 'Описание аргументов процедуры'
, '{"a_code":   "Имя процедуры"}'
, '{
    "arg":      "Имя аргумента"
  , "type":     "Тип аргумента"
  , "required": "Значение обязательно"
  , "def_val":  "Значение по умолчанию"
  , "anno":     "Описание"
  }'
,'{"a_code": "func_args"}'
);

-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION func_result(a_code TEXT) RETURNS TABLE (
  arg  TEXT
, type TEXT
, anno TEXT
) STABLE LANGUAGE 'sql'
SET SEARCH_PATH FROM CURRENT AS
$_$
  WITH q_def (n, p) AS (
    SELECT nspname, proname FROM func_def where code = $1
  )
  SELECT f.arg, type, d.anno
   FROM q_def q, pg_func_result(q.n, q.p) f
   LEFT OUTER JOIN func_arg_def d ON (d.arg = f.arg AND d.code = $1 AND NOT d.is_in)
$_$;

SELECT add('func_result'
, 'Описание результата процедуры'
, '{"a_code": "Имя процедуры"}'
, '{
    "arg":    "Имя аргумента"
  , "type":   "Тип аргумента"
  , "anno":   "Описание"
  }'
, '{"a_code": "func_args"}'
);
