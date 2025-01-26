return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'tpope/vim-fugitive' },
    },
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    opts = {
      current_line_blame = true,
      signs = {
        untracked = { text = '▎' },
      },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    main = 'ibl',
    ---@module 'ibl'
    ---@type ibl.config
    opts = {
      indent = { char = '┆' },
      scope = { char = '▏' },
    },
  },

  {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = { '*' },
  },

  {
    'echasnovski/mini.pairs',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  {
    'echasnovski/mini.surround',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  {
    'echasnovski/mini.comment',
    lazy = true,
    dependencies = {
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
    },
    ---@module 'mini.comment'
    opts = {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },

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
