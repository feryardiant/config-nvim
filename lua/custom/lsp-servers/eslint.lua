local ws = require('utils.workspace')

---@type lspconfig.Config
return {
  settings = {
    eslint = {
      -- Disable eslint on a deno project
      enable = not ws.is_deno(),
    },
  },
}
