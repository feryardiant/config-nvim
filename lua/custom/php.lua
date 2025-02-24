---@class PHP
local PHP = {}
local util = require('util')

---Is it a Laravel project
---@return boolean
function PHP.is_laravel() return util.file_exists('artisan') end

---Retrieve route file
---@return string?
function PHP.route_file()
  local try_files = {
    'server.php',
    'vendor/laravel/framework/src/Illuminate/Foundation/resources/server.php',
  }

  for _, file in ipairs(try_files) do
    if util.file_exists(file) then return file end
  end

  return nil
end

return PHP
