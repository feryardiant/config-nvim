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
        '<leader>sw',
        function ()
          Snacks.picker.grep_word()
        end,
        desc = '[S]earch by [W]ord',
      },
      {
        '<leader>gg',
        function ()
          Snacks.lazygit({
            win = { border = 'rounded' },
          })
        end,
        desc = 'Open LazyGit',
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
      {
        '<C-`>',
        function ()
          Snacks.terminal()
        end,
        desc = 'Toggle Terminal',
      },
      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = '[G]oto [D]efinition' },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = '[G]oto [D]eclaration' },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = '[G]oto [R]eferences' },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = '[G]oto [I]mplementation' },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = '[G]oto T[y]pe Definition' },
      { '<leader>ss', function () Snacks.picker.lsp_symbols() end, desc = '[S]earch Document [S]ymbols' },
      { '<leader>sS', function () Snacks.picker.lsp_workspace_symbols() end, desc = '[S]earch Workspace [S]ymbols' },
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
      statuscolumn = {
        enabled = true,
      },
      terminal = {},
    },
  },
}
