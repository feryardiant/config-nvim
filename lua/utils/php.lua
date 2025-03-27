---@class PHP
local PHP = {}
local fs = require('utils.fs')

---Is it a Laravel project
---@return boolean
function PHP.is_laravel()
  -- stylua: ignore
  return fs.file_exists('artisan')
end

---Retrieve global `COMPOSER_HOME` directory
---@return string?
function PHP.composer_home()
  local home = os.getenv('COMPOSER_HOME')

  assert(vim.fn.isdirectory(home), '$COMPOSER_HOME directory doesn exists')

  return home
end

---Retrieve global include paths
---@return string[]
function PHP.include_paths()
  local composer_home = PHP.composer_home()
  local should_available = {}
  local paths = {}

  -- stylua: ignore
  if PHP.has_extension('openswoole') then
    table.insert(should_available, 'openswoole/ide-helper')
  end

  for _, pkg_path in ipairs(should_available) do
    pkg_path = string.format('%s/vendor/%s', composer_home, pkg_path)

    -- stylua: ignore
    if vim.fn.isdirectory(pkg_path) then
      table.insert(paths, pkg_path)
    end
  end

  return paths
end

---Retrieve xdebug port
---@return number
function PHP.xdebug_port()
  local output = PHP.exec('ini_get("xdebug.client_port")')

  -- Default xdebug port
  return tonumber(output) or 9003
end

---Retrieve value from php.ini
---@param ini string
---@return string?
function PHP.ini_get(ini)
  local ini_value = PHP.exec(string.format('ini_get("%s")', ini))

  if #ini_value == 0 then return nil end

  local booleanish = {
    ['0'] = 'Off',
    ['1'] = 'On',
  }

  if booleanish[ini_value:lower()] ~= nil then
    -- Some ini just use numeric 0 and 1
    -- Let's just normalized it to `Off` and `On`
    return booleanish[ini_value:lower()]
  end

  return ini_value
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

  -- stylua: ignore
  for _, file in ipairs(try_files) do
    if fs.file_exists(file) then return file end
  end

  return nil
end

local _class_name_caches = {}

---Retrieve basename of a class
---@param class_name string
function PHP.class_basename(class_name)
  -- stylua: ignore
  if _class_name_caches[class_name] ~= nil then
    return _class_name_caches[class_name]
  end

  local parts = {}
  local pos = 0

  while true do
    ---@diagnostic disable-next-line: cast-local-type
    pos = string.find(class_name, '\\', pos + 1)
    if pos == nil then break end
    table.insert(parts, pos)
  end

  _class_name_caches[class_name] = class_name:sub(parts[#parts] + 1)

  return _class_name_caches[class_name]
end

local _installed_extensions = {}

---Check wheter `ext` is installed
---@param ext string
---@return boolean
function PHP.has_extension(ext)
  for _, installed in ipairs(PHP.installed_extensions()) do
    if ext == installed then return true end
  end

  return false
end

---@return string[]
function PHP.installed_extensions()
  -- stylua: ignore
  if #_installed_extensions > 0 then
    return _installed_extensions
  end

  local output = PHP.exec('implode(PHP_EOL, get_loaded_extensions())')

  -- stylua: ignore
  for line in output:gmatch("([^\n]+)") do
    table.insert(_installed_extensions, line)
  end

  table.sort(_installed_extensions, function(a, b) return a:upper() < b:upper() end)

  return _installed_extensions
end

-- Default intelephense stubs
-- https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#configuration-options
local intelephense_stubs = {
  'apache',
  'bcmath',
  'bz2',
  'calendar',
  'com_dotnet',
  'Core',
  'ctype',
  'curl',
  'date',
  'dba',
  'dom',
  'enchant',
  'exif',
  'FFI',
  'fileinfo',
  'filter',
  'fpm',
  'ftp',
  'gd',
  'gettext',
  'gmp',
  'hash',
  'iconv',
  'imap',
  'intl',
  'json',
  'ldap',
  'libxml',
  'mbstring',
  'meta',
  'mysqli',
  'oci8',
  'odbc',
  'openssl',
  'pcntl',
  'pcre',
  'PDO',
  'pdo_ibm',
  'pdo_mysql',
  'pdo_pgsql',
  'pdo_sqlite',
  'pgsql',
  'Phar',
  'posix',
  'pspell',
  'readline',
  'Reflection',
  'session',
  'shmop',
  'SimpleXML',
  'snmp',
  'soap',
  'sockets',
  'sodium',
  'SPL',
  'sqlite3',
  'standard',
  'superglobals',
  'sysvmsg',
  'sysvsem',
  'sysvshm',
  'tidy',
  'tokenizer',
  'xml',
  'xmlreader',
  'xmlrpc',
  'xmlwriter',
  'xsl',
  'Zend OPcache',
  'zip',
  'zlib',
}

local combined_stubs = {}

---@param ext string
---@return boolean
local stub_contains = function(ext)
  for _, stub in ipairs(intelephense_stubs) do
    if stub == ext then return true end
  end
  return false
end

function PHP.collect_stubs()
  -- stylua: ignore
  if #combined_stubs > 0 then
    return combined_stubs
  end

  combined_stubs = vim.list_extend(combined_stubs, intelephense_stubs)

  for _, ext in ipairs(PHP.installed_extensions()) do
    if ext == 'openswoole' then
      -- Apparently intelephense doesn't have stub for openswoole just yet
      -- https://github.com/bmewburn/vscode-intelephense/issues/2224
      goto continue
    end

    if stub_contains(ext) then goto continue end

    table.insert(combined_stubs, ext)

    ::continue::
  end

  return combined_stubs
end

return PHP
