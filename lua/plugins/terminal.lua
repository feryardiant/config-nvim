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
        border = 'curved',
      },

      ---@param term Terminal
      on_open = function (term)
        vim.opt_local.signcolumn = 'no'

        if string.find(term.name, vim.o.shell) then
          vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { buffer = term.bufnr, desc = 'Swich to normal mode' })

          -- vim.keymap.set('t', 'jk', '<C-\><C-n>', opts)
          -- vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', opts)
          vim.keymap.set('t', '<C-h>', '<Cmd>wincmd h<CR>', { buffer = term.bufnr, desc = 'Go to left window'  })
          vim.keymap.set('t', '<C-j>', '<Cmd>wincmd j<CR>', { buffer = term.bufnr, desc = 'Go to window below' })
          vim.keymap.set('t', '<C-k>', '<Cmd>wincmd k<CR>', { buffer = term.bufnr, desc = 'Go to window above' })
          vim.keymap.set('t', '<C-l>', '<Cmd>wincmd l<CR>', { buffer = term.bufnr, desc = 'Go to right window' })
        end
      end
    },
    init = function ()
      local Terminal = require('toggleterm.terminal').Terminal

      local lazygit = Terminal:new({
        cmd = 'lazygit',
        dir = 'git_dir',
        direction = 'float',
        hidden = true,
      })

      vim.keymap.set({'n'}, '<leader>gl', function ()
        lazygit:toggle()
      end, { desc = 'Toggle LazyGit', noremap = true, silent = true })
    end,
  },
}
