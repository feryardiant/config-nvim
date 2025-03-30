return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      { '<leader>fo', function() require('conform').format() end, desc = '[Fo]rmat Buffer' },
    },
    init = function()
      -- stylua: ignore
      vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
    end,
    ---@module 'conform'
    ---@param opts conform.setupOpts
    opts = function(_, opts)
      local util = require('conform.util')

      opts.log_level = vim.log.levels.WARN

      opts.formatters = {
        pint = {
          command = util.find_executable({
            'vendor/bin/pint',
            vim.fn.stdpath('data') .. '/mason/bin/pint',
          }, 'pint'),
          args = { '$FILENAME' },
        },
        prettier = {
          prepend_args = { '--ignore-unknown' },
        },
      }

      opts.default_format_opts = {
        lsp_format = 'fallback',
        async = true,
        timeout_ms = 5000,
      }

      opts.formatters_by_ft = {
        lua = { 'stylua' },
        php = { 'pint', stop_after_first = true },
      }
    end,
  },
}
