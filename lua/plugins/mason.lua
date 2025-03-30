return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    cmd = { 'MasonToolsInstall', 'MasonToolsInstallSync' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'jay-babu/mason-nvim-dap.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    opts = {
      ensure_installed = {
        'pint',
        'prettier',
        'stylua',
      },
    },
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
