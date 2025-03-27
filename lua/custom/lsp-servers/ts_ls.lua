local common_settings = {
  inlayHints = {
    functionLikeReturnTypes = { enabled = true },
    parameterNames = { enabled = 'literals' },
    parameterTypes = { enabled = true },
  }
}

local js_settings = vim.tbl_deep_extend('keep', {
  -- JS specific settings goes here
}, common_settings)

local ts_settings = vim.tbl_deep_extend('keep', {
  -- TS specific settings goes here
}, common_settings)

---@type lspconfig.Config
local server = {
  filetypes = {},
  init_options = { plugins = {} },
  settings = {
    javascript = js_settings,
    typescript = ts_settings,
  },
}

local mason_registry = require('mason-registry')

-- Add Vue Typescript supports
---@see https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vue-support
if mason_registry.is_installed('vue-language-server') then
  local plugin = {
    name = '@vue/typescript-plugin',
    languages = { 'vue', 'javascript', 'typescript' },
    location = table.concat({
      mason_registry.get_package('vue-language-server'):get_install_path(),
      'node_modules/@vue/language-server',
      'node_modules/@vue/typescript-plugin',
    }, '/'),
  }

  server.settings.tsserver_plugins = { plugin.name }

  table.insert(server.filetypes, 'vue')
  table.insert(server.init_options.plugins, plugin)
end

return server
