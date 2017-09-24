/*
  Номер версии схемы, которая будет установлена.

  * если текущая версия >= этой, 'make create' вылетит с ошибкой
  * если текущая версия > этой, 'make update' вылетит с ошибкой

*/
CREATE OR REPLACE FUNCTION package_version_new() RETURNS DECIMAL IMMUTABLE LANGUAGE 'sql' AS
$_$
  SELECT 0.1; -- new version
$_$;
