return {
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    ---@module 'trouble'
    ---@type trouble.Config
    opts = {
      use_diagnostic_signs = true,
    },
    init = function()
      local map = require('util').create_keymap()

      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

      -- Diagnostics
      local diagnostic_goto = function(next, severity)
        local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
        severity = severity and vim.diagnostic.severity[severity] or nil

        return function() go({ severity = severity }) end
      end

      map('n', '[d', diagnostic_goto(false), { desc = 'Prev [D]iagnostic' })
      map('n', ']d', diagnostic_goto(true), { desc = 'Next [D]iagnostic' })
      map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev [E]rror' })
      map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next [E]rror' })
      map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev [W]arning' })
      map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next [W]arning' })

      map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    end,
    specs = {
      'folke/snacks.nvim',
      opts = function(_, opts)
        return vim.tbl_deep_extend('force', opts or {}, {
          picker = {
            actions = require('trouble.sources.snacks').actions,
            -- win = {
            --   input = {
            --     keys = {
            --       ['<c-t>'] = { 'trouble_open', mode = { 'n', 'i' } },
            --     },
            --   },
            -- },
          },
        })
      end,
    },
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

      opts.summary = {
        open = 'botright vsplit | vertical resize 32',
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
        '<leader>fo',
        function()
          require('conform').format({
            async = true,
            lsp_fallbak = true,
            timeout_ms = 5000,
          })
        end,
        desc = '[Fo]rmat Buffer',
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
