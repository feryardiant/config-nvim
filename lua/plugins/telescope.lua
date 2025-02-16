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
        preview = {
          mime_hook = function(filepath, buffer, hook_opts)
            if require('util').is_image(filepath) then
              local viewer = require('image')

              local image = viewer.from_file(filepath, {
                window = hook_opts.winid,
                buffer = buffer,
              })

              ---@diagnostic disable-next-line: need-check-nil
              image:render()
            else
              local previewer_util = require('telescope.previewers.utils')
              previewer_util.set_preview_message(buffer, hook_opts.winid, 'Binary cannot be previewed')
            end
          end,
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
  },
}
