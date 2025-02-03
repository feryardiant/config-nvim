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
    event = { 'BufReadPre', 'BufNewFile' },
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
}
