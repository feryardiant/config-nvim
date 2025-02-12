return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
      }

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = function() lint.try_lint() end,
      })

      vim.keymap.set('n', '<leader>fl', function() lint.try_lint() end, { desc = 'Trigger linting for current file' })
    end,
  },

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
            timeout_ms = 5000,
          })
        end,
        desc = '[F]ormat [B]uffer',
      },
    },
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
        blade = { 'prettier', 'blade-formatter', stop_after_first = true },
        json = { 'prettier', 'jq', stop_after_first = true },
        javascript = { 'prettier', stop_after_first = true },
        lua = { 'stylua' },
        markdown = { 'prettier', 'markdownlint', stop_after_first = true },
        php = { 'pint', stop_after_first = true },
        sql = { 'pg_format', 'sqlfmt', stop_after_first = true },
        yaml = { 'yamlfmt' },
      }
    end,
    init = function() vim.o.formatexpr = "v:lua.require('conform').formatexpr()" end,
  },
}
