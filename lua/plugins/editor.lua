return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- { 'tpope/vim-fugitive' },
    },
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    opts = {
      current_line_blame = true,
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      on_attach = function(bufnr)
        ---@type gitsigns.actions
        local gs = package.loaded.gitsigns
        local map = require('util').create_keymap({ buffer = bufnr })

        map('n', ']h', function() gs.nav_hunk('next') end, { desc = 'Next [H]unk' })
        map('n', '[h', function() gs.nav_hunk('prev') end, { desc = 'Prev [H]unk' })
        map('n', ']H', function() gs.nav_hunk('last') end, { desc = 'Last [H]unk' })
        map('n', '[H', function() gs.nav_hunk('first') end, { desc = 'First [H]unk' })

        map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, { desc = 'Reset [H]unk' })
        map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, { desc = 'Stage [H]unk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage Buffer' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset Buffer' })

        map('n', '<leader>h?', gs.preview_hunk_inline, { desc = 'Preview [H]unk' })
      end,
    },
  },

  {
    'rcarriga/nvim-notify',
    lazy = true,
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    ---@module 'notify'
    ---@type notify.Config
    opts = {
      minimum_width = 25,
      -- max_width = 50,
      background_colour = '#000000',
    },
    init = function() require('telescope').load_extension('notify') end,
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
      { 'rcarriga/nvim-notify' },
    },
    ---@module 'noice'
    ---@param opts NoiceConfig
    opts = function(_, opts)
      opts.lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = false,
        },
        -- signature = {
        --   enabled = false,
        -- },
        -- hover = {
        --   enabled = false
        -- }
      }

      opts.messages = {
        view = 'mini',
      }

      opts.commands = {
        -- Show all notification history
        ---@see https://github.com/craftzdog/dotfiles-public/blob/a445967/.config/nvim/lua/plugins/ui.lua#L35-L40
        all = {
          view = 'split',
          opts = { enter = true, format = 'details', border = 'none' },
          filter = { event = 'notify' },
        },
      }

      opts.presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      }

      opts.routes = {
        -- Credit: https://github.com/neovim/nvim-lspconfig/issues/1931#issuecomment-2138428768
        {
          filter = {
            event = 'notify',
            find = 'No information available',
          },
          opts = { skip = true },
        },
      }
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    main = 'ibl',
    ---@module 'ibl'
    ---@type ibl.config
    opts = {
      indent = { char = '┆' },
      scope = { char = '▏' },
    },
  },

  {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = { '*' },
  },

  {
    'echasnovski/mini.pairs',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  {
    'echasnovski/mini.surround',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  {
    'echasnovski/mini.comment',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
    },
    ---@module 'mini.comment'
    opts = {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },

  {
    'laytan/cloak.nvim',
    ft = 'dotenv',
    ---@module 'cloak'
    opts = {
      cloak_telescope = true,
      patterns = {
        {
          file_pattern = '.env*',
          cloak_pattern = {
            '(%u+_ID)=.+',
            '(%u+_DSN)=.+',
            '(%u+_KEY)=.+',
            '(%u+_PASS%u+)=.+',
            '(%u+_PRIVATE%u+)=.+',
            '(%u+_SECRET%u+)=.+',
            '(%u+_TOKEN%u+)=.+',
            '(%u+_USER%u+)=.+',
            '(%u+)=(%a+://).+',
            '(%u+)=[\'"](%a+://).+[\'"]$',
          },
          replace = '%1=',
        },
      },
    },
  },
}
