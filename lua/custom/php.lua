---@class PHP
local PHP = {}
local uv = vim.uv or vim.loop

function PHP.is_laravel() return PHP.file_exists('/artisan') end

---Check wheter file exists
---@param file_path string
---@return boolean
function PHP.file_exists(file_path) return uv.fs_stat(vim.fn.getcwd() .. file_path) ~= nil end

---Retrieve route file
---@return string?
function PHP.route_file()
  local try_files = {
    'server.php',
    'vendor/laravel/framework/src/Illuminate/Foundation/resources/server.php',
  }

  for _, file in ipairs(try_files) do
    if PHP.file_exists('/' .. file) then return file end
  end

  return nil
end

return PHP
