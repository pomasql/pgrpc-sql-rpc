/*
  Functions for stored proc documentation fetching

  TODO: if search_path contains i18n_?? and exists i18n_??.rpc_func_?? - get anno from there
*/

-- -----------------------------------------------------------------------------

/*
CREATE OR REPLACE FUNCTION index(a_nsp TEXT DEFAULT NULL) RETURNS SETOF func_def
  STABLE LANGUAGE 'sql'
SET SEARCH_PATH FROM CURRENT AS
$_$
  SELECT *
    FROM func_def
    WHERE a_nsp IS NULL OR nspname = a_nsp
    ORDER BY code
$_$;

SELECT add('index', 'Список описаний процедур'
, '{"a_nsp":   "Схема БД"}'
);
*/

-- ----------------------------------------------------------------------------
-- Функция заменяет pomasql/rpc.index(). Формат выходных данных приведен 
-- к iac/rpc.index(). 

CREATE OR REPLACE FUNCTION index(a_nsp TEXT DEFAULT NULL) RETURNS TABLE (
  code        TEXT
, nspname     TEXT
, proname     TEXT
, permit_code TEXT
, max_age     INTEGER
, anno        TEXT
, sample      TEXT
, is_ro       BOOL
) STABLE LANGUAGE 'sql' AS
$_$
  SELECT 
    r.code
  , CAST(r.nspname as TEXT) as nspname 
  , CAST(r.proname as TEXT) as proname
  , CAST(NULL as TEXT) as permit_code
  , -1 as max_age 
  , r.anno
  , r.sample
  , r.is_ro
  FROM func_def r
  WHERE a_nsp IS NULL OR r.nspname = a_nsp
  ORDER BY r.code
$_$;

SELECT rpc.add('index', 'Список описаний процедур'
, '{"a_nsp":"Код подсистемы"}'
, a_result := '{  
      "code":"Имя процедуры"
    , "nspname":"Имя схемы хранимой процедуры"
    , "proname":"Имя хранимой функции"
    , "permit_code":"Код разрешения"
    , "max_age":"Время хранения в кэше(сек)"
    , "anno":"Описание"
    , "sample":"Пример вызова"
    , "is_ro":"Метод Read-only"
    }'
, a_sample := '{"a_nsp":"rpc"}'
);

-- ----------------------------------------------------------------------------
-- Функция отсутствует в pomasql/rpc

CREATE OR REPLACE FUNCTION on_begin(a_lang TEXT DEFAULT '', a_tz TEXT DEFAULT '') RETURNS VOID VOLATILE LANGUAGE 'plpgsql' AS
$_$
  -- a_path: путь поиска
  DECLARE
    v_sql TEXT;
    v_tz       TEXT;
    v_lang     TEXT;
    v_path_old TEXT;
    v_path_new TEXT;
  BEGIN
    SET LOCAL datestyle = 'german';

    v_tz := COALESCE(NULLIF(a_tz, ''), 'Asia/Tashkent');
    v_sql := 'SET LOCAL timezone = ' || quote_literal(v_tz);
    EXECUTE v_sql;
    RAISE DEBUG 'SET TZ = %', v_tz;
    v_lang := COALESCE(NULLIF(NULLIF(a_lang,''), 'ru'), 'base');
    EXECUTE 'SHOW search_path' INTO v_path_old;
    IF v_path_old ~ E'i18n_\\w+' THEN
      v_path_new := regexp_replace(v_path_old, E'i18n_\\w+', 'i18n_' || v_lang);
    ELSE
      v_path_new := 'i18n_' || v_lang || ', '|| v_path_old;
    END IF;

    RAISE DEBUG 'SET SEARCH = %', v_path_new;
    v_sql := 'SET LOCAL search_path = ' || v_path_new;
    EXECUTE v_sql;
  END;
$_$;

-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION func_args(a_code TEXT) RETURNS TABLE (
  arg     TEXT
, type     TEXT
, required BOOL
, def_val  TEXT
, anno     TEXT
) STABLE LANGUAGE 'sql'
SET SEARCH_PATH FROM CURRENT AS
$_$
  WITH q_def (n, p) AS (
    SELECT nspname, proname FROM func_def where code = $1
  )
  SELECT f.arg, type, required, def_val, d.anno
   FROM q_def q, pg_func_args(q.n, q.p) f
   LEFT OUTER JOIN func_arg_anno d ON (d.code = f.arg AND d.func_code = $1 AND d.is_in)
$_$;

SELECT add('func_args', 'Описание аргументов процедуры'
, '{"a_code":   "Имя процедуры"}'
, a_result := '{
    "arg":     "Имя аргумента"
  , "type":     "Тип аргумента"
  , "required": "Значение обязательно"
  , "def_val":  "Значение по умолчанию"
  , "anno":     "Описание"
  }'
, a_sample := '{"a_code": "func_args"}'
);

-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION func_result(a_code TEXT) RETURNS TABLE (
  arg TEXT
, type TEXT
, anno TEXT
) STABLE LANGUAGE 'sql'
SET SEARCH_PATH FROM CURRENT AS
$_$
  WITH q_def (n, p) AS (
    SELECT nspname, proname FROM func_anno where code = $1
  )
  SELECT f.arg, f.type, COALESCE(d.anno, f.comment)
   FROM q_def q, pg_func_result(q.n, q.p) f
   LEFT OUTER JOIN func_arg_anno d ON (d.code = f.arg AND d.func_code = $1 AND NOT d.is_in)
$_$;

SELECT add('func_result', 'Описание результата процедуры'
, '{"a_code": "Имя процедуры"}'
, a_result := '{
    "arg":   "Имя аргумента"
  , "type":   "Тип аргумента"
  , "anno":   "Описание"
  }'
, a_sample := '{"a_code": "func_args"}'
);
