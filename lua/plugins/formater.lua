return {

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>fb',
        function()
          require('conform').format({
            async = true,
            lsp_fallbak = true,
            timeout_ms = 5000
          })
        end,
        desc = '[F]ormat [B]uffer',
      }
    },
    opts = function ()
      local util = require('conform.util')

      ---@module 'conform'
      ---@type conform.setupOpts
      return {
        log_level = vim.log.levels.WARN,
        formatters = {
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
        },
        formatters_by_ft = {
          blade = { 'prettier', 'blade-formatter', stop_after_first = true },
          json = { 'prettier', 'jq', stop_after_first = true },
          javascript = { 'prettier', stop_after_first = true },
          lua = { 'stylua' },
          markdown = { 'prettier', 'markdownlint', stop_after_first = true },
          php = { 'pint', stop_after_first = true },
          sql = { 'pg_format', 'sqlfmt', stop_after_first = true },
          yaml = { 'yamlfmt' },
        },
      }
    end,
    init = function()
      vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
    end,
  },

}
