return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- { 'tpope/vim-fugitive' },
    },
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    opts = {
      current_line_blame = true,
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      on_attach = function(bufnr)
        ---@type gitsigns.actions
        local gs = package.loaded.gitsigns
        local map = require('util').create_keymap({ buffer = bufnr })

        map('n', ']h', function() gs.nav_hunk('next') end, { desc = 'Next [H]unk' })
        map('n', '[h', function() gs.nav_hunk('prev') end, { desc = 'Prev [H]unk' })
        map('n', ']H', function() gs.nav_hunk('last') end, { desc = 'Last [H]unk' })
        map('n', '[H', function() gs.nav_hunk('first') end, { desc = 'First [H]unk' })

        map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, { desc = 'Reset [H]unk' })
        map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, { desc = 'Stage [H]unk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage Buffer' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset Buffer' })

        map('n', '<leader>h?', gs.preview_hunk_inline, { desc = 'Preview [H]unk' })
      end,
    },
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
    },
  },

  {
    'sindrets/diffview.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    ---@module 'diffview'
    ---@type DiffviewConfig
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = 'diff3_mixed',
        },
      },
      file_panel = {
        win_config = {
          position = 'right',
          width = 32,
        },
      },
      hooks = {
        diff_buff_read = function()
          vim.opt_local.wrap = false
          vim.opt_local.colorcolumn = { 80 }
        end,
      },
    },
  },
}
