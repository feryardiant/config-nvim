return {

  {
    'Shatur/neovim-ayu',
    name = 'ayu',
    lazy = false,
    priority = 1000,
    init = function() vim.cmd.colorscheme('ayu') end,
    config = function()
      local colors = require('ayu.colors')
      local ayu = require('ayu')

      colors.generate(true)

      ayu.setup({
        overrides = {
          Normal = { bg = 'none' },
          NormalFloat = { bg = '#1c212b' },
          SignColumn = { fg = colors.comment, bg = 'none' },
          LineNr = { fg = colors.comment },
          Comment = { fg = colors.comment },
          CursorLine = { bg = '#1c212b' },
          CursorLineNr = { bg = 'none' },
          ColorColumn = { bg = '#1c212b' },
          Pmenu = { bg = colors.selection_inactive },
          PmenuSel = { bg = colors.selection_bg },
          Visual = { bg = colors.selection_bg },
          NonText = { fg = colors.comment },
          IblIndent = { fg = colors.comment },
          IblScope = { fg = '#ffad66' },
          WinSeparator = { fg = colors.comment, bg = 'none' },
        },
      })
    end,
  },

  {
    'wakatime/vim-wakatime',
    lazy = false,
  },

  {
    'folke/which-key.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  {
    'rcarriga/nvim-notify',
    lazy = true,
    config = function()
      local notify = require('notify')

      ---@diagnostic disable: missing-fields
      notify.setup({
        minimum_width = 25,
        max_width = 50,
        background_colour = '#000000',
      })
    end,
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
      { 'rcarriga/nvim-notify' },
    },
    config = function()
      require('noice').setup({
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
      })
    end,
  },

  {
    'stevearc/dressing.nvim',
    lazy = true,
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
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = ''
      else
        vim.o.laststatus = 0
      end
    end,
    config = function(_, opts) require('lualine').setup(opts) end,
  },
}
