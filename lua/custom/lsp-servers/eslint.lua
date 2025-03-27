local fs = require('utils.fs')

---@type lspconfig.Config
return {
  settings = {
    eslint = {
      -- Disable eslint on a deno project
      enable = not fs.is_deno(),
    },
  },
}
