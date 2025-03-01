return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 999,
    -- stylua: ignore
    keys = {
      {
        '<leader>n',
        function()
          Snacks.picker.notifications()
        end,
        desc = 'Show [N]otifications',
      },
      {
        '<leader><space>',
        function ()
          Snacks.picker.files()
        end,
        desc = 'Find files',
      },
      {
        '<leader>fe',
        function()
          Snacks.explorer({
            follow_file = true,
          })
        end,
        desc = 'Open [F]ile [E]xplorer',
      },
      {
        '<leader>ff',
        function ()
          Snacks.picker.buffers()
        end,
        desc = 'Find Bu[ff]ers',
      },
      {
        '<leader>fg',
        function ()
          Snacks.picker.git_files()
        end,
        desc = '[F]ind Current [G]it Repo',
      },
      {
        '<leader>ss',
        function ()
          Snacks.picker.lsp_symbols()
        end,
        desc = '[S]earch Document [S]ymbols',
      },
      {
        '<leader>sS',
        function ()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = '[S]earch Workspace [S]ymbols',
      },
      {
        '<leader>sw',
        function ()
          Snacks.picker.grep_word()
        end,
        desc = '[S]earch by [W]ord',
      },
      {
        '<C-f>',
        function ()
          Snacks.picker.grep()
        end,
        desc = 'Live grep',
      },
      {
        '<C-p>',
        function ()
          Snacks.picker.projects()
        end,
        desc = 'Projects',
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
      image = {
        enabled = true,
        doc = {
          enabled = true,
        },
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
        matcher = {
          frecency = true,
        },
      },
    },
  },
}
