local WS = {}
local fs = require('utils.fs')

---Is it a Laravel project
---@return boolean
function WS.is_laravel()
  -- stylua: ignore
  return fs.file_exists('artisan')
end

---Is it a Deno.js project
---@return boolean
function WS.is_deno()
  -- stylua: ignore
  return fs.file_exists('deno.json', 'deno.jsonc', 'deno.lock')
end


return WS
