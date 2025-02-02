return {
  {
    'Shatur/neovim-ayu',
    name = 'ayu',
    lazy = false,
    priority = 1000,
    init = function() vim.cmd.colorscheme('ayu') end,
    opts = function()
      local colors = require('ayu.colors')

      colors.generate(true)

      return {
        overrides = {
          Normal = { bg = 'none' },
          NormalFloat = { bg = colors.panel_bg },
          SignColumn = { fg = colors.comment, bg = 'none' },
          LineNr = { fg = colors.comment },
          Comment = { fg = colors.comment },
          CursorLine = { bg = colors.panel_bg },
          CursorLineNr = { bg = 'none' },
          ColorColumn = { bg = colors.panel_bg },
          Pmenu = { bg = colors.selection_inactive },
          PmenuSel = { bg = colors.selection_bg },
          Visual = { bg = colors.selection_bg },
          NonText = { fg = colors.guide_active },
          WinSeparator = { fg = colors.comment, bg = 'none' },

          IblIndent = { fg = colors.guide_normal },
          IblScope = { fg = colors.accent },

          DapBreakpoint = { fg = colors.accent },
          DapBreakpointCondition = { fg = colors.warning },
          DapBreakpointRejected = { fg = colors.error },
          DapLogPoint = { fg = colors.selection_bg },
          DapStopped = { fg = colors.tag },
        },
      }
    end,
  },

  {
    'wakatime/vim-wakatime',
    lazy = false,
  },

  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
        'LazyGit',
        -- 'LazyGitConfig',
        -- 'LazyGitCurrentFile',
        -- 'LazyGitFilter',
        -- 'LazyGitFilterCurrentFile',
    },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' }
    },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' }
    },
    config = function ()
      require('telescope').load_extension('lazygit')
    end
  },

  {
    'folke/which-key.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    ---@module 'which-key'
    ---@type wk.Config
    opts = {},
  },

  {
    'rcarriga/nvim-notify',
    lazy = true,
    ---@module 'notify'
    ---@type notify.Config
    opts = {
      minimum_width = 25,
      -- max_width = 50,
      background_colour = '#000000',
    },
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
      { 'rcarriga/nvim-notify' },
    },
    ---@module 'noice'
    ---@type NoiceConfig
    opts = {
      lsp = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = false,
        -- signature = {
        --   enabled = false,
        -- },
        -- hover = {
        --   enabled = false
        -- }
      },
      messages = {
        view = 'mini',
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      routes = {
        -- Credit: https://github.com/neovim/nvim-lspconfig/issues/1931#issuecomment-2138428768
        {
          filter = {
            event = 'notify',
            find = 'No information available',
          },
          opts = {
            skip = true,
          },
        },
      },
    },
  },

  {
    'stevearc/dressing.nvim',
    lazy = true,
  },

  {
    'laytan/cloak.nvim',
    lazy = false,
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
          replace = '%1='
        }
      }
    },
  },

  -- {
  --   'akinsho/bufferline.nvim',
  --   opts = {
  --     options = {
  --       mode = 'tabs',
  --       diagnostics = 'nvim_lsp',
  --       offsets = {
  --         {
  --           filetype = 'neo-tree',
  --           text = 'File Explorer',
  --           highlight = 'Directory',
  --         }
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     require('bufferline').setup(opts)
  --   end
  -- },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus

      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = ''
      else
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          theme = 'auto',
          globalstatus = true,
          disabled_filetypes = { 'dashboard', 'alpha', 'starter' },
          componnet_separators = '',
          section_separators = '',
        },
        extensions = { 'neo-tree', 'lazy' },
      }
    end,
  },
}
