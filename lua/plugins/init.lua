return {
  {
    'Shatur/neovim-ayu',
    name = 'ayu',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme('ayu')

      vim.api.nvim_create_autocmd('TextYankPost', {
        pattern = '*',
        callback = function()
          -- https://neovim.io/doc/user/lua.html#vim.hl
          vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
        end,
      })
    end,
    opts = function(_, opts)
      local colors = require('ayu.colors')

      colors.generate(true)

      opts.overrides = {
        Normal = { bg = 'none' },
        NormalFloat = { bg = colors.panel_bg },
        FloatBorder = { fg = colors.comment, bg = 'none' },
        SignColumn = { link = 'FloatBorder' },
        LineNr = { fg = colors.comment },
        Comment = { fg = colors.comment },
        CursorLine = { bg = colors.panel_bg },
        CursorLineNr = { bg = 'none' },
        ColorColumn = { bg = colors.panel_bg },
        Pmenu = { bg = colors.selection_inactive },
        PmenuSel = { bg = colors.selection_bg },
        Visual = { bg = colors.selection_bg },
        NonText = { fg = colors.guide_active },

        -- DiffText = { link = 'DiffChange' },
        -- DiffAdd = { fg = colors.vcs_added },
        -- DiffChange = { bg = colors.selection_inactive },
        -- DiffDelete = { fg = colors.vcs_removed },

        DapBreakpoint = { fg = colors.accent },
        DapBreakpointCondition = { fg = colors.warning },
        DapBreakpointRejected = { fg = colors.error },
        DapLogPoint = { fg = colors.accent },
        DapStopped = { fg = colors.tag },
        DapUIFloatBorder = { link = 'FloatBorder' },
        DapUIFloatNormal = { link = 'NormalFloat' },

        LazyNormal = { link = 'Normal' },
        MasonNormal = { link = 'Normal' },

        NeoTreeFloatBorder = { link = 'FloatBorder' },
        NeoTreeFloatNormal = { link = 'Normal' },

        NvimDapVirtualText = { link = 'Comment' },
        NvimDapVirtualTextChanged = { fg = colors.accent },

        StatusLine = { link = 'lualine_c_normal' },

        SnacksBackdrop = { link = 'WinBar' },
        SnacksIndent = { fg = colors.guide_normal },
        SnacksIndentScope = { fg = colors.accent },
        SnacksPicker = { link = 'WinBar' },
        SnacksTerminal = { link = 'WinBar' },

        TreesitterContext = { link = 'NormalFloat' },

        WinBar = { bg = 'none' },
        WinBarNC = { bg = 'none' },
        WinSeparator = { fg = colors.guide_normal, bg = 'none' },
      }
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
    ---@module 'which-key'
    ---@type wk.Config
    opts = {
      delay = 1500,
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
      { 'folke/trouble.nvim' },
    },
    opts = function(_, opts)
      vim.o.laststatus = vim.g.lualine_laststatus

      opts.options = {
        globalstatus = true,
        disabled_filetypes = { 'dashboard', 'alpha', 'starter' },
        component_separators = '',
      }

      opts.extensions = {
        'lazy',
        'mason',
        'nvim-dap-ui',
        'quickfix',
        'toggleterm',
        'trouble',
      }

      local filetype = {
        'filetype',
        icon_only = true,
        padding = { left = 1, right = 0 },
      }

      local filename = {
        'filename',
        padding = { left = 0, right = 1 },
        path = 1,
        symbols = {
          modified = '',
          readonly = '󰗖',
          unnamed = '',
          newfile = '󱨧',
        },
      }

      local doc_symbols = require('trouble').statusline({
        mode = 'lsp_document_symbols',
        groups = {},
        max_items = 4,
        title = false,
        filter = { range = true },
        format = '{kind_icon}{symbol.name:Comment}',
        hl_group = 'lualine_c_normal',
      })

      local symbols = {
        -- 'symbols',
        doc_symbols.get,
        cond = doc_symbols.has,
        padding = { left = 1, right = 0 },
      }

      opts.sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          { 'branch', icon = { '', align = 'right' } },
          { 'diff', padding = { left = 0, right = 1 } },
        },
        lualine_c = { filetype, filename, symbols },
        lualine_x = { 'diagnostics', 'fileformat' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
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
  },
}
