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
      local opts = { buffer = 0 }
      local Terminal = require('toggleterm.terminal').Terminal

      vim.keymap.set({'t'}, '<Esc>', [[<C-\><C-n>]], opts)

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
