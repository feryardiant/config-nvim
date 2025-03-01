return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1001,
    keys = {
      {
        '<leader>n',
        function() Snacks.picker.notifications() end,
        desc = 'Show [N]otifications',
      },
      {
        '<leader>fe',
        function() Snacks.picker.explorer() end,
        desc = 'Open [F]ile [E]xplorer',
      },
    },
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      explorer = {
        replace_netrw = true,
      },
      input = {
        enabled = true,
      },
      notifier = {
        enabled = true,
      },
      picker = {
        layouts = {
          sidebar = {
            layout = {
              position = 'right',
              width = 32,
            },
          },
        },
      },
    },
  },
}
