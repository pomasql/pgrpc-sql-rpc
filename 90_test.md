#  rpc/90_test
## index

```sql
/*
  Тест index
*/
SELECT * FROM rpc.index('rpc')
ORDER BY code ASC
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
ORDER BY arg ASC
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
ORDER BY arg ASC
;
```
|  arg    |  type   |         anno          
|---------|---------|-----------------------
|anno     | text    | Описание
|arg      | text    | Имя аргумента
|def_val  | text    | Значение по умолчанию
|required | boolean | Значение обязательно
|type     | text    | Тип аргумента

## index_result

```sql
/*
  Тест func_result
*/
SELECT * FROM rpc.func_result('index')
ORDER BY arg ASC
;
```
|    arg     |  type   |             anno             
|------------|---------|------------------------------
|anno        | text    | Описание
|code        | text    | Имя процедуры
|is_ro       | boolean | Метод Read-only
|max_age     | integer | Время хранения в кэше(сек)
|nspname     | text    | Имя схемы хранимой процедуры
|permit_code | text    | Код разрешения
|proname     | text    | Имя хранимой функции
|sample      | text    | Пример вызова

