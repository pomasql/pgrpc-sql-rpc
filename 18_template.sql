/*
  PgRPC-SQL project.
  Copyright (c) 2017 Alexey Kovrizhkin <lekovr@gmail.com>
  This code is licensed under the terms of the MIT license.


  Этот файл взят из проекта pgrpc-sql.
  Если хотите изменить его, пожалуйста, сделайте Pull request к оригинальному проекту и после его
  приемки обновите свой репозиторий. Подробнее - см. UPSTREAM.md

*/
CREATE OR REPLACE FUNCTION template(tmpl TEXT, vars JSONB) RETURNS TEXT IMMUTABLE LANGUAGE 'plpgsql' AS
$_$
DECLARE
  r RECORD;
BEGIN
  FOR r IN SELECT * from jsonb_each_text(vars) LOOP
    tmpl := regexp_replace(tmpl,'{{\s*' || r.key || '\s*}}', r.value);
  END LOOP;
  RETURN tmpl;
END;
$_$;
COMMENT ON FUNCTION template(TEXT, JSONB) IS 'Простой шаблонизатор для вывода сообщений об ошибках';

/*
SELECT template('{{ name}}, you win {{win}}!', '{"name":"John", "win":12345}');

       template
----------------------
 John, you win 12345!

*/
