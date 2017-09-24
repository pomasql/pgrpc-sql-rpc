/*
  Создание схемы БД
  Используется в 'make create'
*/

-- Вывод в логи информации о коннекте
\qecho 'Database: ':HOST':':PORT'@':DBNAME

-- Создание схемы
CREATE SCHEMA IF NOT EXISTS :SCH;
