
-- ----------------------------------------------------------------------------
\set NAME 'index' -- BOT
SELECT * FROM rpc.index(:'PKG'); -- EOT

-- ----------------------------------------------------------------------------
\set NAME 'func_args' -- BOT
SELECT * FROM rpc.func_args('func_args'); -- EOT

-- ----------------------------------------------------------------------------
\set NAME 'func_result' -- BOT
SELECT * FROM rpc.func_result('func_args'); -- EOT
