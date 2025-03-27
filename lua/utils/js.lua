---@class JS
local JS = {}
local fs = require('custom.fs')

---Is it a Deno.js project
---@return boolean
function JS.is_deno()
  -- stylua: ignore
  return fs.file_exists('deno.json', 'deno.jsonc', 'deno.lock')
end

return JS
