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
      { '<leader>tx', function() require('neotest').run.stop() end, desc = '[T]est stop' },
      { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = '[T]est run with [D]AP' },
      { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = '[T]est [F]ile' },
      { '<leader>ts', function() require('neotest').run.run({ suite = true }) end, desc = '[T]est [S]uite' },
      { '<leader>to', function() require('neotest').output.open() end, desc = '[T]est [O]utput' },
      { '<leader>top', function() require('neotest').output_panel.toggle() end, desc = '[T]est [O]utput [P]anel' },
      { '<leader>tS', function() require('neotest').summary.toggle() end, desc = 'Toggle [T]est [S]ummary' },
    },
    opts = function()
      return {
        adapters = {
          require('neotest-vitest')({}),
          require('neotest-pest')({}),
          require('neotest-phpunit')({
            filter_dirs = { 'vendor' },
            root_ignore_files = { 'tests/Pest.php' },
          }),
        },
      }
    end
  },

}
