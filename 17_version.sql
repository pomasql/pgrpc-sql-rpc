/*
  Проверка, что текущая версия в БД меньше той, которую устанавливаем.
  Используется в 'make create'.
*/

DO $$
  BEGIN
    IF EXISTS(SELECT 1
      FROM pg_proc p JOIN pg_namespace n on n.oid = p.pronamespace 
      WHERE n.nspname = current_schema() AND p.proname = 'package_version'
      ) THEN
      -- вызывем package_version, если она есть
      IF package_version() >= package_version_new() THEN
        RAISE EXCEPTION 'Newest lib version (%) loaded already', package_version();
      END IF;
    ELSE
      -- схема еще пустая, создаем 0ю версию
      CREATE OR REPLACE FUNCTION package_version() RETURNS DECIMAL IMMUTABLE LANGUAGE 'sql' AS
      $_$
        SELECT 0.0;
      $_$;
    END IF;
  END;
$$;

-- -----------------------------------------------------------------------------
