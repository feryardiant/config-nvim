return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>fo',
        function()
          require('conform').format({
            async = true,
            lsp_format = 'fallback',
            timeout_ms = 5000,
          })
        end,
        desc = '[Fo]rmat Buffer',
      },
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
        prettier = {
          prepend_args = { '--ignore-unknown' },
        },
        pint = {
          meta = {
            url = 'https://github.com/laravel/pint',
            description = 'Laravel Pint is an opinionated PHP code style fixer for minimalists.',
          },
          command = util.find_executable({
            vim.fn.stdpath('data') .. '/mason/bin/pint',
            'vendor/bin/pint',
          }, 'pint'),
          args = { '$FILENAME' },
          stdin = false,
        },
      }

      opts.formatters_by_ft = {
        lua = { 'stylua' },
        php = { 'pint', stop_after_first = true },
      }
    end,
  },
}
