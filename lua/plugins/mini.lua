return {
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
