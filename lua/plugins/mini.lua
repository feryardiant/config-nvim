return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
    },
    setup = function ()
      require('mini.pairs').setup()

      require('mini.surround').setup()

      require('mini.comment').setup({
        options = {
          custom_commentstring = function()
            local ts_context_commentstring = require('ts_context_commentstring.internal')

            return ts_context_commentstring.calculate_commentstring() or vim.bo.commentstring
          end,
        },
      })
    end
  }
}
