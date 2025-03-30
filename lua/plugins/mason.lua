return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'neovim/nvim-lspconfig' },
      { 'saghen/blink.cmp' },
    },
    ---@module 'mason-lspconfig'
    ---@param opts MasonLspconfigSettings
    opts = function(_, opts)
      opts.ensure_installed = {
        'bashls',
        'cssls',
        'dockerls',
        'emmet_ls',
        'eslint',
        'intelephense',
        'jsonls',
        'lua_ls',
        'nginx_language_server',
        'sqls',
        'svelte',
        'ts_ls',
        'tailwindcss',
        'vimls',
        'volar',
        'yamlls',
      }

      opts.handlers = {
        -- Default handler for all available LSP server.
        ---@param server string
        function(server)
          local lspconfig = require('lspconfig')
          local servers = require('custom.lsp-servers')

          ---@type lspconfig.Config
          local config = servers[server]

          config.capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            require('blink.cmp').get_lsp_capabilities(config.capabilities or {})
          )

          lspconfig[server].setup(config)
        end,
      }
    end,
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    cmd = { 'MasonToolsInstall', 'MasonToolsInstallSync' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'jay-babu/mason-nvim-dap.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    opts = function(_, opts)
      opts.ensure_installed = {
        'pint',
        'prettier',
        'stylua',
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
