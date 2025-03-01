return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1001,
    keys = {
      {
        '<leader>nh',
        function()
          Snacks.notifier.show_history({})
        end,
        desc = 'Notification history'
      },
    },
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      input = {
        enabled = true,
      },
      notifier = {
        enabled = true,
      },
    },
  },
}
