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

      opts.icons = {}

      opts.pairs = {}

      opts.statusline = {}

      opts.surround = {}
    end,
    config = function(_, opts)
      for plugin, config in pairs(opts) do
        -- stylua: ignore
        require('mini.'..plugin).setup(config)
      end

      -- Mocking nvim_web_devicons for plugins that requires it
      -- See https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-icons.md#features
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}
