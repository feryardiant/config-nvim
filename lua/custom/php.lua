---@class PHP
local PHP = {}
local util = require('util')

---Is it a Laravel project
---@return boolean
function PHP.is_laravel() return util.file_exists('artisan') end

---Retrieve xdebug port
---@return number
function PHP.xdebug_port()
  local output = PHP.exec('ini_get("xdebug.client_port")')

  -- Default xdebug port
  return tonumber(output) or 9003
end

---Run php script as you commonly use `php -r "echo ..."`
---@param arg string
---@return string
function PHP.exec(arg)
  local co = coroutine.create(function()
    local args = { 'php', '-r', string.format("'echo %s;'", arg) }
    local result = assert(io.popen(table.concat(args, ' '), 'r'))
    local output = result:read('*a')

    coroutine.yield(output)

    result:close()
  end)

  local _, value = coroutine.resume(co)

  return value
end

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

local _class_name_caches = {}

---Retrieve basename of a class
---@param class_name string
function PHP.class_basename(class_name)
  if _class_name_caches[class_name] ~= nil then
    return _class_name_caches[class_name]
  end

  local parts = {}
  local pos = 0

  while true do
    ---@diagnostic disable-next-line: cast-local-type
    pos = string.find(class_name, '\\', pos+1)
    if pos == nil then break end
    table.insert(parts, pos)
  end

  _class_name_caches[class_name] = class_name:sub(parts[#parts] + 1)

  return _class_name_caches[class_name]
end

return PHP
