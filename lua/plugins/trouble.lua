return {
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    keys = {
      {
        '<leader>xx',
        '<Cmd>Trouble diagnostics toggle<CR>',
        desc = '[Trouble] Diagnostics',
      },
      {
        '<leader>xX',
        '<Cmd>Trouble diagnostics toggle filter.buf=0<CR>',
        desc = '[Trouble] Buffer diagnostics',
      },
      {
        '<leader>xs',
        '<Cmd>Trouble symbols toggle focus=false<CR>',
        desc = '[Trouble] Symbols',
      },
      {
        '<leader>xl',
        '<Cmd>Trouble lsp toggle focus=false win.position=right<CR>',
        desc = '[Trouble] LSP Definitions',
      },
      {
        '<leader>xL',
        '<Cmd>Trouble loclist toggle<CR>',
        desc = '[Trouble] Location list',
      },
      {
        '<leader>xq',
        '<Cmd>Trouble qflist toggle<CR>',
        desc = '[Trouble] Quickfix list',
      },
    },
    ---@module 'trouble'
    ---@type trouble.Config
    opts = {
      use_diagnostic_signs = true,
    },
  },
}
