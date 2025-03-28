return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
    },
    opts = function(_, opts)
      opts.comment = {
        options = {
          custom_commentstring = function()
            local commentstring = require('ts_context_commentstring.internal')

            return commentstring.calculate_commentstring() or vim.bo.commentstring
          end,
        },
      }

      opts.pairs = {}

      opts.surround = {}
    end,
    config = function(_, opts)
      for plugin, config in pairs(opts) do
        -- stylua: ignore
        require('mini.'..plugin).setup(config)
      end
    end,
  },
}
