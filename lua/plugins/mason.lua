return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'neovim/nvim-lspconfig' },
    },
    ---@module 'mason-lspconfig'
    ---@param opts MasonLspconfigSettings
    opts = function(_, opts)
      local lspconfig = require('lspconfig')
      local servers = require('custom.lsp-servers')

      opts.ensure_installed = vim.tbl_keys(servers or {})

      opts.handlers = {
        -- Default handler for all available LSP server.
        ---@param server string
        function(server)
          ---@type lspconfig.Config
          local config = servers[server] or {}
          local ok, base_config = pcall(require, 'lspconfig.configs.' .. server)

          if ok then
            local default_config = base_config.default_config or {}
            config.filetypes = vim.list_extend(default_config.filetypes, config.filetypes or {})

            table.sort(config.filetypes, function(a, b) return a:upper() < b:upper() end)
          end

          local capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
          )

          config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})

          lspconfig[server].setup(config)
        end,
      }
    end,
  },

  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonUpdate' },
    ---@module 'mason'
    ---@type MasonSettings
    opts = {
      ui = {
        border = 'rounded',
        width = 0.8,
        height = 0.7,
        icons = {
          package_installed = '✓',
          package_uninstalled = '✗',
        },
      },
    },
  },
}
