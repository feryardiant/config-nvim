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

      opts.sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          { 'branch', icon = { '', align = 'right' } },
          { 'diff', padding = { left = 0, right = 1 } },
        },
        lualine_c = { filetype, filename },
        lualine_x = { 'diagnostics', 'fileformat', 'encoding' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      }
    end,
  },
}
