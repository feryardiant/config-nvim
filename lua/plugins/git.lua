local keymap = require('utils.keymap')
local map = keymap.create()

map('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Open LazyGit' })
map('n', '<leader>gl', function() Snacks.picker.git_log({ layout = 'default' }) end, { desc = 'Open [G]it [L]og' })

return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    ---@module 'gitsigns'
    ---@param opts Gitsigns.Config
    opts = function (_, opts)
      opts.current_line_blame = true

      opts.signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      }

      opts.on_attach = function (buffer)
        ---@type Gitsigns.actions
        local gs = package.loaded.gitsigns
        local bmap = keymap.create({ buffer = buffer })

        bmap('n', ']h', function() gs.nav_hunk('next') end, { desc = 'Next [H]unk' })
        bmap('n', '[h', function() gs.nav_hunk('prev') end, { desc = 'Prev [H]unk' })
        bmap('n', ']H', function() gs.nav_hunk('last') end, { desc = 'Last [H]unk' })
        bmap('n', '[H', function() gs.nav_hunk('first') end, { desc = 'First [H]unk' })

        bmap({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, { desc = 'Reset [H]unk' })
        bmap({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, { desc = 'Stage [H]unk' })
        bmap('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage Buffer' })
        bmap('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset Buffer' })

        bmap('n', '<leader>h?', gs.preview_hunk_inline, { desc = 'Preview [H]unk' })
      end
    end
  },

  {
    'akinsho/git-conflict.nvim',
    version = '*',
    ---@module 'git-conflict'
    ---@type GitConflictConfig
    opts = {
      disable_diagnostics = true,
      highlights = {
        ancestor = 'DiffText',
        current = 'DiffChange',
        incoming = 'DiffAdd',
      },
      default_mappings = {
        ours = '<leader>co',
        theirs = '<leader>ct',
        none = '<leader>c0',
        both = '<leader>cb',
      },
    },
  },
}
