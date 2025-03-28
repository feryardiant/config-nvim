return {
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
      { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = '[T]est run with [D]AP' },
      { '<leader>ts', function() require('neotest').run.run({ suite = true }) end, desc = '[T]est [S]uite' },
      { '<leader>t', function() require('neotest').summary.toggle() end, desc = 'Toggle [T]est [S]ummary' },
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
    config = function(_, opts)
      local neotest = require('neotest')
      local keymap = require('utils.keymap')

      local map = keymap.create()

      map('n', '<leader>tx', function() neotest.run.stop() end, { desc = '[T]est stop' })
      map('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end, { desc = '[T]est [F]ile' })
      map('n', '<leader>to', function() neotest.output.open() end, { desc = '[T]est [O]utput' })
      map('n', '<leader>tp', function() neotest.output_panel.toggle() end, { desc = '[T]est Output [P]anel' })

      neotest.setup(opts)
    end,
  },
}
