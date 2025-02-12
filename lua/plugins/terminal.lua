return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    event = { 'VimEnter' },
    ---@module 'toggleterm'
    ---@type ToggleTermConfig
    opts = {
      hide_numbers = true,
      open_mapping = '<c-`>',
      float_opts = {
        border = 'rounded',
      },
      highlights = {
        Normal = { link = 'Normal' },
        NormalFloat = { link = 'Normal' },
        FloatBorder = { link = 'FloatBorder' },
      },

      ---@param term Terminal
      on_open = function(term)
        vim.opt_local.signcolumn = 'no'

        if term.name:find(vim.o.shell) then
          local map = require('util').create_keymap(term.bufnr)

          map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Swich to normal mode' })

          -- map('t', '<C-w>', '<C-\\><C-n><C-w>', opts)
          map('t', '<C-h>', '<Cmd>wincmd h<CR>', { desc = 'Go to left window' })
          map('t', '<C-j>', '<Cmd>wincmd j<CR>', { desc = 'Go to window below' })
          map('t', '<C-k>', '<Cmd>wincmd k<CR>', { desc = 'Go to window above' })
          map('t', '<C-l>', '<Cmd>wincmd l<CR>', { desc = 'Go to right window' })
        end
      end,
    },
    init = function()
      local Terminal = require('toggleterm.terminal').Terminal

      local lazygit = Terminal:new({
        cmd = 'lazygit',
        dir = 'git_dir',
        direction = 'float',
        hidden = true,
      })

      vim.keymap.set(
        { 'n' },
        '<leader>gl',
        function() lazygit:toggle() end,
        { desc = 'Toggle LazyGit', noremap = true, silent = true }
      )
    end,
  },
}
