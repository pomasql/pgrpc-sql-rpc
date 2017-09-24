/*
  Проверка, что текущая версия в БД не больше той, которую устанавливаем.
  Используется в 'make update'.
*/

DO $$
  BEGIN
    IF package_version() > package_version_new() THEN
      RAISE EXCEPTION 'Newest lib version (%) loaded already', package_version();
    END IF;
  END;
$$;

-- -----------------------------------------------------------------------------
