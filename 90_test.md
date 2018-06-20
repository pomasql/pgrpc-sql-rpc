#  rpc/90_test
## rpc/90_test

```sql
/*
  Тест index
*/
SELECT * FROM rpc.index('rpc')
;
```
|   code     | nspname |   proname   | is_set | is_ro | is_struct |    result    |             anno              |         sample          
|------------|---------|-------------|--------|-------|-----------|--------------|-------------------------------|-------------------------
|func_args   | rpc     | func_args   | t      | t     | t         |              | Описание аргументов процедуры | {"a_code": "func_args"}
|func_result | rpc     | func_result | t      | t     | t         |              | Описание результата процедуры | {"a_code": "func_args"}
|index       | rpc     | index       | t      | t     | t         | rpc.func_def | Список описаний процедур      | 

## rpc/90_test

```sql
/*
  Тест func_args
*/
SELECT * FROM rpc.func_args('func_args')
;
```
| code  | type | required | def_val |     anno      
|-------|------|----------|---------|---------------
|a_code | text | t        |         | Имя процедуры

## rpc/90_test

```sql
/*
  Тест func_result
*/
SELECT * FROM rpc.func_result('func_args')
;
```
|  code   |  type   |         anno          
|---------|---------|-----------------------
|code     | text    | Имя аргумента
|type     | text    | Тип аргумента
|required | boolean | Значение обязательно
|def_val  | text    | Значение по умолчанию
|anno     | text    | Описание

## rpc/90_test

```sql
/*
  Тест func_result
*/
SELECT * FROM rpc.func_result('index')
;
```
|  code    |  type   |             anno              
|----------|---------|-------------------------------
|code      | text    | Имя процедуры
|nspname   | name    | Имя схемы хранимой функции
|proname   | name    | Имя хранимой функции
|is_set    | boolean | Метод возвращает 0..N строк
|is_ro     | boolean | Метод Read-only
|is_struct | boolean | Результат является структурой
|result    | text    | Имя типа результата
|anno      | text    | Описание
|sample    | text    | Пример вызова

