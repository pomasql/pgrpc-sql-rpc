#  rpc/90_test
## index

```sql
/*
  Тест index
  метод rpc.index может отсутствовать, если переназначен в другом пакете
*/
SELECT * FROM rpc.index('rpc') WHERE code <> 'index' ORDER BY code
;
```
|   code     | nspname |   proname   | is_set | is_ro | is_struct | result |             anno              |         sample          
|------------|---------|-------------|--------|-------|-----------|--------|-------------------------------|-------------------------
|func_args   | rpc     | func_args   | t      | t     | t         |        | Описание аргументов процедуры | {"a_code": "func_args"}
|func_result | rpc     | func_result | t      | t     | t         |        | Описание результата процедуры | {"a_code": "func_args"}

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
SELECT * FROM rpc.func_result('func_args') ORDER BY arg
;
```
|  arg    |  type   |         anno          
|---------|---------|-----------------------
|anno     | text    | Описание
|arg      | text    | Имя аргумента
|def_val  | text    | Значение по умолчанию
|required | boolean | Значение обязательно
|type     | text    | Тип аргумента

