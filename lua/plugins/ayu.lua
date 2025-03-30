return {
  {
    'Shatur/neovim-ayu',
    name = 'ayu',
    lazy = false,
    priority = 1000,
    init = function()
      -- stylua: ignore
      vim.cmd.colorscheme('ayu')
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

        SnacksBackdrop = { link = 'WinBar' },
        SnacksIndent = { fg = colors.guide_normal },
        SnacksIndentScope = { fg = colors.accent },
        SnacksNormal = { link = 'Normal' },
        SnacksPicker = { link = 'WinBar' },
        SnacksTerminal = { link = 'WinBar' },
        SnacksWinBar = { link = 'WinBar' },

        TreesitterContext = { link = 'NormalFloat' },

        WinBar = { bg = 'none' },
        WinBarNC = { bg = 'none' },
        WinSeparator = { fg = colors.guide_normal, bg = 'none' },
      }
    end,
  },
}
