return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'folke/trouble.nvim' },
    },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus

      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = ''
      else
        vim.o.laststatus = 0
      end
    end,
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
        lualine_x = { 'diagnostics', 'fileformat', 'encoding' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      }
    end,
  },
}
