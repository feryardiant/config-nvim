return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    enabled = vim.fn.executable('make') == 1,
    lazy = true,
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    cmd = 'Telescope',
    version = false,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim' },
    },
    opts = function()
      local actions = require('telescope.actions')

      return {
        defaults = require('telescope.themes').get_dropdown({
          path_display = { 'smart' },
          prompt_prefix = ' ',
          selection_caret = ' ',
          layout_config = {
            vertical = { width = 0.5 },
          },
          mappings = {
            i = {
              ['<Esc>'] = actions.close,
            },
            n = {
              ['<Esc>'] = actions.close,
            },
          },
        }),
      }
    end,
    keys = {
      {
        '<leader><space>',
        function() require('telescope.builtin').buffers() end,
        desc = 'Find files from existing buffer',
      },
      {
        '<leader>ff',
        function() require('telescope.builtin').find_files() end,
        desc = 'Find files',
      },
      {
        '<leader>fw',
        function() require('telescope.builtin').grep_string() end,
        desc = 'Find current word',
      },
      {
        '<C-p>',
        function() require('telescope.builtin').git_files() end,
        desc = 'Find files inside git repository',
      },
      {
        '<leader>ds',
        function() require('telescope.builtin').lsp_document_symbols() end,
        desc = 'Find document symbols',
      },
    },
    config = function(_, opts)
      local telescope = require('telescope')

      telescope.setup(opts)

      telescope.load_extension('fzf')
      telescope.load_extension('notify')
    end,
  },
}
