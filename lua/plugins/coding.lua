return {
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
    init = function()
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })
    end,
  },

  {
    'nvim-neotest/neotest',
    dependencies = {
      { 'nvim-neotest/nvim-nio' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'V13Axel/neotest-pest' },
      { 'olimorris/neotest-phpunit' },
      { 'marilari88/neotest-vitest' },
    },
    keys = {
      { '<leader>tr', function() require('neotest').run.run() end, desc = '[T]est [R]un' },
      { '<leader>tx', function() require('neotest').run.stop() end, desc = '[T]est stop' },
      { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = '[T]est run with [D]AP' },
      { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = '[T]est [F]ile' },
      { '<leader>ts', function() require('neotest').run.run({ suite = true }) end, desc = '[T]est [S]uite' },
      { '<leader>to', function() require('neotest').output.open() end, desc = '[T]est [O]utput' },
      { '<leader>top', function() require('neotest').output_panel.toggle() end, desc = '[T]est [O]utput [P]anel' },
      { '<leader>tS', function() require('neotest').summary.toggle() end, desc = 'Toggle [T]est [S]ummary' },
    },
    ---@module 'neotest'
    ---@param opts neotest.Config
    opts = function(_, opts)
      opts.adapters = {
        require('neotest-vitest')({}),
        require('neotest-pest')({}),
        require('neotest-phpunit')({
          filter_dirs = { 'vendor' },
          root_ignore_files = { 'tests/Pest.php' },
        }),
      }
    end,
  },

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
