---@type table<string, lspconfig.Config>
return setmetatable({}, {
  __index = function(self, server)
    local ok, config = pcall(require, 'custom.lsp-servers.' .. server)

    if not ok then
      -- Fallback to empty table
      config = {}
    end

    local base_ok, base_config = pcall(require, 'lspconfig.configs.' .. server)

    if base_ok then
      local default_config = base_config.default_config or {}
      config.filetypes = vim.list_extend(default_config.filetypes, config.filetypes or {})

      table.sort(config.filetypes, function(a, b) return a:upper() < b:upper() end)
    end

    rawset(self, server, config)

    return config
  end,
})
