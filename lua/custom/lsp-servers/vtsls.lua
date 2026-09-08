local common_settings = {
  inlayHints = {
    functionLikeReturnTypes = { enabled = true },
    parameterNames = { enabled = 'literals' },
    parameterTypes = { enabled = true },
  },
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
  settings = {
    javascript = js_settings,
    typescript = ts_settings,
    vtsls = {
      tsserver = {
        globalPlugins = {},
      },
    },
  },
}

local mason_registry = require('mason-registry')

-- Add Vue Typescript support
---@see https://github.com/neovim/nvim-lspconfig/blob/master/lsp/vtsls.lua
if mason_registry.is_installed('vue-language-server') then
  local vue_plugin = {
    name = '@vue/typescript-plugin',
    configNamespace = 'typescript',
    -- Load the plugin even when vtsls uses the workspace TypeScript version
    -- (most Vue projects have a local `typescript` package). Without this the
    -- plugin is silently skipped and Vue TS features break.
    enableForWorkspaceTypeScriptVersions = true,
    languages = { 'javascript', 'typescript', 'vue' },
    location = table.concat({
      mason_registry.get_package('vue-language-server'):get_install_path(),
      'node_modules/@vue/typescript-plugin'
    }, '/'),
  }

  ---@diagnostic disable-next-line: undefined-field
  table.insert(server.settings.vtsls.tsserver.globalPlugins, vue_plugin)
  table.insert(server.filetypes, 'vue')
end

return server
