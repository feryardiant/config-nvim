local php = require('utils.php')

-- Default intelephense stubs
-- https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#configuration-options
local default_stubs = {
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

local cached = {
  include_paths = {},
  combined_stubs = {},
}

---@param ext string
---@return boolean
local function stub_contains(ext)
  for _, stub in ipairs(default_stubs) do
    if stub == ext then return true end
  end
  return false
end

local function collect_stubs()
  -- stylua: ignore
  if #cached.combined_stubs > 0 then
    return cached.combined_stubs
  end

  cached.combined_stubs = vim.list_extend(cached.combined_stubs, default_stubs)

  for _, ext in ipairs(php.installed_extensions()) do
    if ext == 'openswoole' then
      -- Apparently intelephense doesn't have stub for openswoole just yet
      -- https://github.com/bmewburn/vscode-intelephense/issues/2224
      goto continue
    end

    if stub_contains(ext) then goto continue end

    table.insert(cached.combined_stubs, ext)

    ::continue::
  end

  return cached.combined_stubs
end

---Retrieve global include paths
---@return string[]
local function include_paths()
  -- stylua: ignore
  if #cached.include_paths > 0 then
    return cached.include_paths
  end

  local composer_home = php.composer_home()
  local should_available = {}

  if php.has_extension('openswoole') then
    -- Since intelephense doesn't have stubs for openswoole
    -- We should use official `openswoole/ide-helper` instead
    table.insert(should_available, 'openswoole/ide-helper')
  end

  for _, pkg_path in ipairs(should_available) do
    pkg_path = string.format('%s/vendor/%s', composer_home, pkg_path)

    -- stylua: ignore
    if vim.fn.isdirectory(pkg_path) then
      table.insert(cached.include_paths, pkg_path)
    end
  end

  return cached.include_paths
end

---@type lspconfig.Config
return {
  filetypes = { 'blade', 'php_only' },
  settings = {
    intelephense = {
      environment = {
        includePaths = include_paths(),
      },
      files = {
        maxSize = 5000000,
        exclude = {
          '**/*.old',
          '**/*.old/**',
          '**/.git/**',
          '**/.svn/**',
          '**/.hg/**',
          '**/CVS/**',
          '**/.DS_Store/**',
          '**/node_modules/**',
          '**/bower_components/**',
          '**/vendor/**/{Tests,tests}/**',
          '**/.history/**',
          '**/vendor/**/vendor/**',
        },
      },
      references = {
        exclude = {
          '**/*.old/**',
          '**/vendor/**',
        },
      },
      stubs = collect_stubs(),
    },
  },
}
