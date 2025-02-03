return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    event = { 'VimEnter' },
    ---@module 'toggleterm'
    ---@type ToggleTermConfig
    opts = {
      hide_numbers = true,
      open_mapping = [[<c-`>]],
      float_opts = {
        border = 'curved',
      }
    },
    init = function ()
      -- Configure terminal's local options and keymaps
      vim.api.nvim_create_autocmd({ 'TermOpen' }, {
        pattern = 'term://*',
        callback = function ()
          local opts = { buffer = 0 }

          -- Disable sign-column in terminal window
          vim.opt_local.signcolumn = 'no'

          vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)

          -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
          -- vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
          vim.keymap.set('t', '<leader>h', [[<Cmd>wincmd h<CR>]], { desc = 'Go to left window'  })
          vim.keymap.set('t', '<leader>j', [[<Cmd>wincmd j<CR>]], { desc = 'Go to window below' })
          vim.keymap.set('t', '<leader>k', [[<Cmd>wincmd k<CR>]], { desc = 'Go to window above' })
          vim.keymap.set('t', '<leader>l', [[<Cmd>wincmd l<CR>]], { desc = 'Go to right window' })
        end
      })

      local Terminal = require('toggleterm.terminal').Terminal

      local lazygit = Terminal:new({
        cmd = 'lazygit',
        dir = 'git_dir',
        direction = 'float',
      })

      vim.keymap.set({'n'}, '<leader>gl', function ()
        lazygit:toggle()
      end, { desc = 'Toggle LazyGit' })
    end,
  },
}
