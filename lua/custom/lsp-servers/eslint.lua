local ws = require('utils.workspace')

---@type vim.lsp.Config
return {
  settings = {
    eslint = {
      -- Disable eslint on a deno project
      enable = not ws.is_deno(),
    },
  },
}
