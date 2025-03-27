---@type table<string, lspconfig.Config>
local servers = {}

local ensure_installed = {
  'bashls',
  'cssls',
  'denols',
  'dockerls',
  'emmet_ls',
  'intelephense',
  'jsonls',
  'lua_ls',
  'nginx_language_server',
  'sqls',
  'svelte',
  'ts_ls',
  'tailwindcss',
  'unocss',
  'vimls',
  'volar',
  'yamlls',
}

for _, server in ipairs(ensure_installed) do
  local ok, settings = pcall(require, 'custom.lsp-servers.' .. server)

  servers[server] = ok and settings or {}
end

return servers
