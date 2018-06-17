/*
    Тесты
*/

-- -----------------------------------------------------------------------------
SELECT poma.test('index'); -- BOT
/*
  Тест index
*/
SELECT * FROM rpc.index(:'PKG'); -- EOT

-- -----------------------------------------------------------------------------
SELECT poma.test('func_args'); -- BOT
/*
  Тест func_args
*/
SELECT * FROM rpc.func_args('func_args'); -- EOT

-- -----------------------------------------------------------------------------
SELECT poma.test('func_result'); -- BOT
/*
  Тест func_result
*/
SELECT * FROM rpc.func_result('func_args'); -- EOT

-- -----------------------------------------------------------------------------
SELECT poma.test('index_result'); -- BOT
/*
  Тест func_result
*/
SELECT * FROM rpc.func_result('index'); -- EOT
