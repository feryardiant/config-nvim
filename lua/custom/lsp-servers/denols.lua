local fs = require('utils.fs')

---@type lspconfig.Config
return {
  settings = {
    deno = {
      -- Disable denols on non-deno project
      enable = fs.is_deno(),
    },
  },
}
