#  90_test
## index

```sql
SELECT * FROM index('rpc')
;
```
|   code     | nspname |   proname   | max_age |             anno              |         sample          | is_ro 
|------------|---------|-------------|---------|-------------------------------|-------------------------|-------
|func_args   | rpc     | func_args   |       0 | Описание аргументов процедуры | {"a_code": "func_args"} | t
|func_result | rpc     | func_result |       0 | Описание результата процедуры | {"a_code": "func_args"} | t
|index       | rpc     | index       |       0 | Список описаний процедур      | {}                      | t

## func_args

```sql
SELECT * FROM rpc.func_args('func_args')
;
```
| arg   | type | required | def_val |     anno      
|-------|------|----------|---------|---------------
|a_code | text | t        |         | Имя процедуры

## func_result

```sql
SELECT * FROM rpc.func_result('func_args')
;
```
|  arg    |  type   |         anno          
|---------|---------|-----------------------
|         | TABLE   | 
|arg      | text    | Имя аргумента
|type     | text    | Тип аргумента
|required | boolean | Значение обязательно
|def_val  | text    | Значение по умолчанию
|anno     | text    | Описание

