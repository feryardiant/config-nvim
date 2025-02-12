return {
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
    opts = {},
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
    'folke/trouble.nvim',
    cmd = 'Trouble',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    keys = {
      {
        '<leader>xx',
        '<Cmd>Trouble diagnostics toggle<CR>',
        desc = '[Trouble] Diagnostics',
      },
      {
        '<leader>xX',
        '<Cmd>Trouble diagnostics toggle filter.buf=0<CR>',
        desc = '[Trouble] Buffer diagnostics',
      },
      {
        '<leader>xs',
        '<Cmd>Trouble symbols toggle focus=false<CR>',
        desc = '[Trouble] Symbols',
      },
      {
        '<leader>xl',
        '<Cmd>Trouble lsp toggle focus=false win.position=right<CR>',
        desc = '[Trouble] LSP Definitions',
      },
      {
        '<leader>xL',
        '<Cmd>Trouble loclist toggle<CR>',
        desc = '[Trouble] Location list',
      },
      {
        '<leader>xq',
        '<Cmd>Trouble qflist toggle<CR>',
        desc = '[Trouble] Quickfix list',
      },
    },
    ---@module 'trouble'
    ---@type trouble.Config
    opts = {
      use_diagnostic_signs = true,
    },
  },

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
        'neo-tree',
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
