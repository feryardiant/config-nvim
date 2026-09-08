local ws = require('utils.workspace')

---@type vim.lsp.Config
return {
  settings = {
    deno = {
      -- Disable denols on non-deno project
      enable = ws.is_deno(),
    },
  },
}
