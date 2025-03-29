local ws = require('utils.workspace')

---@type lspconfig.Config
return {
  settings = {
    deno = {
      -- Disable denols on non-deno project
      enable = ws.is_deno(),
    },
  },
}
