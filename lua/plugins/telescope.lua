return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    enabled = vim.fn.executable('make') == 1,
    lazy = true,
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function() require('telescope').load_extension('fzf') end,
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    cmd = 'Telescope',
    version = false,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    keys = {
      {
        '<leader><space>',
        function() require('telescope.builtin').buffers() end,
        desc = 'Find buffers',
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
        '<C-f>',
        function() require('telescope.builtin').live_grep() end,
        desc = 'Find files inside workspace',
      },
      {
        '<leader>fs',
        function() require('telescope.builtin').lsp_document_symbols() end,
        desc = 'Find document symbols',
      },
    },
    ---@module 'telescope'
    ---@param opts table
    opts = function(_, opts)
      local actions = require('telescope.actions')

      opts.defaults = require('telescope.themes').get_dropdown({
        path_display = {
          shorten = { exclude = { 1, -1 }, len = 1 },
        },
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
      })

      opts.pickers = {
        find_files = {
          find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        },
      }

      opts.extensions = {}
    end,
  },
}
