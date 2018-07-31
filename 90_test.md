#  rpc/90_test
## index

```sql
/*
  Тест index
*/
SELECT * FROM rpc.index('rpc')
;
```
|   code     | nspname |   proname   | permit_code | max_age |             anno              |         sample          | is_ro 
|------------|---------|-------------|-------------|---------|-------------------------------|-------------------------|-------
|func_args   | rpc     | func_args   |             |      -1 | Описание аргументов процедуры | {"a_code": "func_args"} | t
|func_result | rpc     | func_result |             |      -1 | Описание результата процедуры | {"a_code": "func_args"} | t
|index       | rpc     | index       |             |      -1 | Список описаний процедур      | {"a_nsp":"rpc"}         | t

## func_args

```sql
/*
  Тест func_args
*/
SELECT * FROM rpc.func_args('func_args')
;
```
| arg   | type | required | def_val |     anno      
|-------|------|----------|---------|---------------
|a_code | text | t        |         | Имя процедуры

## func_result

```sql
/*
  Тест func_result
*/
SELECT * FROM rpc.func_result('func_args')
;
```
|  arg    |  type   |         anno          
|---------|---------|-----------------------
|arg      | text    | Имя аргумента
|type     | text    | Тип аргумента
|required | boolean | Значение обязательно
|def_val  | text    | Значение по умолчанию
|anno     | text    | Описание

## index_result

```sql
/*
  Тест func_result
*/
SELECT * FROM rpc.func_result('index')
;
```
|    arg     |  type   |             anno             
|------------|---------|------------------------------
|code        | text    | Имя процедуры
|nspname     | text    | Имя схемы хранимой процедуры
|proname     | text    | Имя хранимой функции
|permit_code | text    | Код разрешения
|max_age     | integer | Время хранения в кэше(сек)
|anno        | text    | Описание
|sample      | text    | Пример вызова
|is_ro       | boolean | Метод Read-only

