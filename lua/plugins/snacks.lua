return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1001,
    keys = {
      {
        '<leader>n',
        function()
          Snacks.picker.notifications()
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
